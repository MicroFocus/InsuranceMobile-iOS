/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class SignUpViewController: UIViewController {
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var birthdayTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  var email: String!
  
  override func viewDidLoad() {
    emailTextField!.text = email!
    
    // Dismiss keyboard - see http://stackoverflow.com/a/27079103
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AutoQuoteViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    if (identifier == "pickDate") {
      return true
    }else{
      var result: Bool = true
      result = TextFieldUtils.validate(firstNameTextField) && result
      result = TextFieldUtils.validate(lastNameTextField) && result
      result = TextFieldUtils.validateDate(birthdayTextField) && result
      result = TextFieldUtils.validate(emailTextField) && result
      result = TextFieldUtils.validate(passwordTextField) && result
      
      if (result) {
        let 👱: User = User(email: emailTextField!.text!, password : passwordTextField!.text!, firstName: firstNameTextField!.text!, lastName: lastNameTextField!.text!, birthday: birthdayTextField!.text!)
        let 🏁: Bool = User.RegisterUser(👱)
        
        if (!🏁) {
          UIUtils.ShowError(self, message: "A user with this email address already exists")
        }
      }
      
      return result
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.destinationViewController is PickDateViewController) {
      let vc = segue.destinationViewController as! PickDateViewController
      vc.inputDate = birthdayTextField!.text
      
    }else{
      let vc = segue.destinationViewController as! UINavigationController
      let login = vc.visibleViewController as! LoginViewController
      
      login.email = emailTextField!.text
    }
  }
}