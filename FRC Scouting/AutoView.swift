//
//  ContentView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI

struct AutoView: View {
    @State private var autoSuccess = 0
    @State private var autoFailure = 0
    
    @State private var isTeleopViewPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator  = UIImpactFeedbackGenerator(style: .heavy)
    
    private let rectangleCornerRadius: CGFloat = 10
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.red)
                            .cornerRadius(rectangleCornerRadius)
                        VStack {
                            Spacer()
                            
                            Text("Auto Miss")
                                .font(.largeTitle)
                            Text("\(autoFailure)")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 50))
                            
                            Spacer()
                            
                            Button("Subtract") {
                                if autoFailure > 0 {
                                    autoFailure -= 1
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
                        autoFailure += 1
                        mediumImpactGenerator.impactOccurred()
                    }
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(rectangleCornerRadius)
                        VStack {
                            Spacer()
                            
                            Text("Auto Success")
                                .font(.largeTitle)
                            Text("\(autoSuccess)")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 50))
                            
                            Spacer()
                            
                            Button("Subtract") {
                                if autoSuccess > 0 {
                                    autoSuccess -= 1
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
                        autoSuccess += 1
                        mediumImpactGenerator.impactOccurred()
                    }
                }
                .ignoresSafeArea()
                
                Button(action: {
                    MatchDetails.shared.autoSuccess = autoSuccess
                    MatchDetails.shared.autoFailure = autoFailure
                    
                    isTeleopViewPresented.toggle()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Next - to Teleop")
                        Spacer()
                    }
                })
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $isTeleopViewPresented) {
                    TeleopView()
                }
            }
            .onDisappear {
                AppDelegate.setOrientationLock(.portrait, orientationMask: .portrait)
            }
            .onAppear {
                AppDelegate.setOrientationLock(.landscapeLeft, orientationMask: .landscape)
                DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
                    heavyImpactGenerator.impactOccurred()
                    isTeleopViewPresented.toggle()
                }
            }
            .navigationBarTitle("Team: \(MatchDetails.shared.teamNumber)")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    CloseButtonView(presentationMode: presentationMode)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct AutoView_Previews: PreviewProvider {
    static var previews: some View {
        AutoView()
            .onAppear {
                MatchDetails.shared.teamNumber = "8033"
            }
    }
}

struct CloseButtonView: View {
    
    var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.gray)
        }
    }
}
