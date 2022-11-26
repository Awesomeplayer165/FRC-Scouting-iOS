//
//  ContentView.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import SwiftUI

struct AutoView: View {
    @State private var isTeleopViewPresented = false
    @AppStorage("isGameReadyViewPresented", store: .standard) private var isGameReadyViewPresented = false
    @AppStorage("isAutoViewPresented", store: .standard) private var isAutoViewPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
    private let notificationGenerator = UINotificationFeedbackGenerator()
    private var mediumImpactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private var heavyImpactGenerator  = UIImpactFeedbackGenerator(style: .heavy)
    
    private let rectangleCornerRadius: CGFloat = 10
    
    @State private var timer = Timer.publish(every: 16.0, on: .current, in: .common).autoconnect()
    @State private var isFirstTime = true
    @EnvironmentObject private var matchDetails: MatchDetails
    
    var body: some View {
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
                        Text("\(matchDetails.autoFailure)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        Button("Subtract") {
                            if matchDetails.autoFailure > 0 {
                                matchDetails.autoFailure -= 1
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
                    matchDetails.autoFailure += 1
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
                        Text("\(matchDetails.autoSuccess)")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 50))
                        
                        Spacer()
                        
                        Button("Subtract") {
                            if matchDetails.autoSuccess > 0 {
                                matchDetails.autoSuccess -= 1
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
                    matchDetails.autoSuccess += 1
                    mediumImpactGenerator.impactOccurred()
                }
            }
            .ignoresSafeArea()
            
            NavigationLink(destination: TeleopView(), isActive: $isTeleopViewPresented) { EmptyView() }
                .frame(width: 0, height: 0)
            
            Button(action: {
                advance()
            }, label: {
                HStack {
                    Spacer()
                    Text("Next - to Teleop")
                    Spacer()
                }
            })
            .buttonStyle(.borderedProminent)
        }
        .onReceive(timer) { _ in
            advance()
        }
        .onAppear {
            AppDelegate.setOrientationLock(.landscapeLeft, orientationMask: .landscape)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitle("Team: \(matchDetails.teamNumber)")
        .navigationViewStyle(.stack)
        
    }
    
    func advance() {
        heavyImpactGenerator .impactOccurred()
        isTeleopViewPresented.toggle()
        
        self.timer.upstream.connect().cancel()
    }
}

struct AutoView_Previews: PreviewProvider {
    static var previews: some View {
        AutoView()
            .environmentObject(MatchDetails())
    }
}

struct CloseButtonView: View {
    
    var presentationMode: Binding<PresentationMode>
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            if let action = action {
                action()
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.gray)
        }
    }
}
