//
//  ViewController.swift
//  MyColorMaker
//
//  Created by Gianluca on 27/07/15.
//  Copyright © 2015 Gianluca Bargelli. All rights reserved.
//

import UIKit

enum Slider: Int {
    case Red, Green, Blue
}

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func changeColor(sender: UISlider) {
        let alpha = CGFloat(1)
        let newColor = CGFloat(sender.value)
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        var newBackgroundColor = UIColor()
        
        switch(sender.tag) {
            
        case Slider.Red.rawValue:
            newBackgroundColor = UIColor(red: newColor, green: green, blue: blue, alpha: alpha)
            
        case Slider.Green.rawValue:
            newBackgroundColor = UIColor(red: red, green: newColor, blue: blue, alpha: alpha)

        case Slider.Blue.rawValue:
            newBackgroundColor = UIColor(red: red, green: green, blue: newColor, alpha: alpha)
        default:
            print("Boh")
        }
        
        colorView.backgroundColor = newBackgroundColor
        self.navigationController?.navigationBar.barTintColor   = newBackgroundColor
    }

}

