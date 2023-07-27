//
//  LocationRequestView.swift
//  LocationTest1
//
//  Created by Uday Sidhu on 17/07/23.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        ZStack{
            Color.darkBackground.ignoresSafeArea()
            VStack(spacing: 50){
                Spacer()
                Image("SugarCaddyLogo").resizable().scaledToFit().frame(width: 200)
                Spacer()
                Image(systemName: "mappin.and.ellipse")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.whiteForeground)
                    .padding(.bottom)
                //Text("Allow location access while using Sugar Caddy")
                Button {
                    LocationManager.shared.requestLocation()
                } label: {
                    
                    Text("Allow Location")
                        .foregroundColor(.whiteForeground)
                        .padding()
                        .font(.headline)
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.horizontal, -32)
                        .background(.lightForeground)
                        .clipShape(Capsule())
                    
                    
                    
                }
                Spacer()
                
            }
        }
        
        
    }
}


struct LocationRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRequestView()
    }
}

