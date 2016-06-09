/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class AboutViewController: UIViewController {
  @IBOutlet weak var menuButton: UIBarButtonItem!
  
  @IBOutlet weak var webView: UIWebView!
  override func viewDidLoad() {
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
      
      let localfilePath = NSBundle.mainBundle().URLForResource("about", withExtension: "html");
      let myRequest = NSURLRequest(URL: localfilePath!);
      webView.loadRequest(myRequest);
    }
  }
}
