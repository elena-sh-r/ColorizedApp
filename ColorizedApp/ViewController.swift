//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Elena Sharipova on 23.03.2023.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var currentColorSwatch: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    // MARK: - IB Actions
    @IBAction func slidersAction() {
        redColorLabel.text = (
            round(redColorSlider.value * 100) / 100.0
        ).formatted()
        
        greenColorLabel.text = (
            round(greenColorSlider.value * 100) / 100.0
        ).formatted()
        
        blueColorLabel.text = (
            round(blueColorSlider.value * 100) / 100.0
        ).formatted()
        
        currentColorSwatch.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
    }
}

