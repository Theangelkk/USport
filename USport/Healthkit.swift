//
//  Healthkit.swift
//  USport
//
//  Created by Raffaele Calcagno on 07/12/21.
//

import SwiftUI
import HealthKit

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



class HealthStore {
    var healthStore: HKHealthStore?
    //Inizzializzatore per ogni nuova istanza creata
    init() {
        //Controllo se i dati sanitari sono disponibili
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
}
