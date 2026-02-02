//
//  ShapeShiftingFIgure.swift
//  SwiftUI-Animation
//
//  Created by Dmytro Maksiutenko on 2026-02-02.
//

import Foundation
import SwiftUI

struct ShapeShifringFigure: Shape {
    var sides: Int
    private var animatingSides: Double
    
    var animatableData: Double {
        get { animatingSides }
        set {
            animatingSides = newValue
            sides = max(3, Int(newValue.rounded()))
        }
    }
    
    init(sides: Int) {
        self.sides = sides < 3 ? 3 : sides
        self.animatingSides = Double(sides)
    }

    func path(in rect: CGRect) -> Path {
        var vertices: [CGPoint] = []
        let c = CGPoint(x: rect.width/2.0, y: rect.height/2.0) // centre of the containing rect
        let r = Double(min(rect.width,rect.height)) / 2.0 // radius of a circle that will fit in the rect
        let effectiveSides = max(3.0, animatingSides)
        let offsetAngle = (Double.pi / effectiveSides) + Double.pi/2.0
        let vertexCount = Int(floor(effectiveSides))
        for i in 0...max(3, vertexCount) {
            let angle = (2.0 * Double.pi * Double(i) / effectiveSides) + offsetAngle // Calculate the angle in Radius
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
