//
//  KeyFrameAnimationView.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-02-01.
//

import SwiftUI

struct ShapeShifringFigure: Shape {
    var sides: Int
    
    init(sides: Int) {
        self.sides = sides < 3 ? 3 : sides
    }

    func path(in rect: CGRect) -> Path {
        var vertices: [CGPoint] = []
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0) // centre of the containing rect
        let r = Double(min(rect.width,rect.height)) / 2.0 // radius of a circle that will fit in the rect
        let offsetAngle = (Double.pi / Double(sides)) + Double.pi/2.0
        for i in 0...sides {
            let angle = (2.0 * Double.pi * Double(i)/Double(sides)) + offsetAngle // Calculate the angle in Radius
            let pt = Cartesian(length: r, angle: angle)
            vertices.append (CGPoint(x: pt.x + c.x, y: pt.y + c.y)) // Move the point relative to the center of the rect and add to vertices
        }
        
        var path = Path()
        for (n, pt) in vertices.enumerated() {
            n == 0 ? path.move(to: pt) : path.addLine(to: pt)
        }
        path.closeSubpath()
        
        return path
    }
    
    private func Cartesian(length:Double, angle:Double) -> CGPoint {
        return CGPoint (x: length * cos(angle), y: length * sin(angle))
    }
}

struct KeyFrameAnimationView: View {
    
    @State var sides: Int
    
    var body: some View {
        Spacer()
        
        VStack {
            ShapeShifringFigure(sides: self.sides)
                .fill(.blue)
                .frame(maxWidth: 150, maxHeight: 150)
        }
        
        Spacer()
        
        HStack{
            Button { sides += 1 } label: {
                Text("More")
            }
            .buttonStyle(.borderedProminent)
            
            Button { sides -= 1 } label: {
                Text("Less")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    KeyFrameAnimationView(sides: 2)
}
