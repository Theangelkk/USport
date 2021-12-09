//
//  Healthkit.swift
//  USport
//
//  Created by Raffaele Calcagno on 07/12/21.
//

import SwiftUI
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

struct Healthkit: View {
    
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Healthkit_Previews: PreviewProvider {
    static var previews: some View {
        Healthkit()
    }
}

//Classe HealthStore
class HealthStore : ObservableObject
{
    @Published var healthStore: HKHealthStore?
    @Published var query: HKStatisticsCollectionQuery?
    
    //inizzializzatore, controllo se i dati sanitari sono disponibili, se si creiamo un'istanza di salute
    init()
    {
        if HKHealthStore.isHealthDataAvailable()
        {
            healthStore = HKHealthStore()
        }
    }
    
    //accedere ai dati
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)

        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
    }

    func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection, n_days_prev : Int, end : Date) -> [Step]
    {
        var steps : [Step] = [Step]()
        
        let startDate = Calendar.current.date(byAdding: .day, value: n_days_prev, to: end)!
        
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate)
        {
            (statistics, stop) in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            
            steps.append(step)
        }
        
        return steps
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!

        guard let healthStore = self.healthStore
        
        else { return completion(false)}
        
        healthStore.requestAuthorization(toShare: [], read: [stepType])
        {
            (success, error) in
            
            completion(success)
        }
    }
    
    func authorizeHealthKitAccess(toRead readable: Set<HKObjectType>?, toWrite writable: Set<HKSampleType>?, completion: @escaping (Bool, HKError.Code?) -> Void)
    {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, .errorHealthDataUnavailable)
            return
        }
    }
}
