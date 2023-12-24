//
//  ViewController.swift
//  ShapeArtSwift
//
//  Created by Simhachalam Naidu Peddinti on 23/12/23.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.addSubview(Triangle.init(frame: CGRect.init(x: 100, y: 100, width: 150, height: 150)))
    self.view.addSubview(Ellipse.init(frame: CGRect.init(x: 100, y: 250, width: 150, height: 150)))
    self.view.addSubview(Rectangle.init(frame: CGRect.init(x: 100, y: 250, width: 200, height: 150)))
    self.view.addSubview(Star.init(frame: CGRect.init(x: 175, y: 400, width: 150, height: 150)))
  }
}

