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
    
    init()
    {
        self.UserAPP = User()
    }
}
