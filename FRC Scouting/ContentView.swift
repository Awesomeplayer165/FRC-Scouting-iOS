//
//  ContentView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI

extension String {
    func isMatchDetailsNumberValid() -> Bool {
        if self.isEmpty        { return false }
        if Int(self) ?? 0 == 0 { return false }
        else                   { return true }
    }
}

struct ContentView: View {
    @StateObject private var matchDetails = MatchDetails()
    @State private var isErrorAlertShown  = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        HStack {
                            TextField("Match #", text: $matchDetails.matchNumber)
                            Spacer()
                            Button("+1") {
                                matchDetails.matchNumber = "\((Int(matchDetails.matchNumber) ?? 0) + 1)"
                            }
                        }
                        TextField("Team #",  text: $matchDetails.teamNumber)
                        TextField("Name",    text: $matchDetails.name)
                    }
                    
                    Button(action: {
                        matchDetails.isMetaMatchDetailsValid() ? isGameReadyViewPresented.toggle() : isErrorAlertShown.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Text("Start")
                            Spacer()
                            
                            NavigationLink(destination: GameReadyView(), isActive: $isGameReadyViewPresented) { }
                                .frame(width: 0, height: 0)
                        }
                    }
                    .alert("Error in Match Meta", isPresented: $isErrorAlertShown, actions: {}, message: { Text("Error in Match Meta Details. Check if values are empty?") })
                    
                    Section {
                        Button("Clear Match Data") {
                            matchDetails.clear()
                            
                            matchDetails.matchNumber = ""
                            matchDetails.teamNumber  = ""
                        }
                        Link("Open Empty Google Form Link", destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfZSne2CzACrxsFgdT-37J6PylON7bIMe0mcACFKxDr9yv56A/viewform")!)
                    } header: { Text("Debug") }
                }
            }
        }
        .environmentObject(matchDetails)
        .navigationTitle("Pre-Match")
        .onAppear {
            isGameReadyViewPresented = false
            
            AppDelegate.orientationLock = .all
            AppDelegate.setOrientationLock(.portrait, orientationMask: .all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
