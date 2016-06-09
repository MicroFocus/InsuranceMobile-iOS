/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var signUpButton: UIBarButtonItem!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var defaultUserButton: UIButton!
  
  var email: String!
  
  override func viewDidLoad() {
    if (email != nil) {
      emailTextField!.text = email!
    }
    
    let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(LoginViewController.handleLongPress(_:)))
    defaultUserButton.addGestureRecognizer(lpgr)
    // Dismiss keyboard - see http://stackoverflow.com/a/27079103
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AutoQuoteViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let vc = segue.destinationViewController as! SignUpViewController
    vc.email = emailTextField!.text
  }
  
  @IBAction func loginClick(sender: AnyObject) {
    var validInput = true
    
    validInput = TextFieldUtils.validate(emailTextField)
    validInput = TextFieldUtils.validate(passwordTextField)
    
    if (!validInput) {
      return
    }
    
    emailTextField.enabled = false
    passwordTextField.enabled = false
    loginButton.enabled = false
    signUpButton.enabled = false
    
    activityIndicator.startAnimating()
    
    AsyncUtils.backgroundThread(background: {
      AsyncUtils.sleepDefaultDelay()
      },
                                completion: {
                                  self.emailTextField.enabled = true
                                  self.passwordTextField.enabled = true
                                  self.loginButton.enabled = true
                                  self.signUpButton.enabled = true
                                  
                                  self.activityIndicator.stopAnimating()
                                  
                                  let user = User.GetUser(self.emailTextField!.text!)
                                  
                                  if (user != nil && user?.password == self.passwordTextField!.text!) {
                                    User.Login(user!)
                                    
                                    var mainView: UIStoryboard!
                                    mainView = UIStoryboard(name: "Main", bundle: nil)
                                    let viewcontroller : UIViewController = mainView.instantiateViewControllerWithIdentifier("mainStoryBoard") as UIViewController
                                    self.view.window!.rootViewController = viewcontroller
                                  }else{
                                    UIUtils.ShowError(self, message: "Invalid credentials")
                                  }
    })
  }
  
  func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
    emailTextField!.text = "john.smith@gmail.com"
    passwordTextField!.text = "john"
  }
}

