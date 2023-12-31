//
//  ContentView.swift
//  SC_Test 2
//
//  Created by Uday Sidhu on 24/07/23.
//

import SwiftUI
import CoreLocation
import Foundation

struct ContentView: View {
    @StateObject var shots = Shots()
    @ObservedObject var locationManager = LocationManager.shared
    @State private var isPressed = false
    @State private var club = "Driver"
    @State private var showingAlert = false
    @State var displayAverage = 0.0
    @State var isShowingHistory = false
    let clubs = ["Driver","2 Wood","3 Wood","3 Iron","4 Iron","5 Iron","6 Iron","7 Iron","8 Iron","9 Iron","PW","SW"]
    func getLocation() -> CLLocation{
        if let location = locationManager.userLocation{
            return location
        }
        return CLLocation(latitude: 0, longitude: 0)
    }
    func addShot(){
        let shot = Shot()
        shots.shots.insert(shot, at: 0)
    }
    func setStartLoc(){
        let startLoc = getLocation()
        shots.shots[0].startLat = startLoc.coordinate.latitude
        shots.shots[0].startLong = startLoc.coordinate.longitude
        
    }
    func setEndLoc(){
        let endLoc = getLocation()
        let startLoc = CLLocation(latitude: shots.shots[0].startLat, longitude: shots.shots[0].startLong)
        shots.shots[0].date = Date.now
        shots.shots[0].endLat = endLoc.coordinate.latitude
        shots.shots[0].endLong = endLoc.coordinate.longitude
        shots.shots[0].endLong = endLoc.coordinate.longitude
        shots.shots[0].distance = (startLoc.distance(from: endLoc)) * 1.094
        shots.shots[0].club = club
        if shots.shots[0].distance <= 5{
            shots.shots.remove(at: 0)
            showingAlert = true
        }
        
        
    }
    func getAvg(parClub:String) {
        var avg = 0.0
        var counter = 0
        for i in shots.shots{
            if i.club == parClub{
                avg = avg + i.distance
                counter = counter + 1
            }
        }
        if counter == 0{
            self.displayAverage = 0
        }
        else{
            self.displayAverage = avg/Double(counter)
        }
        
    }
    var body: some View {
        NavigationView{
            ZStack{
                BackgroundView()
                if locationManager.userLocation == nil{
                    LocationRequestView()
                }
                else{
                    VStack{
                        Image("SugarCaddyLogo").resizable().scaledToFit().frame(width: 200).padding(.bottom)
                        VStack(spacing: 0){
                            Picker("Club Selection", selection: $club){
                                ForEach(clubs, id: \.self){club in
                                    Text(club).foregroundColor(.whiteForeground)
                                }
                            }
                            Text(displayAverage == 0.0 ? "\(club) Average: N/A":"\(club) Average: \(displayAverage, specifier: "%.1f") yd")
                                .foregroundColor(.whiteForeground)
                                .padding(.top,70)
                                .padding(.bottom)
                        }
                        .pickerStyle(.wheel)
                        .onChange(of: club) { newValue in
                            getAvg(parClub: club)
                        }
                        
                        if let currShot = shots.shots.first{
                            
                            VStack{
                                Text("Shot Distance: ")
                                    .font(.headline)
                                    .foregroundColor(.lightForeground).padding(.bottom, 5)
                                if !isPressed{
                                    HStack(alignment: .bottom){
                                        Text("**\(currShot.distance, specifier: "%.1f")**")
                                            .font(.system(size: 44))
                                        Text("yards")
                                            .font(.footnote)
                                            .offset(y:-10)
                                    }.foregroundColor(.whiteForeground)
                                }
                                else{
                                    Text("In progress...")
                                        .font(.system(size: 44))
                                }
                                // Text(currShot.endLat != 0.0 ? "Club used: \(currShot.club)" : "  ")
                            }.foregroundColor(.whiteForeground)
                        }
                        else{
                            Text("Shot Distance: ").padding(.bottom,5)
                            HStack(alignment: .bottom){
                                Text("**\(0, specifier: "%.1f")**")
                                    .bold()
                                    .font(.system(size: 44))
                                Text("yards")
                                    .font(.footnote)
                                    .offset(y:-10)
                            }.foregroundColor(.whiteForeground)
                        }
                        
                        Button {
                            if !isPressed{
                                addShot()
                                setStartLoc()
                            }
                            else{
                                setEndLoc()
                                getAvg(parClub: club)
                            }
                            isPressed.toggle()
                        } label: {
                            Text( isPressed ? "End Shot" : "Begin Shot")
                                .padding()
                                .foregroundColor(.whiteForeground)
                                .font(.headline)
                                .frame(width: UIScreen.main.bounds.width)
                                .padding(.horizontal, -32)
                                .background(.lightForeground)
                                .clipShape(Capsule())
                        }.padding(.bottom, 20)
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            Button {
                                isShowingHistory = true
                            } label: {
                                HStack{
                                    //Text("History")
                                    Image(systemName: "list.bullet")
                                }.foregroundColor(.lightForeground)
                            }
                        }
                        
                    }
                }
                
            }
            .onAppear{
                getAvg(parClub: club)
            }
            
            
        }.preferredColorScheme(.dark)
        
            .sheet(isPresented: $isShowingHistory, onDismiss: {
                getAvg(parClub: club)
            }, content: {
                ShotHistoryView(shots: shots)
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Shot Not Recorded"), message: Text("Unrealistically low distance"), dismissButton: .default(Text("Dismiss")))
            }
    }
    
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
