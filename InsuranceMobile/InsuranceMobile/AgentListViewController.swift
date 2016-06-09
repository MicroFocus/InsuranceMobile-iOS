/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation
import UIKit

class AgentListViewController: UITableViewController {
  var loading: Bool = false
  var queryName: String!
  var queryZip: String!
  
  var agents: [Agent] = []
  
  override func viewDidLoad() {
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    activityView.center=self.view.center
    activityView.startAnimating()
    self.view.addSubview(activityView)
    
    AsyncUtils.backgroundThread(background: {
      self.loading = true
      
      AsyncUtils.sleepDefaultDelay()
      
      if (self.queryName != nil) {
        self.agents = Agent.FindAgentsByName(self.queryName)
      }else if (self.queryZip != nil) {
        self.agents = Agent.FindAgentsByZipCode(self.queryZip)
      }else{
        self.agents = Agent.FindAllAgents()
      }
      self.loading = false
      },
      completion: {
        activityView.removeFromSuperview()
        self.tableView.reloadData()
      }
    )
    
    // Remove empty cells: http://stackoverflow.com/a/28244385
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return loading ? 0 : agents.count + 1
  }
  
  override func tableView(tableView: UITableView,
    cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCellWithIdentifier("TextCell", forIndexPath: indexPath)
      
      if (indexPath.row == 0) {
        cell.textLabel!.text = String(agents.count) + " agent" + (agents.count != 1 ? "s" : "") + " found"
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.selectionStyle = UITableViewCellSelectionStyle.None
      }else{
        let agent = agents[indexPath.row - 1]
        cell.textLabel!.text = agent.firstName + " " + agent.lastName
      }
      
      return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell = sender as! UITableViewCell
    let index = tableView.indexPathForCell(cell)?.item
    
    if (index > 0) {
      let agent = agents[index! - 1]
      let vc = segue.destinationViewController as! AgentDetailsViewController
      vc.agent = agent
    }
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    let cell = sender as! UITableViewCell
    let index = tableView.indexPathForCell(cell)?.item
    
    return index > 0
  }
}
