//
//  AccessLevel.swift
//  Complexion
//
//  Created by Jose Alvarez on 3/8/22.
//

import Foundation

public enum AccessLevel: Int, Comparable {
    case none = 0
    case ten = 10
    case twenty = 20
    case thirty = 30
    
    public static func < (lhs: AccessLevel, rhs: AccessLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func > (lhs: AccessLevel, rhs: AccessLevel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }

    public static func <= (lhs: AccessLevel, rhs: AccessLevel) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }

    public static func >= (lhs: AccessLevel, rhs: AccessLevel) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
}
