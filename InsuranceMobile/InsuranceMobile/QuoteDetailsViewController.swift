/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class QuoteDetailsViewController: UIViewController {
  @IBOutlet weak var zipCodeLabel: UILabel!
  
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var genderLabel: UILabel!
  
  @IBOutlet weak var makeLabel: UILabel!
  @IBOutlet weak var modelLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  
  
  @IBOutlet weak var drivingRecordLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  
  var zip: Int?
  var age: Int?
  var gender: String?
  var drivingRecord: String?
  var type: String?
  var year: Int?
  var make: String?
  var model: String?
  var financialInfo: String?
  
  override func viewDidLoad() {
    zipCodeLabel!.text = String(zip!)
    ageLabel!.text = String(age!)
    genderLabel!.text = gender
    drivingRecordLabel!.text = drivingRecord
    
    typeLabel!.text = type
    makeLabel!.text = make
    modelLabel!.text = model
    yearLabel!.text = String(year!)
    
    quoteLabel!.text = quoteLabel!.text!.stringByReplacingOccurrencesOfString("%s", withString: String(getQuote()), options: NSStringCompareOptions.LiteralSearch, range: nil)
  }
  
  func getQuote() -> Double {
    var result: Double = 1000.0
    
    if ("Truck" == type) {
      result *= 1.2
    }
    if ("Male" == gender) {
      result *= 1.2
    }
    
    if ("Poor" == drivingRecord) {
      result += 300
    }else     if ("Fair" == drivingRecord) {
      result += 200
    }else if ("Good" == drivingRecord) {
      result += 100
    }
    
    
    if (financialInfo == "Financed") {
      result *= 1.2
    }else if (financialInfo == "Lease") {
      result *= 1.4
    }
    
    return result
  }
}