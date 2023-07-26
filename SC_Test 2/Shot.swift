//
//  Shot.swift
//  SC_Test 2
//
//  Created by Uday Sidhu on 24/07/23.
//

import Foundation
import CoreLocation
struct Shot: Identifiable {
    var id = UUID()
    var startLoc = CLLocation(latitude: 0, longitude: 0)
    var endLoc = CLLocation(latitude: 0, longitude: 0)
    var distance = 0.0
    var club = "1W"
}
