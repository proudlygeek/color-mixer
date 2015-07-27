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
    @IBOutlet weak var rgbLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
    }
    
    override func viewWillAppear(animated: Bool) {
        updateColors(getCurrentColor())
    }
    
    func convert(value: Float) -> Int {
        return Int(ceil(value * 255))
    }
    
    func getCurrentSliderValueFormat() -> String {
        return "RGB(\(convert(redSlider.value)), \(convert(greenSlider.value)), \(convert(blueSlider.value)))"
    }
    
    func getCurrentColor() -> UIColor {
        return UIColor(red: CGFloat(redSlider.value), green: CGFloat(redSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
    }
    
    func getInverseColor(color: UIColor) -> UIColor {
        let convertedColor = CIColor(color: color)
        let red = convertedColor.red
        let green = convertedColor.green
        let blue = convertedColor.blue
        
        // Luminance formula (https://en.wikipedia.org/wiki/Relative_luminance)
        let y = (0.2126 * Double(convert(Float(red)))) +
                (0.7152 * Double(convert(Float(green)))) +
                (0.0722 * Double(convert(Float(blue))))
        
        if y > 128 {
            return UIColor.blackColor()
        } else {
            return UIColor.whiteColor()
        }
    }
    
    func updateColors(newColor: UIColor) {
        let inverseColor = getInverseColor(newColor)
        
        colorView.backgroundColor = newColor
        self.navigationController?.navigationBar.barTintColor = newColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: inverseColor]
        self.rgbLabel.text = getCurrentSliderValueFormat()
        self.rgbLabel.textColor = inverseColor
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
        
        updateColors(newBackgroundColor)
    }

}

