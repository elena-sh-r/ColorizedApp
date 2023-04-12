//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Elena Sharipova on 11.04.2023.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func setColor(for selectedColor: Color)
}

final class MainViewController: UIViewController {
    // MARK: - Private Properties
    private var selectedColor = Color(red: 255, green: 82, blue: 219, alpha: 1) {
        didSet {
            setColor()
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
    }
    
    // MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.selectedColor = selectedColor
        settingsVC.delegate = self
    }

    // MARK: - Private Methods
    private func setColor() {
        view.backgroundColor = UIColor(
            red: selectedColor.red / 255,
            green: selectedColor.green / 255,
            blue: selectedColor.blue / 255,
            alpha: selectedColor.alpha
        )
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColor(for selectedColor: Color) {
        self.selectedColor = selectedColor
    }
}
