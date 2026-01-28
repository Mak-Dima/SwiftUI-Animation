//
//  ContentView.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-01-27.
//

import SwiftUI

struct ContentView: View {
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
                        withAnimation(.spring(duration: 1.0)) {
                            isCircle.toggle()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(.linear(duration: 1.0)) {
                                if position.y >= proxy.size.height {
                                    position.y -= offset.y
                                } else if position.y <= proxy.size.height {
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
            .ignoresSafeArea() // Optional: mimic full-screen bounds if needed
        }
    }
}

#Preview {
    ContentView()
}
