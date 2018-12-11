//
//  ViewController.swift
//  Rating Demo
//
//  Created by Glen Yi on 2014-09-05.
//  Copyright (c) 2014 On The Pursuit. All rights reserved.
//

import UIKit
import FloatRatingView

class ViewController: UIViewController {
    @IBOutlet var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Reset float rating view's background color
        floatRatingView.backgroundColor = UIColor.clear

        /** Note: With the exception of contentMode, type and delegate,
         all properties can be set directly in Interface Builder **/
        floatRatingView.contentMode = UIView.ContentMode.scaleAspectFit
        floatRatingView.type = .halfRatings
		
        // Labels init
        ratingLabel.text = floatRatingView.rating.formatted
    }

    @IBAction func ratingTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            floatRatingView.type = .wholeRatings
        case 1:
            floatRatingView.type = .halfRatings
        case 2:
            floatRatingView.type = .floatRatings
        default:
            floatRatingView.type = .wholeRatings
        }
    }
	
	@IBAction func updateTypeChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0: floatRatingView.isContinuous = false
		case 1: floatRatingView.isContinuous = true
		default: return
		}
	}
	
	@IBAction func ratingChanged(_ sender: FloatRatingView) {
		ratingLabel.text = sender.rating.formatted
	}
}

private extension Double {
	var formatted: String {
		return String(format: "%.2f", self)
	}
}
