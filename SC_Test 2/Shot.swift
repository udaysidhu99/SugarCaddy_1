//
//  Shot.swift
//  SC_Test 2
//
//  Created by Uday Sidhu on 24/07/23.
//

import Foundation
import CoreLocation
struct Shot: Identifiable, Codable {
    var id = UUID()
    var startLat = 0.0
    var startLong = 0.0
    var date = Date.now
    var endLat = 0.0
    var endLong = 0.0
    var distance = 0.0
    var club = "1W"
    var clubDisplayName: String{
        switch self.club{
        case "1W":
            return "Driver"
        case "2W":
            return "2 Wood"
        case "3W":
            return "3 Wood"
        case "3":
            return "3 Iron"
        case "4":
            return "4 Iron"
        case "5":
            return "5 Iron"
        case "6":
            return "6 Iron"
        case "7":
            return "7 Iron"
        case "8":
            return "8 Iron"
        case "9":
            return "9 Iron"
        case "PW":
            return "PW"
        case "SW":
            return "SW"
        default:
            return " "
        }
    }
}
