//
//  ManagerUser.swift
//  USport
//
//  Created by Angelo Casolaro on 09/12/21.
//

import Foundation

class ManagerUser : ObservableObject
{
    @Published var UserAPP : User
    @Published var steps : [Step]
    
    init()
    {
        self.UserAPP = User()
        self.steps = [Step]()
    }
}
