/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit
import CoreLocation

class AgentLookupViewController: UITableViewController, CLLocationManagerDelegate {
  @IBOutlet weak var menuButton: UIBarButtonItem!
  @IBOutlet weak var zipCodeTextField: UITextField!
  @IBOutlet weak var findByLocationButton: UIButton!
  @IBOutlet weak var findByNameButton: UIButton!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var findAllButton: UIButton!
  
  private var locationManager: CLLocationManager?
  private var lastZipCode: String?
  
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
    let vc = segue.destinationViewController as! AgentListViewController
    
    let button = sender as! UIButton
    
    if (button == findByNameButton) {
      vc.queryName = nameTextField!.text
    }else if (button == findByLocationButton) {
      vc.queryZip = zipCodeTextField!.text
    }
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    let button = sender as! UIButton
    
    if (button == findByNameButton) {
      return TextFieldUtils.validate(nameTextField)
    }else if (button == findByLocationButton) {
      return TextFieldUtils.validate(zipCodeTextField)
    }
    
    return true
  }
  
  @IBAction func requestLocationClicked(sender: AnyObject) {
    if (CLLocationManager.locationServicesEnabled())
    {
      self.lastZipCode = nil
      
      if (CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse) {
        let alertVC = UIAlertController(title: "Geolocation not enabled", message: "You need to enable geolocation of this app in Settings for use it", preferredStyle: .ActionSheet)
        alertVC.addAction(UIAlertAction(title: "Open Settings", style: .Default) { value in
          
          UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
          })
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alertVC, animated: true, completion: nil)
      }
      
      if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.startUpdatingLocation()
      }else{
        UIUtils.ShowError(self, message: "This app doesn't have permission to access your location")
      }
    }else{
      UIUtils.ShowError(self, message: "Location services disabled")
    }
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[0]
    
    CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
      if error != nil {
        return
      }
      
      if placemarks!.count > 0 {
        let pm = placemarks![0]
        
        if (pm.postalCode != nil) {
          let zipCode = pm.postalCode
          
          if (zipCode != self.lastZipCode || self.lastZipCode == nil) {
            self.lastZipCode = zipCode
            self.zipCodeTextField.text = zipCode
          }
        }
      }
    })
  }
}
