//
//  GameReadyView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI

struct GameReadyView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @AppStorage("isAutoViewPresented", store: .standard) private var isAutoViewPresented = false
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: AutoView(), isActive: $isAutoViewPresented) {
                Button(action: { isAutoViewPresented.toggle() }) {
                    Text("Ready!")
                        .font(.title)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                }
                .background {
                    Color.green
                }
                .cornerRadius(100)
                .padding()
            }
            
            Text("Click this \(Text("ONLY").bold()) when the actual game starts")
            
            Text("This relies on the game counter and time, so press this \(Text("ONLY").bold()) when you hear the oppening fanfare")
                .padding()
                .multilineTextAlignment(.center)
        }
        .onAppear {
            AppDelegate.setOrientationLock(.landscapeLeft, orientationMask: .landscape)
        }
//        .onDisappear {
//            AppDelegate.setOrientationLock(.portrait, orientationMask: .portrait)
//        }
    }
}

struct GameReadyView_Previews: PreviewProvider {
    static var previews: some View {
        GameReadyView()
    }
}
