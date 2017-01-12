//
//  ViewController.swift
//  Effects
//
//  Created by Aaron Connolly on 11/27/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- Actions
    
    @IBAction func runAnimationsButtonTapped(_ sender: Any) {
        guard let animationView = animationView as? FancyAnimatable else {
            print("animationView in Storyboard isn't a thing")
            return
        }
        
        animationView.runAnimations()
    }
}

