//
//  Healthkit.swift
//  USport
//
//  Created by Raffaele Calcagno on 07/12/21.
//

import SwiftUI
import HealthKit

extension Date {
    static func mondayAt12AM() -> Date
    {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

class HealthKitManager: ObservableObject
{
    let healthStore = HKHealthStore()
    
    let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
    @Published var isLoading = false

    @Published var steps = [Step]()
    @Published var updates = 0

    init()
    {
        self.healthStore.requestAuthorization(toShare: [], read: [stepType])
        {
            (success, error) in
            
            if let error = error
            {
                print("Error: \(error)")
            }
            else if success
            {
                self.startQuery()
            }
        }
    }
    
    func startQuery()
    {
       let now = Date()
            
            let cal = Calendar.current
            
            let sevenDaysAgo = cal.date(byAdding: .day, value: -90, to: now)!
            
            let startDate = cal.startOfDay(for: sevenDaysAgo)
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: [.strictStartDate, .strictEndDate])
            
            var interval = DateComponents()
            interval.day = 1
            
            // start from midnight
            let anchorDate = cal.startOfDay(for: now)
           
            let query = HKStatisticsCollectionQuery(
                quantityType: self.stepType,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: anchorDate,
                intervalComponents: interval
            )
            
            query.initialResultsHandler = { query, collection, error in
                guard let collection = collection else {
                    print("No collection")
                    DispatchQueue.main.async{
                        self.isLoading = false
                    }
                    return
                }
            
                collection.enumerateStatistics(from: startDate, to: Date())
                {
                    (statistics, stop) in
                    
                    // Andiamo a contare il numero di passi di un giorno
                    let count = statistics.sumQuantity()?.doubleValue(for: .count())
                    
                    let step = Step(count: Int(count ?? 0), date: statistics.startDate)
                
                    DispatchQueue.main.async{
                        self.steps.append(step)
                    }
                }
                
                print("initialResultsHandler done")
                
                DispatchQueue.main.async
                {
                    self.isLoading = false
                }
            }
        
            DispatchQueue.main.async
            {
                self.isLoading = true
            }
            
            self.healthStore.execute(query)
    }
}
