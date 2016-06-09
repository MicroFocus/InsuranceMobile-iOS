/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class TextFieldUtils {
  static func validate(textField: UITextField!) -> Bool {
    let result = !textField!.text!.isEmpty
    
    clearError(textField)
    
    if (!result) {
      markError(textField)
    }
    return result
  }
  
  static func validateDate(textField: UITextField!) -> Bool {
    var result = validate(textField)
    
    if (result) {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "dd.MM.yyyy"
      
      let date:NSDate? = dateFormatter.dateFromString(textField!.text!)
      if (date == nil) {
        result = false
        
        markError(textField)
      }
    }
    
    return result
  }
  
  static func validate(control: UIButton!, defaultText: String) -> Bool {
    let result = control.titleForState(.Normal) != defaultText
    
    clearError(control)
    
    if (!result) {
      markError(control)
    }
    return result
  }
  
  static func validate(control: UISegmentedControl!) -> Bool {
    let result = control.selectedSegmentIndex > -1
    
    clearError(control)
    
    if (!result) {
      markError(control)
    }
    return result
  }
  
  static func clearError(control: UIControl) {
    control.layer.borderWidth = 0
  }
  
  static func markError(control: UIControl) {
    control.layer.cornerRadius = 4
    control.layer.masksToBounds = true
    control.layer.borderColor = UIColor.redColor().CGColor
    control.layer.borderWidth = 1
  }
  
}