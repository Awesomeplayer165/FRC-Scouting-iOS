//
//  FinishedView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI

struct FinishedView: View {
    @State private var selectedClimberPosition = ClimberPosition.noClimb
    @State private var notes = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker(selection: $selectedClimberPosition, label: Text("Climber Position")) {
                            Text(ClimberPosition.noClimb  .localizedDescription).tag(ClimberPosition.noClimb)
                            Text(ClimberPosition.low      .localizedDescription).tag(ClimberPosition.low)
                            Text(ClimberPosition.mid      .localizedDescription).tag(ClimberPosition.mid)
                            Text(ClimberPosition.high     .localizedDescription).tag(ClimberPosition.high)
                            Text(ClimberPosition.traversal.localizedDescription).tag(ClimberPosition.traversal)
                        }
                    }
                    
                    Section {
                        Text("Match Number: \(MatchDetails.shared.matchNumber)")
                        Text("Team Number: \(MatchDetails.shared.teamNumber)")
                        Text("Name: \(MatchDetails.shared.name)")
                        
                        Text("Auto Success: \(MatchDetails.shared.autoSuccess)")
                        Text("Auto Failure: \(MatchDetails.shared.autoFailure)")
                        
                        Text("Teleop Success: \(MatchDetails.shared.teleopSuccess)")
                        Text("Teleop Failure: \(MatchDetails.shared.teleopFailure)")
                    } header: {
                        Text("Post-Match")
                    }
                    
                    Section {
                        if #available(iOS 16, *) {
                            TextField("Notes", text: $notes, axis: .vertical)
                        } else {
                            TextField("Notes", text: $notes)
                        }
                    }
                    
                    Link("Open Google Form", destination: createURL())
                }
            }
            .onAppear {
                AppDelegate.setOrientationLock(.portrait, orientationMask: .portrait)
            }
            .toolbar {
                ToolbarItem {
                    CloseButtonView(presentationMode: presentationMode)
                }
            }
        }
    }
    
    func createURL() -> URL {
        MatchDetails.shared.notes = notes
        return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfZSne2CzACrxsFgdT-37J6PylON7bIMe0mcACFKxDr9yv56A/viewform?usp=pp_url&entry.2125038000=\(MatchDetails.shared.teamNumber.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&entry.685765925=\(MatchDetails.shared.matchNumber.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&entry.2138351230=\(MatchDetails.shared.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&entry.307342493=\(MatchDetails.shared.autoSuccess)&entry.325851281=\(MatchDetails.shared.autoFailure)&entry.585797499=\(MatchDetails.shared.teleopSuccess)&entry.1258824098=\(MatchDetails.shared.teleopFailure)&entry.1181924470=\(selectedClimberPosition.formDescription)&entry.1505471002=\(MatchDetails.shared.notes.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&usp=embed_facebook")!
    }
}

struct FinishedView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedView()
    }
}
