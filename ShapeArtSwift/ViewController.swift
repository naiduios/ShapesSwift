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
    fizzBuzz(n: 15)
  }

  func fizzBuzz(n: Int) -> Void {
    // Write your code here
    for i in 1...n {
      if i % 3 == 0 && i % 5 == 0 {
        print("FizzBuzz")
      } else if i % 3 == 0 && i % 5 != 0 {
        print("Fizz")
      }
      else if i % 3 != 0 && i % 5 == 0 {
        print("Buzz")
      }
      else {
        print("\(i)")
      }
    }
  }
}

func missedLectures(numChapters: Int, b: Int, e: Int) -> Int {
  return min(numChapters, e-b+1)
}

func sortDates(dates: [String]) -> [String] {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "dd MMM yyyy"
  var datesList = dates.map{ (dateFormatter.date(from: $0) ?? Date()) }
  datesList.sort()
  let sortedDates = datesList.map {(dateFormatter.string(from: $0))}
  return sortedDates
}


