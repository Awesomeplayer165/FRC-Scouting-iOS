//
//  MatchDetails.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 11/24/22.
//

import SwiftUI

class MatchDetails: ObservableObject {
    init(matchNumber: String = String(), teamNumber: String = String(), name: String = String(), autoSuccess: Int = Int.zero, autoFailure: Int = Int.zero, teleopSuccess: Int = Int.zero, teleopFailure: Int = Int.zero, notes: String = "", climberPosition: ClimberPosition = ClimberPosition.noClimb) {
        self.matchNumber = matchNumber
        self.teamNumber = teamNumber
        self.name = name
        self.autoSuccess = autoSuccess
        self.autoFailure = autoFailure
        self.teleopSuccess = teleopSuccess
        self.teleopFailure = teleopFailure
        self.notes = notes
        self.climberPosition = climberPosition
    }
    
    
    @Published public var matchNumber = String()
    @Published public var teamNumber  = String()
    @Published public var name        = String()
    
    @Published public var autoSuccess = Int.zero
    @Published public var autoFailure = Int.zero
    
    @Published public var teleopSuccess = Int.zero
    @Published public var teleopFailure = Int.zero
    
    @Published public var notes = ""
    @Published public var climberPosition = ClimberPosition.noClimb
    
    public func isMetaMatchDetailsValid() -> Bool {
        return matchNumber.isMatchDetailsNumberValid() ||
               teamNumber .isMatchDetailsNumberValid()   ||
               !name      .isEmpty
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
    
    public func exampleData() {
        matchNumber = "23"
        teamNumber  = "8033"
        name        = "Jacob Trentini"
        
        autoSuccess = 3
        autoFailure = 2
        
        teleopSuccess = 21
        teleopFailure = 2
        
        notes = ""
        climberPosition = .mid
    }
}
