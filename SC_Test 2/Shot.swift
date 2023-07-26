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
    var endLat = 0.0
    var endLong = 0.0
    var distance = 0.0
    var club = "1W"
}
