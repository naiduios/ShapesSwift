//
//  Star.swift
//  ShapeArtSwift
//
//  Created by Simhachalam Naidu Peddinti on 23/12/23.
//

import UIKit

class Star: Shape {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        pathShape = CGMutablePath()

        let aSize = frame.size.width
        context.setLineWidth(aSize)
        let xCenter = frame.size.width / 2
        let yCenter = frame.size.height / 2

        let width = frame.size.width - 2 * padding
        let r = width / 2.0
        let flip: CGFloat = -1.0

        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(fillColor.cgColor)

        let theta = 2.0 * .pi * (2.0 / 5.0)

        pathShape?.move(to: CGPoint(x: xCenter, y: r * flip + yCenter))
        for k in 1..<5 {
            let x = r * sin(CGFloat(k) * theta)
            let y = r * cos(CGFloat(k) * theta)
            pathShape?.addLine(to: CGPoint(x: x + xCenter, y: y * flip + yCenter))
        }

        if let pathShape = pathShape {
            context.addPath(pathShape)
            context.closePath()
            context.fillPath()
        }
    }
}
