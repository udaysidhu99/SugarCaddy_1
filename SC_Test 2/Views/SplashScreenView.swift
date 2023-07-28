//
//  SplashScreenView.swift
//  Sugar Caddy
//
//  Created by Uday Sidhu on 27/07/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.8
    
    var body: some View {
        if isActive{
            ContentView()
        }
        else{
            ZStack{
                Color.darkBackground.ignoresSafeArea()
                VStack{
                    
                    VStack{
                        Image("SugarCaddyLogo")
                        Text("coded with love <3").foregroundColor(.whiteForeground).font(.footnote).opacity(0.5)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.size = 1.0
                            
                        }
                    }
                }
                .onAppear{
                    
                        withAnimation(Animation.easeIn.delay(2)){
                            self.isActive = true
                        }
                    
                }
            }
        }
    }
    
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
