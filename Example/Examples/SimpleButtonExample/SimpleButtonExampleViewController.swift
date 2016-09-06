//
//  SimpleButtonExampleViewController.swift
//  Example
//
//  Created by Florian Krüger on 25/04/15.
//  Copyright (c) 2015 projectserver.org. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import Manuscript

class SimpleButtonExampleViewController: UIViewController {

  // MARK: Private Properties

  private var activeButton: UIButton? = nil

  private let optionA: UIButton = UIButton(type: .system)
  private let optionB: UIButton = UIButton(type: .system)
  private let optionC: UIButton = UIButton(type: .system)

  private let buttonDimSmall:CGFloat = 60.0
  private let buttonDimBig:CGFloat = 80.0

  private var optionAHeight: NSLayoutConstraint? = nil
  private var optionAWidth: NSLayoutConstraint? = nil
  private var optionBHeight: NSLayoutConstraint? = nil
  private var optionBWidth: NSLayoutConstraint? = nil
  private var optionCHeight: NSLayoutConstraint? = nil
  private var optionCWidth: NSLayoutConstraint? = nil

  // MARK: - Init

  init() {
    super.init(nibName: nil, bundle: nil)
    self.title = "Buttons"
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("storyboards are incompatible with truth and beauty")
  }

  // MARK: - View

  override func loadView() {
    super.loadView()

    self.view.backgroundColor = UIColor.gray

    self.setupSubviews()
    self.setupLayout()
  }

  // MARK: - Target

  func buttonPressed(sender: UIButton) {
    if sender == self.activeButton {
      return;
    }

    if let activeButton = self.activeButton {
      switch activeButton {
      case self.optionA:
        self.optionAHeight?.constant = self.buttonDimSmall
        self.optionAWidth?.constant = self.buttonDimSmall
        self.optionA.setNeedsLayout()
      case self.optionB:
        self.optionBHeight?.constant = self.buttonDimSmall
        self.optionBWidth?.constant = self.buttonDimSmall
        self.optionB.setNeedsLayout()
      case self.optionC:
        self.optionCHeight?.constant = self.buttonDimSmall
        self.optionCWidth?.constant = self.buttonDimSmall
        self.optionC.setNeedsLayout()
      default:
        print("active button is unknown")
      }
    }

    switch sender {
    case self.optionA:
      self.optionAHeight?.constant = self.buttonDimBig
      self.optionAWidth?.constant = self.buttonDimBig
      self.optionA.setNeedsLayout()
    case self.optionB:
      self.optionBHeight?.constant = self.buttonDimBig
      self.optionBWidth?.constant = self.buttonDimBig
      self.optionB.setNeedsLayout()
    case self.optionC:
      self.optionCHeight?.constant = self.buttonDimBig
      self.optionCWidth?.constant = self.buttonDimBig
      self.optionC.setNeedsLayout()
    default:
      print("sender button is unknown")
    }

    self.activeButton = sender

    UIView.animate(withDuration: 0.25) {
      self.view.layoutIfNeeded()
    }
  }

  // MARK: - Setup & Layout

  private func setupSubviews() {
    self.optionA.backgroundColor = UIColor.white
    self.optionA.setTitle("A", for: .normal)
    self.optionA.addTarget(self, action: Selector("buttonPressed:"), for: .touchUpInside)
    self.view.addSubview(self.optionA)

    self.optionB.backgroundColor = UIColor.white
    self.optionB.setTitle("B", for: .normal)
    self.optionB.addTarget(self, action: "buttonPressed:", for: .touchUpInside)
    self.view.addSubview(self.optionB)

    self.optionC.backgroundColor = UIColor.white
    self.optionC.setTitle("C", for: .normal)
    self.optionC.addTarget(self, action: "buttonPressed:", for: .touchUpInside)
    self.view.addSubview(self.optionC)
  }

  private func setupLayout() {
    Manuscript.layout(view: self.optionA) { c in
      self.optionAHeight = c.set(.height, to:self.buttonDimSmall).constraint
      self.optionAWidth = c.set(.width, to:self.buttonDimSmall).constraint
      c.make(.right, equalTo:self.optionB, s:.left, minus: 10.0)
      c.make(.centerY, equalTo:self.view, s:.centerY)
    }

    Manuscript.layout(view: self.optionB) { c in
      self.optionBHeight = c.set(.height, to:self.buttonDimSmall).constraint
      self.optionBWidth = c.set(.width, to:self.buttonDimSmall).constraint
      c.centerIn(self.view)
    }

    Manuscript.layout(view: self.optionC) { c in
      self.optionCHeight = c.set(.height, to:self.buttonDimSmall).constraint
      self.optionCWidth = c.set(.width, to:self.buttonDimSmall).constraint
      c.make(.left, equalTo:self.optionB, s:.right, plus: 10.0)
      c.make(.centerY, equalTo:self.view, s:.centerY)
    }
  }

}
