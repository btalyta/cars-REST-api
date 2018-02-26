//
//  Car.swift
//  Cars
//
//  Created by Bárbara Souza on 26/02/18.
//  Copyright © 2018 Bárbara Souza. All rights reserved.
//

import Foundation

class Car: Codable {
    
    var _id: String?
    var gasType: Int = 0
    var brand: String = " "
    var name: String = " "
    var price: Double = 0.0
    
    var gas: String{
        switch gasType {
            case 0:
                return "Flex"
            case 1:
                return "Ethanol"
            case 2:
                return "Gas"
            default:
                return " "
        }
    }
}
