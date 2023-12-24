//
//  Shape.swift
//  ShapeArtSwift
//
//  Created by Simhachalam Naidu Peddinti on 23/12/23.
//

import UIKit

class Shape: UIView {

  var pathShape: CGMutablePath!
  var pathBorder: CGMutablePath!
  var pathResize: CGMutablePath?
  var padding: CGFloat = 5
  var fillColor: UIColor = .orange
  var isSelected: Bool = false
  var isResizing: Bool = false

  override init(frame: CGRect) {
    super.init(frame: frame)

    let aRedValue = CGFloat(arc4random() % 255) / 255.0
    let aGreenValue = CGFloat(arc4random() % 255) / 255.0
    let aBlueValue = CGFloat(arc4random() % 255) / 255.0

    self.fillColor = UIColor(red: aRedValue, green: aGreenValue, blue: aBlueValue, alpha: 1.0)
    self.clipsToBounds = true
    self.backgroundColor = UIColor.clear
    self.setNeedsDisplay()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)

    guard let context = UIGraphicsGetCurrentContext() else { return }

    if isSelected {
      // Create pathBorder
      self.pathBorder = CGMutablePath()
      self.pathBorder.move(to: CGPoint(x: 0, y: 0))
      self.pathBorder.addLine(to: CGPoint(x: self.bounds.size.width, y: 0))
      self.pathBorder.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
      self.pathBorder.addLine(to: CGPoint(x: 0, y: self.bounds.size.height))
      self.pathBorder.addLine(to: CGPoint(x: 0, y: 0))

      // Draw pathBorder
      context.beginPath()
      context.setLineWidth(3)
      context.setStrokeColor(UIColor.black.cgColor)

      let dash: [CGFloat] = [10, 3]
      context.setLineDash(phase: 0, lengths: dash)
      context.addPath(self.pathBorder)
      context.strokePath()
      context.closePath()

      // Create pathResize
      self.pathResize = CGMutablePath()
      self.pathResize?.move(to: CGPoint(x: self.frame.size.width - 30, y: self.frame.size.height))
      self.pathResize?.addLine(to: CGPoint(x: self.bounds.size.width, y: self.frame.size.height))
      self.pathResize?.addLine(to: CGPoint(x: self.bounds.size.width, y: self.frame.size.height - 30))
      self.pathResize?.addLine(to: CGPoint(x: self.frame.size.width - 30, y: self.frame.size.height))

      // Draw pathResize
      context.addPath(self.pathResize!)
      context.setFillColor(UIColor.black.cgColor)
      context.fillPath()
      context.closePath()
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    superview?.bringSubviewToFront(self)
    if let subviews = superview?.subviews as? [Shape] {
      for subView in subviews {
        if subView.isEqual(self) { continue }
        if subView.isResizing || subView.isSelected {
          subView.isResizing = false
          subView.isSelected = false
          subView.setNeedsDisplay()
        }
      }
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in: self)

    if isResizing {
      let p1 = touchPoint
      let p2 = bounds.origin

      let xDist = p2.x - p1.x
      let yDist = p2.y - p1.y
      let distance = Int(sqrt((xDist * xDist) + (yDist * yDist)))

      let touchPoint = touch.location(in: self.superview)
      let previousPoint = touch.previousLocation(in: self.superview)

      let deltaX = touchPoint.x - previousPoint.x
      let deltaY = touchPoint.y - previousPoint.y
      let change = max(deltaX, deltaY)
      let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width + change, height: frame.size.height + change)
      if CGRectIntersection(superview?.bounds ?? CGRect.zero, newFrame).size.equalTo(newFrame.size) {
        frame = newFrame
      }
    } else {
      isSelected = true
//      let convertedPoint = convert(touchPoint, to: superview)
      guard let touch = touches.first else { return }

        let touchPoint = touch.location(in: self.superview)
        let previousPoint = touch.previousLocation(in: self.superview)

        let deltaX = touchPoint.x - previousPoint.x
        let deltaY = touchPoint.y - previousPoint.y

      let convertedPoint = CGPoint(x: self.center.x + deltaX, y: self.center.y + deltaY)

      let newFrame = CGRect(x: convertedPoint.x - (frame.size.width / 2),
                            y: convertedPoint.y - (frame.size.height / 2),
                            width: frame.size.width,
                            height: frame.size.height)
      if CGRectIntersection(superview?.bounds ?? CGRect.zero, newFrame).size.equalTo(frame.size) {
        center = convertedPoint
      }
    }
    setNeedsDisplay()
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    isResizing = false
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    isSelected = true
    if bounds.contains(point) {
      isResizing = pathResize?.contains(point) ?? false
      if pathShape.contains(point) {
        isSelected = true
        setNeedsDisplay()
        return self
      }

      setNeedsDisplay()
      if isResizing {
        return self
      }
    }
    return nil
  }
}
