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
    func removeItems(at offsets: IndexSet){
        shots.shots.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationView {
            List{
                ForEach(shots.shots){shot in
                    HStack{
                        VStack(alignment: .leading){
                            Text("Club: \(shot.clubDisplayName)").bold()
                            Text("Distance \(shot.distance, specifier: "%.2f" )")
                        }
                        Spacer()
                        VStack(alignment: .trailing){
                            Text(shot.date, format: .dateTime.minute().hour())
                            Text(shot.date, format: .dateTime.day().month(.abbreviated))
                            
                        }.foregroundColor(.secondary)
                        
                    }
                }
                .onDelete(perform: removeItems)
            }
            .padding(.top)
            .navigationTitle("Shot History")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
                
            }
        }
    }
}

