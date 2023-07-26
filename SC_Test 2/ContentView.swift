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
    @State var isPressed = false
    @State var club = "1W"
    var clubDisplayName: String{
        switch club{
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
    @State var displayAverage = 0.0
    let clubs = ["1W","2W","3W","3","4","5","6","7","8","9","PW","SW"]
    func getLocation() -> CLLocation{
        if let location = locationManager.userLocation{
            return location
        }
        return CLLocation(latitude: 0, longitude: 0)
    }
    func addShot(){
        let shot = Shot()
        shots.shots.append(shot)
    }
    func setStartLoc(){
        let startLoc = getLocation()
        shots.shots[shots.shots.endIndex - 1].startLat = startLoc.coordinate.latitude
        shots.shots[shots.shots.endIndex - 1].startLong = startLoc.coordinate.longitude
      
    }
    func setEndLoc(){
        let endLoc = getLocation()
        let startLoc = CLLocation(latitude: shots.shots.last!.startLat, longitude: shots.shots.last!.startLong)
        shots.shots[shots.shots.endIndex - 1].endLat = endLoc.coordinate.latitude
        shots.shots[shots.shots.endIndex - 1].endLong = endLoc.coordinate.longitude
        shots.shots[shots.shots.endIndex - 1].distance = startLoc.distance(from: endLoc)
        shots.shots[shots.shots.endIndex - 1].club = club
//        print("Start Coordinates")
//        print(shots.shots[shots.shots.endIndex - 1].startLoc.coordinate.latitude)
//        print(shots.shots[shots.shots.endIndex - 1].startLoc.coordinate.longitude)
//        print("End Coordinates")
//        print(shots.shots[shots.shots.endIndex - 1].endLoc.coordinate.latitude)
//        print(shots.shots[shots.shots.endIndex - 1].endLoc.coordinate.longitude)
    
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
                if locationManager.userLocation == nil{
            LocationRequestView()
        }
        else{
            Spacer()
            VStack{
                VStack(spacing: 0){
                    Text(displayAverage == 0.0 ? " ":"Average for \(clubDisplayName): \(displayAverage, specifier: "%.2f")").font(.headline)
                    Picker("Club Selection", selection: $club){
                        ForEach(clubs, id: \.self){club in
                            Text(club)
                        }
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: club) { newValue in
                    getAvg(parClub: club)
                }
                }
                if let currShot = shots.shots.last{
                    VStack{
                        Text("Shot Distance: ")
                        if !isPressed{
                            Text("\(currShot.distance, specifier: "%.2f") m")
                                .font(.system(size: 44))
                        }
                        else{
                            Text("In progress...")
                                .font(.system(size: 44))
                        }
                       
                        Text(currShot.endLat != 0.0 ? "Club used: \(currShot.club)" : "  ")
                        
                        
                         
                    }
                }
                else{
                    Text("Last Shot Distance: ")
                    Text("\(0, specifier: "%.2f") m")
                        .font(.system(size: 44))
                }
                
                Spacer()
                Button {
                    if !isPressed{
                        addShot()
                        setStartLoc()
                    }
                    else{
                        setEndLoc()
                    }
                    isPressed.toggle()
                } label: {
                    Text( isPressed ? "End Shot" : "Begin Shot")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(width: UIScreen.main.bounds.width)
                                            .padding(.horizontal, -32)
                                            .background(Color(.systemBlue))
                                            .clipShape(Capsule())
                }
            }
        Spacer()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
