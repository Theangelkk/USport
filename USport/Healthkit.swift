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

//Classe HealthStore
class HealthStore : ObservableObject
{
    @Published var healthStore: HKHealthStore?
    @Published var query: HKStatisticsCollectionQuery?
    
    @Published var start_date : Date
    @Published var end_date : Date
    
    @Published var steps : [Step]
    
    //inizzializzatore, controllo se i dati sanitari sono disponibili, se si creiamo un'istanza di salute
    init()
    {
        self.start_date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        self.end_date = Date()
        
        self.steps = [Step]()
        
        if HKHealthStore.isHealthDataAvailable()
        {
            healthStore = HKHealthStore()
            self.getHealthKitPermission()
            self.loadSteps()
        }
    }
    
    func loadSteps()
    {
        self.start_date = Calendar.current.date(byAdding: .day, value: -90, to: Date())!
        
        self.end_date = Date()
        
        if let healthStore = healthStore
        {
            self.requestAuthorization
            {
                success in
                
                if success
                {
                    // Andiamo a richiamare la Query
                    self.query_calculateSteps
                    {
                        // Contenitore delle statisitche
                        statisticsCollection in
                        
                        if let statisticsCollection = statisticsCollection
                        {
                            print(statisticsCollection)
                            
                            self.steps = self.enum_Statistics(statisticsCollection)
                            
                            print(self.steps)
                            print(self.steps.count)
                        }
                    }
                }
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    {
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!

        guard let healthStore = self.healthStore
        
        else { return completion(false)}
        
        healthStore.requestAuthorization(toShare: [], read: [stepType])
        {
            (success, error) in
            
            print(error)
            
            completion(success)
        }
    }
    
    
    /*
        HKStatisticsCollection è il contenitore di tutti gli elementi di HealthKit giorno per giorno
     
        Se ad esempio vogliamo le statistiche di 7 giorni fa, possiamo enumerate questi oggetti
        attraverso questa istanza.
     
        IMPORTANTE: Questa funzione può essere richiamata solo quando siamo davvero autorizzati.
     */
    func query_calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void)
    {
    
        // Definiamo la tipologia di dati che vogliamo chiedere ad HealthKit
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        // A che ora del giorno devono iniziare le statistiche --> da controllare se va bene per noi
        let anchorDate = Date.mondayAt12AM()
        
        let daily = DateComponents(day: 1)

        // Query che andiamo a sottomettere la Query ad HealthKit, definiendo che i campioni sono accessibili
        let predicate = HKQuery.predicateForSamples(withStart: self.start_date, end: self.end_date, options: .strictStartDate)
        
        // Esecuzione della Query
        // L'opzione .cumulativeSum --> indica che il contapassi proviene da qualsiasi dispositivo Apple
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + 0.5)
        {
            self.query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
            
            // Hendler per l'esecuzione della query
            self.query!.initialResultsHandler =
            {
                query, statisticsCollection, error in
                
                DispatchQueue.main.async {
                    completion(statisticsCollection)
                }
                
            }
        }
        
        // Vera e propria esecuzione della query
        if let healthStore = self.healthStore, let query = self.query
        {
            healthStore.execute(query)
        }
    }
    
    /*
        Questa funzione ci permette di andare a prendere ogni singolo elemento di HKStatisticsCollection
     */
    func enum_Statistics(_ statisticsCollection: HKStatisticsCollection) -> [Step]
    {
        self.steps = [Step]()
        
        var start_date = Calendar.current.date(byAdding: .day, value: -90, to: Date())!
        
        // Andiamo ad enumerare ogni singolo oggetto di HKStatisticsCollection
        statisticsCollection.enumerateStatistics(from: start_date, to: Date())
        {
            (statistics, stop) in
            
            // Andiamo a contare il numero di passi di un giorno
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            
            self.steps.append(step)
        }
        
        return self.steps
    }
    
    func getHealthKitPermission()
    {
        DispatchQueue.main.asyncAfter(deadline: .now())
        {
            guard HKHealthStore.isHealthDataAvailable() else {
                return
            }

            let stepsCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!

            self.healthStore!.requestAuthorization(toShare: [], read: [stepsCount]) { (success, error) in
                if success {
                    print("Permission accept.")
                }
                else {
                    if error != nil {
                        print(error ?? "")
                    }
                    print("Permission denied.")
                }
            }
        }
    }

    // Tieni a notare che qui è stato restituito un Double
    func getStepsCount(forSpecificDate:Date, completion: @escaping (Double) -> Void)
    {
        DispatchQueue.main.async
        {
            let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
            let (start, end) = self.getWholeDate(date: forSpecificDate)

            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)

            let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
                guard let result = result, let sum = result.sumQuantity() else {
                    completion(0.0)
                    return
                }
                completion(sum.doubleValue(for: HKUnit.count()))
            
            }
            self.healthStore!.execute(self.query!)
        }
    }

    func getWholeDate(date : Date) -> (startDate:Date, endDate: Date)
    {
        var startDate = date
        var length = TimeInterval()
        _ = Calendar.current.dateInterval(of: .day, start: &startDate, interval: &length, for: startDate)
        let endDate:Date = startDate.addingTimeInterval(length)
        return (startDate,endDate)
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
        let healthKitTypesToRead: Set<HKSampleType> = [stepType]

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
                    
                    print(step)
                    
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
