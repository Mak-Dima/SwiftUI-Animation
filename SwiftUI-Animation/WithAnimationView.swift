//
//  WithAnimationView.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-01-28.
//

import SwiftUI

struct WithAnimationView: View {
    @State var isCircle = true
    @State var offset: CGPoint = .init(x: 50.0, y: 400.0)
    @State var position: CGPoint = .init(x: 350.0, y: 550.0)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
               if isCircle {
                    Circle()
                        .stroke(lineWidth: 10)
                        .size(width: 100, height: 100)
                        .position(x: position.x, y: position.y)
                } else {
                    Rectangle()
                        .stroke(lineWidth: 10)
                        .size(width: 100, height: 100)
                        .position(x: position.x, y: position.y)
                }

                VStack {
                    Spacer()
                    Button {
                        // State based animation.
                        withAnimation(.spring(duration: 1.0)) {
                            isCircle.toggle()
                        }
                        
                        Task { @MainActor in
                            try await Task.sleep(for: .seconds(1))
                            withAnimation(.linear(duration: 1.0)) {
                                if position.y >= proxy.size.height {
                                    position.y -= offset.y
                                } else {
                                  position.y += offset.y
                                }
                            }
                        }
                    } label: {
                        Text("Toggle")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    WithAnimationView()
}
