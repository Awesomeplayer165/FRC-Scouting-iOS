//
//  TeleopView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI
import SPIndicator

struct TeleopView: View {
    @State private var isFinishViewPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var matchDetails: MatchDetails
    
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator  = UIImpactFeedbackGenerator(style: .heavy)
    
    private let rectangleCornerRadius: CGFloat = 10
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.red)
                        .cornerRadius(rectangleCornerRadius)
                    VStack {
                        Spacer()
                        
                        Text("Teleop Miss")
                            .font(.largeTitle)
                        Text("\(matchDetails.teleopFailure)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        Button("Subtract") {
                            if matchDetails.teleopFailure > 0 {
                                matchDetails.teleopFailure -= 1
                                notificationGenerator.notificationOccurred(.warning)
                            } else {
                                notificationGenerator.notificationOccurred(.error)
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                    .foregroundColor(.white)
                }
                .onTapGesture {
                    matchDetails.teleopFailure += 1
                    mediumImpactGenerator.impactOccurred()
                }
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.green)
                        .cornerRadius(rectangleCornerRadius)
                    VStack {
                        Spacer()
                        
                        Text("Teleop Success")
                            .font(.largeTitle)
                        Text("\(matchDetails.teleopSuccess)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        Button("Subtract") {
                            if matchDetails.teleopSuccess > 0 {
                                matchDetails.teleopSuccess -= 1
                                notificationGenerator.notificationOccurred(.warning)
                            } else {
                                notificationGenerator.notificationOccurred(.error)
                            }
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                    .foregroundColor(.white)
                }
                .onTapGesture {
                    matchDetails.teleopSuccess += 1
                    mediumImpactGenerator.impactOccurred()
                }
            }
            .ignoresSafeArea()
            
            Button(action: {
                isFinishViewPresented.toggle()
                heavyImpactGenerator.impactOccurred()
            }) {
                HStack {
                    Spacer()
                    Text("Finish")
                    Spacer()
                }
            }
            .buttonStyle(.borderedProminent)
            
            NavigationLink(destination: PostMatchView(), isActive: $isFinishViewPresented) { }
                .frame(width: 0, height: 0)
        }
        .onAppear {
            AppDelegate.setOrientationLock(.landscapeLeft, orientationMask: .landscape)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitle("Team: \(matchDetails.teamNumber)")
        .navigationViewStyle(.stack)
    }
}


struct TeleopView_Previews: PreviewProvider {
    static var previews: some View {
        TeleopView()
            .environmentObject(MatchDetails(teamNumber: "8033"))
    }
}
