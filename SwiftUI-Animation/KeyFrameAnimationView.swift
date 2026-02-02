//
//  KeyFrameAnimationView.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-02-01.
//

import SwiftUI

struct KeyFrameAnimationView: View {
    
    @State var sides = AnimationValues()

    var body: some View {
        Spacer()
        
        VStack {
            ShapeShifringFigure(sides: Int(self.sides.sideNum))
                .fill(.blue)
                .frame(maxWidth: 150, maxHeight: 150)
                .keyframeAnimator(
                    initialValue: AnimationValues(sideNum: sides.sideNum),
                    trigger: sides.sideNum
                ) { content, value in
                    content
                        .scaleEffect(CGFloat(value.scale))
                } keyframes: { _ in
                    KeyframeTrack(\.scale) {
                        LinearKeyframe(0.5, duration: 1.0)
                        LinearKeyframe(1.5, duration: 1.0)
                        LinearKeyframe(1.0, duration: 1.0)
                    }
                }
            
        }

        Spacer()
        
        HStack(spacing: 40) {
            Button {
                withAnimation(.linear(duration: 3.0)) {
                    self.sides.sideNum += 1
                }
            } label: {
                Text("More")
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                withAnimation(.linear(duration: 3.0)) {
                    self.sides.sideNum = max(3, self.sides.sideNum - 1)
                }
            } label: {
                Text("Less")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    KeyFrameAnimationView(sides: AnimationValues())
}

