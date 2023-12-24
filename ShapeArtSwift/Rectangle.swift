//
//  Rectangle.swift
//  ShapeArtSwift
//
//  Created by Simhachalam Naidu Peddinti on 23/12/23.
//

import UIKit

class Rectangle: Shape {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        pathShape = CGMutablePath()
        pathShape?.move(to: CGPoint(x: padding, y: 2 * padding))
        pathShape?.addLine(to: CGPoint(x: bounds.size.width - padding, y: 2 * padding))
        pathShape?.addLine(to: CGPoint(x: bounds.size.width - padding, y: bounds.size.height - 2 * padding))
        pathShape?.addLine(to: CGPoint(x: padding, y: bounds.size.height - 2 * padding))
        pathShape?.addLine(to: CGPoint(x: padding, y: 2 * padding))

        if let pathShape = pathShape {
            context.addPath(pathShape)
            context.setFillColor(fillColor.cgColor)
            context.closePath()
            context.fillPath()
        }
    }
}
