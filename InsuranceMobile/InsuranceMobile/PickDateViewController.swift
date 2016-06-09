/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class PickDateViewController: UIViewController {
  var dateFormatter = NSDateFormatter()
  
  @IBOutlet weak var datePicker: UIDatePicker!
  
  var inputDate: String!
  
  override func viewDidLoad() {
    dateFormatter.dateFormat = "dd.MM.yyyy"
    
    if (inputDate != nil) {
      let date = dateFormatter.dateFromString(inputDate!)
      
      if (date != nil) {
        datePicker.date = date!
      }
    }
  }
  
  @IBAction func okButtonClicked(sender: AnyObject) {
    self.navigationController?.parentViewController
    let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2] as! SignUpViewController
    
    vc.birthdayTextField.text = dateFormatter.stringFromDate(datePicker.date)
    
    self.navigationController?.popViewControllerAnimated(true)
  }
}