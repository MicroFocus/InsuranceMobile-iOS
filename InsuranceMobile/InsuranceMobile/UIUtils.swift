/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class UIUtils {
  static func ShowError(controller: UIViewController, message: String) {
    let alert = UIAlertController(title: "🙁", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    controller.presentViewController(alert, animated: true, completion: nil)
  }
}