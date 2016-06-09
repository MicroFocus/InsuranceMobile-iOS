/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class AutoQuoteViewController: UITableViewController {
  
  @IBOutlet weak var zipCodeText: UITextField!
  @IBOutlet weak var emailText: UITextField!
  @IBOutlet weak var drivingRecordSegmentedControl: UISegmentedControl!
  @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
  @IBOutlet weak var ageText: UITextField!
  @IBOutlet weak var menuButton: UIBarButtonItem!
  @IBOutlet weak var selectMakeButton: UIButton!
  @IBOutlet weak var selectModelButton: UIButton!
  @IBOutlet weak var financialInfoSegmentedControl: UISegmentedControl!
  @IBOutlet weak var yearText: UITextField!
  @IBOutlet weak var automobileTypeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var submitButtomConstraint: NSLayoutConstraint!
  
  var make: String!
  var model: String!
  
  var previousConstant: CGFloat?
  
  static var defaultTextForSelect = "Select"
  
  override func viewWillAppear(animated: Bool) {
    if (make != nil) {
      selectMakeButton.setTitle(make, forState: .Normal)
    }
    if (model != nil) {
      selectModelButton.setTitle(model, forState: .Normal)
    }else{
      selectModelButton.setTitle(AutoQuoteViewController.defaultTextForSelect, forState: .Normal)
    }
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    
    let startDate:NSDate = dateFormatter.dateFromString(User.currentUser!.birthday)!
    let endDate:NSDate = NSDate()
    
    let cal = NSCalendar.currentCalendar()
    
    let unit:NSCalendarUnit = NSCalendarUnit.Year
    let components = cal.components(unit, fromDate: startDate, toDate: endDate, options: [])
    
    ageText.text = String(components.year)
    emailText.text = User.currentUser!.email
  }
  
  override func viewDidLoad() {
    if self.revealViewController() != nil {
      menuButton.target = self.revealViewController()
      menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    // Dismiss keyboard - see http://stackoverflow.com/a/27079103
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AutoQuoteViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.destinationViewController is SelectModelViewController) {
      let vc = segue.destinationViewController as! SelectModelViewController
      vc.make = selectMakeButton.titleForState(.Normal)
    }else if (segue.destinationViewController is QuoteDetailsViewController) {
      let vc = segue.destinationViewController as! QuoteDetailsViewController
      
      vc.zip = Int(zipCodeText!.text!)
      vc.age = Int(ageText!.text!)
      
      print(genderSegmentedControl.selectedSegmentIndex)
      
      if (genderSegmentedControl.selectedSegmentIndex == 0) {
        vc.gender = "Male"
      }else if (genderSegmentedControl.selectedSegmentIndex == 1) {
        vc.gender = "Female"
      }
      
      if (automobileTypeSegmentedControl.selectedSegmentIndex == 0) {
        vc.type = "Car"
      }else if (automobileTypeSegmentedControl.selectedSegmentIndex == 1) {
        vc.type = "Truck"
      }
      
      if (drivingRecordSegmentedControl.selectedSegmentIndex == 0) {
        vc.drivingRecord = "Excellent"
      }else if (drivingRecordSegmentedControl.selectedSegmentIndex == 1) {
        vc.drivingRecord = "Good"
      }else if (drivingRecordSegmentedControl.selectedSegmentIndex == 2) {
        vc.drivingRecord = "Fair"
      }else if (drivingRecordSegmentedControl.selectedSegmentIndex == 3) {
        vc.drivingRecord = "Poor"
      }
      
      vc.year = Int(yearText!.text!)
      vc.make = selectMakeButton.titleForState(.Normal)
      vc.model = selectModelButton.titleForState(.Normal)
      
      if (financialInfoSegmentedControl.selectedSegmentIndex == 0) {
        vc.financialInfo = "Own"
      }else if (financialInfoSegmentedControl.selectedSegmentIndex == 1) {
        vc.financialInfo = "Financed"
      }else if (financialInfoSegmentedControl.selectedSegmentIndex == 2) {
        vc.financialInfo = "Lease"
      }
    }
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    if ("selectModelSegue" == identifier) {
      return selectMakeButton.titleForState(.Normal) != AutoQuoteViewController.defaultTextForSelect
    }else if ("quoteDetailsSegue" == identifier) {
      var result = true
      
      result = TextFieldUtils.validate(zipCodeText) && result
      result = TextFieldUtils.validate(emailText) && result
      result = TextFieldUtils.validate(ageText) && result
      result = TextFieldUtils.validate(genderSegmentedControl) && result
      result = TextFieldUtils.validate(drivingRecordSegmentedControl) && result
      result = TextFieldUtils.validate(genderSegmentedControl) && result
      result = TextFieldUtils.validate(automobileTypeSegmentedControl) && result
      result = TextFieldUtils.validate(drivingRecordSegmentedControl) && result
      result = TextFieldUtils.validate(yearText) && result
      result = TextFieldUtils.validate(financialInfoSegmentedControl) && result
      
      result = TextFieldUtils.validate(selectMakeButton, defaultText: AutoQuoteViewController.defaultTextForSelect) && result
      result = TextFieldUtils.validate(selectModelButton, defaultText: AutoQuoteViewController.defaultTextForSelect) && result
      
      return result
    }
    return true
  }
}
