//
//  PostMatchView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct PostMatchView: View {
    @State private var isSafariViewControllerPresented = false
    
    @AppStorage("isGameReadyViewPresented", store: .standard) private var isGameReadyViewPresented = false
    @AppStorage("isAutoViewPresented", store: .standard) private var isAutoViewPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var matchDetails: MatchDetails
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $matchDetails.climberPosition, label: Text("Climber Position")) {
                    Text(ClimberPosition.noClimb  .localizedDescription).tag(ClimberPosition.noClimb)
                    Text(ClimberPosition.low      .localizedDescription).tag(ClimberPosition.low)
                    Text(ClimberPosition.mid      .localizedDescription).tag(ClimberPosition.mid)
                    Text(ClimberPosition.high     .localizedDescription).tag(ClimberPosition.high)
                    Text(ClimberPosition.traversal.localizedDescription).tag(ClimberPosition.traversal)
                }
            }
            
            Section {
                HStack {
                    Text("Match Number")
                    Spacer()
                    Text(matchDetails.matchNumber)
                    ClipboardButton(textToCopy: matchDetails.matchNumber)
                }
                HStack {
                    Text("Team Number \(matchDetails.teamNumber)")
                    Spacer()
                    Text(matchDetails.teamNumber)
                    ClipboardButton(textToCopy: matchDetails.teamNumber)
                }
                
                HStack {
                    Text("Name")
                    Spacer()
                    Text(matchDetails.name)
                    ClipboardButton(textToCopy: matchDetails.name)
                }
                
                HStack {
                    Text("Auto Success")
                    Spacer()
                    Text("\(matchDetails.autoSuccess)")
                    ClipboardButton(textToCopy: "\(matchDetails.autoSuccess)")
                }
                
                HStack {
                    Text("Auto Failure")
                    Spacer()
                    Text("\(matchDetails.autoFailure)")
                    ClipboardButton(textToCopy: "\(matchDetails.autoFailure)")
                }
                
                HStack {
                    Text("Teleop Success")
                    Spacer()
                    Text("\(matchDetails.teleopSuccess)")
                    ClipboardButton(textToCopy: "\(matchDetails.matchNumber)")
                }
                
                HStack {
                    Text("Teleop Failure")
                    Spacer()
                    Text("\(matchDetails.teleopFailure)")
                    ClipboardButton(textToCopy: "\(matchDetails.teleopFailure)")
                }
            }
            
            Section {
                if #available(iOS 16, *) {
                    TextField("Notes", text: $matchDetails.notes, axis: .vertical)
                } else {
                    TextField("Notes", text: $matchDetails.notes)
                }
            }
            
            Button(action: { isSafariViewControllerPresented.toggle() }) {
                Label("Open Google Form", systemImage: "link")
            }
            .sheet(isPresented: $isSafariViewControllerPresented, onDismiss: {
                isGameReadyViewPresented.toggle()
                isAutoViewPresented.toggle()
            }) {
                SafariView(url: createURL(), safariViewControllerDidDismiss: $isSafariViewControllerPresented)
            }
            .onAppear {
                AppDelegate.orientationLock = .all
                AppDelegate.setOrientationLock(.portrait, orientationMask: .all)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Post-Match")
        .toolbar {
            ToolbarItem {
                CloseButtonView(presentationMode: presentationMode, action: { isGameReadyViewPresented.toggle() })
            }
        }
    }
        
        func createURL() -> URL {
            return URL(string: "https://google.com")!
            //        if
            //            let
            
            //        return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfZSne2CzACrxsFgdT-37J6PylON7bIMe0mcACFKxDr9yv56A/viewform?usp=pp_url&entry.2125038000=\(matchDetails.teamNumber)&entry.685765925=\(matchDetails.matchNumber)&entry.2138351230=\(name)&entry.307342493=\(matchDetails.autoSuccess)&entry.325851281=\(matchDetails.autoFailure)&entry.585797499=\(matchDetails.teleopSuccess)&entry.1258824098=\(matchDetails.teleopFailure)&entry.1181924470=\(selectedClimberPosition.formDescription)&entry.1505471002=\(MatchDetails.shared.notes.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&usp=embed_facebook")!
            
        }
    }


struct PostMatchView_Previews: PreviewProvider {
    static var previews: some View {
        PostMatchView()
            .environmentObject(MatchDetails())
    }
}

struct ClipboardButton: View {
    var textToCopy: String
    
    var body: some View {
        Button(action: { UIPasteboard.general.setValue(textToCopy, forPasteboardType: UTType.plainText.identifier) }) {
            Image(systemName: "doc.on.clipboard")
        }
    }
}
