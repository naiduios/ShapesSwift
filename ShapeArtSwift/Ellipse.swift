//
//  Ellipse.swift
//  ShapeArtSwift
//
//  Created by Simhachalam Naidu Peddinti on 23/12/23.
//

import UIKit

class Ellipse: Shape {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        let ellipseRect = CGRect(x: padding,
                                 y: padding + (frame.size.width == frame.size.height ? 20 : 0),
                                 width: frame.size.width - (2 * padding),
                                 height: frame.size.height - (2 * padding) - (frame.size.width == frame.size.height ? 40 : 0))

        let aPath = UIBezierPath(ovalIn: ellipseRect)
        pathShape = aPath.cgPath.mutableCopy()
        pathShape?.addEllipse(in: ellipseRect)

        if let pathShape = pathShape {
            context.addPath(pathShape)
            context.setFillColor(fillColor.cgColor)
            context.closePath()
            context.fillPath()
        }
    }
}
