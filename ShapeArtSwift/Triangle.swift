//
//  Triangle.swift
//  ShapeArtSwift
//
//  Created by Simhachalam Naidu Peddinti on 23/12/23.
//

import UIKit

class Triangle: Shape {

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
        context.beginPath()
        pathShape?.move(to: CGPoint(x: frame.size.width / 2, y: padding))
        pathShape?.addLine(to: CGPoint(x: bounds.size.width - padding, y: bounds.size.height - padding))
        pathShape?.addLine(to: CGPoint(x: padding, y: bounds.size.height - padding))
        pathShape?.addLine(to: CGPoint(x: frame.size.width / 2, y: padding))

        if let pathShape = pathShape {
            context.addPath(pathShape)
          context.setFillColor(fillColor.cgColor)
            context.fillPath()
            context.closePath()
        }
    }
}
