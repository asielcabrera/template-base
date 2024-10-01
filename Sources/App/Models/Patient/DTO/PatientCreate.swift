//
//  CreatePatient.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//

import protocol Vapor.Content

extension Patient {
    struct Create: Content {
        var name: String
        var age: String
        var address: String
    }

    convenience init(_ create: Create) {
       self.init(name: create.name, age: Int(create.age)!, gender: "", address: create.address)
    }
}


// {
//     "name": "AsielCabrera",
//     "email": "cabrerasiel@gmail.com",
//     "phone": "123123123123",
//     "address": "11615 sw 170st, Miami, fl, 33157",
//     "age": "213"
// }