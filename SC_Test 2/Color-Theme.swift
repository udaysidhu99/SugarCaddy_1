//
//  Color-Theme.swift
//  Sugar Caddy
//
//  Created by Uday Sidhu on 27/07/23.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color{
    static var darkBackground: Color{
        Color(red: 0.1529, green: 0.1529, blue: 0.1529)
    }
    
    static var lightForeground: Color{
        Color(red:1, green: 0.447, blue: 0.623)
    }
    static var whiteForeground: Color{
        Color(red:0.968, green: 0.968, blue: 0.949)
        }
}
