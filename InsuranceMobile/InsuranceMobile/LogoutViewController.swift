/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class LogoutViewController: UIViewController {
  override func viewDidAppear(animated: Bool) {
    User.Logout()
    
    var loginView: UIStoryboard!
    loginView = UIStoryboard(name: "Login", bundle: nil)
    let viewcontroller : UIViewController = loginView.instantiateViewControllerWithIdentifier("loginStoryBoard") as UIViewController
    self.view.window!.rootViewController = viewcontroller
  }
}