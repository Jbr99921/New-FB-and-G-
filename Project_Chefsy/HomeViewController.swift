//
//  HomeViewController.swift
//  Project_Chefsy
//
//  Created by XongoLab on 19/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var LblVerify: UILabel!
    @IBOutlet weak var LblEnterOTP: UILabel!
    @IBOutlet weak var TxtEnterCode: UIStackView!
    @IBOutlet weak var BtnVerifyNow: UIButton!
    @IBOutlet weak var BtnReSendCode: UIButton!
    
    @IBOutlet weak var First: UITextField!
    @IBOutlet weak var Second: UITextField!
    @IBOutlet weak var Third: UITextField!
    @IBOutlet weak var Fourth: UITextField!
    @IBOutlet weak var FIfth: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Verification"
        self.BtnVerifyNow.layer.cornerRadius = 20
        self.BtnVerifyNow.layer.borderWidth = 1
        self.BtnVerifyNow.layer.borderColor = UIColor.red.cgColor
        BtnVerifyNow.backgroundColor = .clear
    
        First.becomeFirstResponder()
        First.delegate = self
        Second.delegate = self
        Third.delegate = self
        Fourth.delegate = self
        FIfth.delegate = self
//        
//        First.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
//        Second.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
//        Third.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
//        Fourth.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)
//        FIfth.addTarget(self, action: "textFieldDidChange:", for: UIControlEvents.editingChanged)

        self.First.keyboardType = UIKeyboardType.decimalPad
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == First {
                Second?.becomeFirstResponder()
            }
            if textField == Second {
                Third?.becomeFirstResponder()
            }
            if textField == Third {
                Fourth?.becomeFirstResponder()
            }
            if textField == Fourth {
                FIfth?.becomeFirstResponder()
            }
            if textField == FIfth {
                FIfth.resignFirstResponder()
          //     var otp = "\((First?.text)!)\((Second?.text)!)\((Third?.text)!)\((Fourth?.text)!)\((FIfth?.text)!)\(string)"
            }
            textField.text? = string
            return false
        }else if (range.length == 1) {
            if textField == FIfth {
                Fourth?.becomeFirstResponder()
            }
            if textField == Fourth {
                Third?.becomeFirstResponder()
            }
            if textField == Third {
                Second?.becomeFirstResponder()
            }
            if textField == Second {
                First?.becomeFirstResponder()
            }
            if textField == First {
                First?.becomeFirstResponder()
            }
            textField.text? = ""
            return false
        }
        return true
    }

    
//    func textFieldDidChange(textField: UITextField){
//
//        let text = textField.text
//
//        if (text?.utf16.count)! >= 1{
//            switch textField{
//            case First:
//                Second.becomeFirstResponder()
//            case Second:
//                Third.becomeFirstResponder()
//            case Third:
//                Fourth.becomeFirstResponder()
//            case Fourth:
//                Fourth.becomeFirstResponder()
//            case FIfth:
//                FIfth.resignFirstResponder()
//            default:
//                break
//            }
//        }else{
//
//        }
//    }
//
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        textField.text = ""
//    }
    @IBAction func BtnVerify(_ sender: UIButton) {
        
        
    }
    
    @IBAction func BtnResend(_ sender: UIButton) {
        First.text = nil
        Second.text = nil
        Third.text = nil
        Fourth.text = nil
        FIfth.text = nil
    }
}
