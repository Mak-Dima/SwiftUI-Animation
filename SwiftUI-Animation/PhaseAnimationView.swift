//
//  PhaseAnimation.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-01-28.
//

import SwiftUI

struct PhaseAnimationView: View {
    
    @State private var counter: Int = 0
    
    private enum Phase: CaseIterable {
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
    
    var body: some View {
        VStack {
            Image(systemName: "hand.thumbsup")
                .resizable()
                .frame(maxWidth: 150, maxHeight: 150)
                .scaledToFit()
                .padding()
                .onTapGesture {
                    self.counter += 1
                }
                .phaseAnimator(Phase.allCases, trigger: counter) { content, phase in
                    content
                        .offset(x:phase.horizontalOffset, y: phase.verticalOffset)
                        .rotationEffect(phase.rotationEffect)
                } animation: { phase in
                    switch phase {
                    case .initial: .default
                    case .moveUp: .bouncy
                    case .rotation: .easeOut
                    }
                }
            
                Text(String(counter))
                    .font(Font.largeTitle.bold())
            }
        
    }
}

#Preview {
    PhaseAnimationView()
}
