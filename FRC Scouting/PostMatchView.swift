//
//  PostMatchView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct PostMatchView: View {
    @State private var selectedClimberPosition = ClimberPosition.noClimb
    @State private var notes = ""
    
    @State private var isSafariViewControllerPresented = false
    
    @AppStorage("isGameReadyViewPresented", store: .standard) private var isGameReadyViewPresented = false
    @AppStorage("isAutoViewPresented", store: .standard) private var isAutoViewPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                HStack {
                    Text("Match Number")
                    Spacer()
                    Text(MatchDetails.shared.matchNumber)
                    ClipboardButton(textToCopy: MatchDetails.shared.matchNumber)
                }
                HStack {
                    Text("Team Number \(MatchDetails.shared.teamNumber)")
                    Spacer()
                    Text(MatchDetails.shared.teamNumber)
                    ClipboardButton(textToCopy: MatchDetails.shared.teamNumber)
                }
                
                HStack {
                    Text("Name")
                    Spacer()
                    Text(MatchDetails.shared.name)
                    ClipboardButton(textToCopy: MatchDetails.shared.name)
                }
                    
                HStack {
                    Text("Auto Success")
                    Spacer()
                    Text("\(MatchDetails.shared.autoSuccess)")
                    ClipboardButton(textToCopy: "\(MatchDetails.shared.autoSuccess)")
                }
                
                HStack {
                    Text("Auto Failure")
                    Spacer()
                    Text("\(MatchDetails.shared.autoFailure)")
                    ClipboardButton(textToCopy: "\(MatchDetails.shared.autoFailure)")
                }
                    
                HStack {
                    Text("Teleop Success")
                    Spacer()
                    Text("\(MatchDetails.shared.teleopSuccess)")
                    ClipboardButton(textToCopy: "\(MatchDetails.shared.matchNumber)")
                }
                
                HStack {
                    Text("Teleop Failure")
                    Spacer()
                    Text("\(MatchDetails.shared.teleopFailure)")
                    ClipboardButton(textToCopy: "\(MatchDetails.shared.teleopFailure)")
                }
            }
            
            Section {
                if #available(iOS 16, *) {
                    TextField("Notes", text: $notes, axis: .vertical)
                } else {
                    TextField("Notes", text: $notes)
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
        MatchDetails.shared.notes = notes
        
        return URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfZSne2CzACrxsFgdT-37J6PylON7bIMe0mcACFKxDr9yv56A/viewform?usp=pp_url&entry.2125038000=\(MatchDetails.shared.teamNumber.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&entry.685765925=\(MatchDetails.shared.matchNumber.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&entry.2138351230=\(MatchDetails.shared.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&entry.307342493=\(MatchDetails.shared.autoSuccess)&entry.325851281=\(MatchDetails.shared.autoFailure)&entry.585797499=\(MatchDetails.shared.teleopSuccess)&entry.1258824098=\(MatchDetails.shared.teleopFailure)&entry.1181924470=\(selectedClimberPosition.formDescription)&entry.1505471002=\(MatchDetails.shared.notes.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&usp=embed_facebook")!
    }
}

struct PostMatchView_Previews: PreviewProvider {
    static var previews: some View {
        PostMatchView()
            .onAppear {
                MatchDetails.exampleData()
            }
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
