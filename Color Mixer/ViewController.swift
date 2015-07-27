//
//  ViewController.swift
//  Color Mixer
//
//  Created by Gianluca on 27/07/15.
//  Copyright © 2015 Gianluca Bargelli. All rights reserved.
//

import UIKit

enum Slider: Int {
    case Red, Green, Blue
}

enum ColorPickerMode {
    case HEX, RGB
}

class ViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var switchMode: UIButton!
    
    var mode: ColorPickerMode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.mode = ColorPickerMode.HEX
        updateColors(getCurrentColor())
        updateLabels(animate: nil)
    }
    
    func convert(value: Float) -> Int {
        return Int(ceil(value * 255))
    }
    
    func getCurrentSliderValueRGB() -> String {
        return "rgb(\(convert(redSlider.value)), \(convert(greenSlider.value)), \(convert(blueSlider.value)))"
    }
    
    func getCurrentSliderValueHex() -> String {
        let red = String(format: "%02X", convert(redSlider.value))
        let green = String(format: "%02X", convert(greenSlider.value))
        let blue = String(format: "%02X", convert(blueSlider.value))
        
        return "#\(red)\(green)\(blue)".uppercaseString
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
        
        if y > 128.0 {
            return UIColor.blackColor()
        } else {
            return UIColor.whiteColor()
        }
    }
    
    func updateColors(newColor: UIColor) {
        let inverseColor = getInverseColor(newColor)
        
        colorView.backgroundColor = newColor
        self.navigationController?.navigationBar.barTintColor = newColor
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: inverseColor]
        self.rgbLabel.textColor = inverseColor
        
        updateLabels(animate: nil)
    }
    
    func updateLabels(animate animate: Bool?) {
        let duration = 0.7
        
        if let _ = animate {
            UIView.animateWithDuration(duration, animations: {
                self.rgbLabel.alpha = 0
                UIView.animateWithDuration(duration, animations: {
                    self.rgbLabel.alpha = 1
                })
                
            })
        }
        
        switch (self.mode!) {
        case .HEX:
            self.switchMode.setTitle("Switch to RGB", forState: .Normal)
            self.rgbLabel.text = getCurrentSliderValueHex()
        case .RGB:
            self.switchMode.setTitle("Switch to HEX", forState: .Normal)
            self.rgbLabel.text = getCurrentSliderValueRGB()
        }
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
            print("I don't know what you're trying to process, son.")
            
        }
        
        updateColors(newBackgroundColor)
    }

    @IBAction func changeColorPickerMode(sender: UIButton) {
        switch(self.mode!) {
        case.HEX:
            self.mode = ColorPickerMode.RGB
        case.RGB:
            self.mode = ColorPickerMode.HEX
        }
        
        updateLabels(animate: true)
    }
}

