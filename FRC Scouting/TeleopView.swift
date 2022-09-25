//
//  TeleopView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI
import SPIndicator

struct TeleopView: View {
    @State private var teleopSuccess = 0
    @State private var teleopFailure = 0
    
    @State private var isFinishViewPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
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
                        Text("\(teleopFailure)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        Button("Subtract") {
                            if teleopFailure > 0 {
                                teleopFailure -= 1
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
                    teleopFailure += 1
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
                        Text("\(teleopSuccess)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        Button("Subtract") {
                            if teleopSuccess > 0 {
                                teleopSuccess -= 1
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
                    teleopSuccess += 1
                    mediumImpactGenerator.impactOccurred()
                }
            }
            .ignoresSafeArea()
            
            Button(action: {
                MatchDetails.shared.teleopSuccess = teleopSuccess
                MatchDetails.shared.teleopFailure = teleopFailure
                
                isFinishViewPresented.toggle()
                heavyImpactGenerator.impactOccurred()
            }, label: {
                HStack {
                    Spacer()
                    Text("Finish")
                    Spacer()
                }
            })
            .buttonStyle(.borderedProminent)
            
            NavigationLink(destination: PostMatchView(), isActive: $isFinishViewPresented) { EmptyView() }
                .frame(width: 0, height: 0)
        }
        .onAppear {
            AppDelegate.setOrientationLock(.landscapeLeft, orientationMask: .landscape)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitle("Team: \(MatchDetails.shared.teamNumber)")
        .navigationViewStyle(.stack)
    }
}


struct TeleopView_Previews: PreviewProvider {
    static var previews: some View {
        TeleopView()
            .onAppear {
                MatchDetails.shared.teamNumber = "8033"
            }
    }
}
