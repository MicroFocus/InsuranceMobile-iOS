/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class SelectMakeViewController: UITableViewController {
  var make: String!
  
  override func viewDidLoad() {
    // Remove empty cells: http://stackoverflow.com/a/28244385
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Make.makes.count
  }
  
  override func tableView(tableView: UITableView,
                          cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
    
    cell.textLabel!.text = Make.makes[indexPath.row].name
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    let row = indexPath.row
    
    self.navigationController?.parentViewController
    let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - 2] as! AutoQuoteViewController
    
    vc.make = Make.makes[row].name
    vc.model = nil
    
    self.navigationController?.popViewControllerAnimated(true)
  }
}
