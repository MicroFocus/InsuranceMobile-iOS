/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class MenuViewController : UITableViewController {
  override func viewDidLoad() {
    // Remove empty cells: http://stackoverflow.com/a/28244385
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
}