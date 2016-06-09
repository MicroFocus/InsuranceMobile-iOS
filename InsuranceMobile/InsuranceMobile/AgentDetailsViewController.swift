/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

import Foundation
import UIKit

class AgentDetailsViewController: UITableViewController {
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  
  var agent: Agent!
  
  override func viewDidLoad() {
    firstNameLabel.text = agent!.firstName
    lastNameLabel.text = agent!.lastName
    addressLabel.text = agent!.address + ", " + agent!.zipCode + " " + agent!.city + " " + agent!.state
    phoneLabel.text = agent!.phone
  }
}