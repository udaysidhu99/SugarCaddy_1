//
//  LocationRequestView.swift
//  LocationTest1
//
//  Created by Uday Sidhu on 17/07/23.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        VStack{
            Text("Please provide location permission")
            Button {
                LocationManager.shared.requestLocation()
            } label: {
                
                Text("Allow Location")
                    .padding()
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.horizontal, -32)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                
            }
            
            
            
            
            
        }
    }
    
    struct LocationRequestView_Previews: PreviewProvider {
        static var previews: some View {
            LocationRequestView()
        }
    }
}
