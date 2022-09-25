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
}

extension String {
    func isMatchDetailsNumberValid() -> Bool {
//        return !(self.isEmpty || Int(self) == 0)
        
        if self.isEmpty        { return false }
        if Int(self) ?? 0 == 0 { return false }
        else                   { return true }
    }
}

struct ContentView: View {
    @State private var matchNumber = ""
    @State private var teamNumber  = ""
    @State private var name        = ""
    
    @State private var isAutoViewPresented = false
    @State private var isErrorAlertShown   = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Match #", text: $matchNumber)
                    TextField("Team #",  text: $teamNumber)
                    TextField("Name",    text: $name)
                } header: {
                    Text("Pre-Match")
                }
                
                Button(action: {
                    MatchDetails.shared.matchNumber = matchNumber
                    MatchDetails.shared.teamNumber  = teamNumber
                    MatchDetails.shared.name        = name
                    
                    MatchDetails.shared.isMetaMatchDetailsValid() ? isAutoViewPresented.toggle() : isErrorAlertShown.toggle()
                }) {
                    HStack {
                        Spacer()
                        Text("Start")
                        Spacer()
                    }
                }
                .sheet(isPresented: $isAutoViewPresented) {
                    GameReadyView()
                }
                .alert("Error in Match Meta", isPresented: $isErrorAlertShown, actions: {}, message: { Text("Error in Match Meta Details. Check if values are empty?") })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
