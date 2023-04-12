//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Elena Sharipova on 23.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    // MARK: - Public Properties
    var selectedColor: Color!
    unowned var delegate: SettingsViewControllerDelegate!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDoneButtonOnNumpad(textField: redTF)
        addDoneButtonOnNumpad(textField: greenTF)
        addDoneButtonOnNumpad(textField: blueTF)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        initialSettings()
        setColorWithSlider()
    }
    
    // MARK: - Override Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        setColorWithSlider()
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        setColorWithSlider()
        
        switch sender {
        case redSlider:
            selectedColor.red = CGFloat(redSlider.value * 255)
            redLabel.text = string(from: redSlider)
            redTF.text = string(from: redSlider)
        case greenSlider:
            selectedColor.green = CGFloat(greenSlider.value * 255)
            greenLabel.text = string(from: greenSlider)
            greenTF.text = string(from: greenSlider)
        default:
            selectedColor.blue = CGFloat(blueSlider.value * 255)
            blueLabel.text = string(from: blueSlider)
            blueTF.text = string(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(for: selectedColor)
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setColorWithSlider() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func string(from color: CGFloat) -> String {
        String(format: "%.2f", Float(color / 255))
    }
}

// MARK: - Set up initial settings
extension SettingsViewController {
    private func initialSettings() {
        redSlider.value = Float(selectedColor.red / 255)
        greenSlider.value = Float(selectedColor.green / 255)
        blueSlider.value = Float(selectedColor.blue / 255)
        
        redLabel.text = string(from: selectedColor.red)
        greenLabel.text = string(from: selectedColor.green)
        blueLabel.text = string(from: selectedColor.blue)
        
        redTF.text = string(from: selectedColor.red)
        greenTF.text = string(from: selectedColor.green)
        blueTF.text = string(from: selectedColor.blue)
    }
}

// MARK: - Add alert controller
extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if textField == self.redTF {
                self.redTF.text = self.string(from: self.selectedColor.red)
            } else if textField == self.greenTF {
                self.greenTF.text = self.string(from: self.selectedColor.green)
            } else if textField == self.blueTF {
                self.blueTF.text = self.string(from: self.selectedColor.blue)
            }
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Add done button on numpad
extension SettingsViewController {
    private func addDoneButtonOnNumpad(textField: UITextField) {
        let keypadToolbar: UIToolbar = UIToolbar()
        
        keypadToolbar.items=[
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                title: "Done",
                style: UIBarButtonItem.Style.done,
                target: textField,
                action: #selector(UITextField.resignFirstResponder)
            )
        ]
        
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let enteredValue = textField.text else { return }
        
        guard let textFieldValue = Float(enteredValue) else {
            showAlert(
                title: "Invalid color value",
                message: "Please, enter a value greater than zero and less than one.",
                textField: textField
            )
            return
        }
        
        guard textFieldValue >= 0.0 && textFieldValue <= 1.0 else {
            showAlert(
                title: "Invalid color value",
                message: "Please, enter a value greater than zero and less than one.",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTF:
            selectedColor.red = CGFloat(textFieldValue * 255)
            redLabel.text = String(textFieldValue)
            redSlider.value = textFieldValue
            setColorWithSlider()
        case greenTF:
            selectedColor.green = CGFloat(textFieldValue * 255)
            greenLabel.text = String(textFieldValue)
            greenSlider.value = textFieldValue
            setColorWithSlider()
        default:
            selectedColor.blue = CGFloat(textFieldValue * 255)
            blueLabel.text = String(textFieldValue)
            blueSlider.value = textFieldValue
            setColorWithSlider()
        }
    }
}
