//
//  ContentView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI

class MatchDetails {
    public static let shared = MatchDetails()
    
    public var matchNumber = String()
    public var teamNumber  = String()
    public var name        = String()
    
    public var autoSuccess = Int.zero
    public var autoFailure = Int.zero
    
    public var teleopSuccess = Int.zero
    public var teleopFailure = Int.zero
    
    public var notes = ""
    
    public func isMetaMatchDetailsValid() -> Bool {
        return matchNumber.isMatchDetailsNumberValid() ||
               teamNumber .isMatchDetailsNumberValid()   ||
               !name       .isEmpty
    }
    
    public func clear() {
        matchNumber = String()
        teamNumber  = String()
        name        = String()
        
        autoSuccess = Int.zero
        autoFailure = Int.zero
        
        teleopSuccess = Int.zero
        teleopFailure = Int.zero
        
        notes = ""
    }
}

extension String {
    func isMatchDetailsNumberValid() -> Bool {
        if self.isEmpty        { return false }
        if Int(self) ?? 0 == 0 { return false }
        else                   { return true }
    }
}

struct ContentView: View {
    @State private var matchNumber = ""
    @State private var teamNumber  = ""
    @State private var name        = ""
    
    @State private var isErrorAlertShown   = false
    @AppStorage("isGameReadyViewPresented", store: .standard) private var isGameReadyViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Match #", text: $matchNumber)
                        TextField("Team #",  text: $teamNumber)
                        TextField("Name",    text: $name)
                    } header: {
                        Text("Pre-Match")
                    }
                    
                    NavigationLink(destination: GameReadyView(), isActive: $isGameReadyViewPresented) {
                        Button(action: {
                            MatchDetails.shared.matchNumber = matchNumber
                            MatchDetails.shared.teamNumber  = teamNumber
                            MatchDetails.shared.name        = name
                            
                            MatchDetails.shared.isMetaMatchDetailsValid() ? isGameReadyViewPresented.toggle() : isErrorAlertShown.toggle()
                        }) {
                            HStack {
                                Spacer()
                                Text("Start")
                                Spacer()
                            }
                        }
                    }
                    .alert("Error in Match Meta", isPresented: $isErrorAlertShown, actions: {}, message: { Text("Error in Match Meta Details. Check if values are empty?") })
                    
                    Section {
                        Button("Clear Match Data") {
                            MatchDetails.shared.clear()
                        }
                        Link("Open Empty Google Form Link", destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfZSne2CzACrxsFgdT-37J6PylON7bIMe0mcACFKxDr9yv56A/viewform")!)
                    } header: { Text("Debug") }
                }
            }
        }
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
