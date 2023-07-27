//
//  BackgroundView.swift
//  Sugar Caddy
//
//  Created by Uday Sidhu on 27/07/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack{
            Color.darkBackground.ignoresSafeArea()
            VStack{
                Spacer()
                VStack{
                    
                }
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
                .cornerRadius(40)
            }.ignoresSafeArea()
            
            
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
