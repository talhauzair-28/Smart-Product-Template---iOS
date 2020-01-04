//
//  Common.swift
//  Smart Product Template
//
//  Created by Talha Uzair on 02/01/2020.
//  Copyright © 2020 Talha Uzair. All rights reserved.
//

import Foundation
import UIKit

class Common {
    
    public static func exampleMethods(){
        print ("Example")
    }
    
    static func isValidEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func showMessage(title: String, message: String, positiveButton: String, viewController: UIViewController, finishProcess : Bool = false){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if(finishProcess){
            alert.addAction(UIAlertAction(title: positiveButton, style: UIAlertAction.Style.default, handler: { action in
                viewController.navigationController?.popViewController(animated: true)
            }))
        }
        else{
            alert.addAction(UIAlertAction(title: positiveButton, style: UIAlertAction.Style.default, handler:{ action in
            }))
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getBasicURL()-> String{
        return "http://xavorsdapi.xavor.com:5065/api/"
    }
}
