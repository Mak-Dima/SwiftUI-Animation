//
//  AnimationPhase.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-02-02.
//

import Foundation
import SwiftUI

enum Phase: CaseIterable {
    case initial
    case moveUp
    case rotation
    
    var verticalOffset: Double {
        switch self {
        case .initial: .zero
        case .moveUp, .rotation: -100
        }
    }
    
    var horizontalOffset: Double {
        switch self {
        case .initial: .zero
        case .moveUp, .rotation: 50
        }
    }
    
    var rotationEffect: Angle {
        switch self {
        case .initial: .zero
        case .moveUp, .rotation: .degrees(-40)
        }
    }
}
