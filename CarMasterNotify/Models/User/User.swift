//
//  User.swift
//  CarMasterNotify
//
//  Created by Admin on 22.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import CoreData
import RxSwift

extension User {

    static var currentUser: User? {
        let context = DataController.shared.main
        let request = NSFetchRequest<User>(entityName: String(describing: self))
        request.sortDescriptors = []
        let user = try? context.fetch(request).first
        return user
    }
}
