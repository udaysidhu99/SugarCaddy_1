//
//  ShotHistoryView.swift
//  SC_Test 2
//
//  Created by Uday Sidhu on 26/07/23.
//

import SwiftUI

struct ShotHistoryView: View {
    @ObservedObject var shots : Shots
    @Environment(\.dismiss) var dismiss
    @State private var selectedClub = "All"
    let clubs = ["All","Driver","2 Wood","3 Wood","3 Iron","4 Iron","5 Iron","6 Iron","7 Iron","8 Iron","9 Iron","PW","SW"]
    
    func removeItems(at offsets: IndexSet){
        shots.shots.remove(atOffsets: offsets)
    }
    var body: some View {
        
        NavigationView {
            ZStack{
                Color.darkBackground.ignoresSafeArea()
                VStack(alignment: .leading){
                    Picker("Club filter", selection: $selectedClub.animation()) {
                        ForEach(clubs, id: \.self){club in
                            Text(club).foregroundColor(.whiteForeground)
                        }
                    }
                    .accentColor(.lightForeground)
                        .padding(.horizontal)
                       
                    
                    if selectedClub == "All"{
                        List{
                            ForEach(shots.shots){shot in
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("Club: \(shot.club)").bold()
                                            Text("Distance \(shot.distance, specifier: "%.2f" )")
                                        }
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Text(shot.date, format: .dateTime.minute().hour())
                                            Text(shot.date, format: .dateTime.day().month(.abbreviated))
                                            
                                        }.foregroundColor(.secondary)
                                    }
                            }.onDelete(perform: removeItems)
                                .listRowBackground(Color.darkBackground)
                            
                        }
                        .padding(.top)
                        .navigationTitle("Shot History")
                        .toolbar {
                            Button {
                                dismiss()
                            } label: {
                                Text("Done")
                                    .bold()
                                    .foregroundColor(Color.lightForeground)
                            }
                        }
                    }
                    
                    else{
                        List{
                            ForEach(shots.shots){shot in
                                if shot.club == selectedClub{
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("Club: \(shot.club)").bold()
                                            Text("Distance \(shot.distance, specifier: "%.2f" )")
                                        }
                                        Spacer()
                                        VStack(alignment: .trailing){
                                            Text(shot.date, format: .dateTime.minute().hour())
                                            Text(shot.date, format: .dateTime.day().month(.abbreviated))
                                            
                                        }.foregroundColor(.secondary)
                                    }
                                }
                                
                            }.onDelete(perform: removeItems)
                                .listRowBackground(Color.darkBackground)
                            
                        }
                        .padding(.top)
                        .navigationTitle("Shot History")
                        .toolbar {
                            Button {
                                dismiss()
                            } label: {
                                Text("Done")
                                    .bold()
                                    .foregroundColor(Color.lightForeground)
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
}

