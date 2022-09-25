//
//  ClimberPosition.swift
//  FRC Scouting
//
//  Created by Jacob Trentini on 9/24/22.
//

import Foundation

enum ClimberPosition: Int {
    case noClimb
    case low
    case mid
    case high
    case traversal
    
    var localizedDescription: String {
        switch self {
        case .noClimb:   return "No Climb"
        case .low:       return "Low"
        case .mid:       return "Mid"
        case .high:      return "High"
        case .traversal: return "Traversal"
        }
    }
    
    var formDescription: String {
        switch self {
        case .low, .mid, .high, .traversal: return localizedDescription
        default:                            return "No+Climb"
        }
    }
}
