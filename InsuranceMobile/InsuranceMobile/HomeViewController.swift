/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var menuButton: UIBarButtonItem!
  @IBOutlet weak var loggedInAsLabel: UILabel!
  
  override func viewDidLoad() {
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    let user = User.currentUser!
    
    loggedInAsLabel!.text = loggedInAsLabel!.text! + " " + user.firstName + " " + user.lastName
  }
}
