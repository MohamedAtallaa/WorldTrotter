//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Mohamed Atallah on 22/12/2022.
//

import UIKit

class ConversionVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private var celsiusLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    
    //MARK: - Properties
    var fahrenheitValue: Measurement<UnitTemperature>?
    {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>?
    {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        
        return nil
    }
    let numberFormater: NumberFormatter =
    {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        
        return nf
    }()

    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }
    
    //MARK: - Methods
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormater.string(from: NSNumber(value: celsiusValue.value))
        }else {
            celsiusLabel.text = "???"
        }
    }
    
    // MARK: - Actions
    @IBAction func FahrenheitFieldEditingChanged(_ textField: UITextField) {
        //Internationalizing the temperature entry
        if let text = textField.text, let number = numberFormater.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        }else {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

}

//MARK: - Extensions
extension ConversionVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let curentLocal = Locale.current
        let decimalSeperator = curentLocal.decimalSeparator ?? "."
        let existingTextHasDecimalSeperator = textField.text?.range(of: decimalSeperator)
        let replacementStringHasDecimalSeparator = string.range(of: decimalSeperator)
        
        if existingTextHasDecimalSeperator != nil, replacementStringHasDecimalSeparator != nil {
            return false
        }else {
            
            return true
        }
    }
}
