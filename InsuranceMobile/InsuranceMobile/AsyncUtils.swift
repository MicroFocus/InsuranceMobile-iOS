/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class AsyncUtils {
  
  static func sleepDefaultDelay() {
    sleep(1)
  }
  
  // from http://stackoverflow.com/a/30841417
  static func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
    dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
      if(background != nil){ background!(); }
      
      let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
      dispatch_after(popTime, dispatch_get_main_queue()) {
        if(completion != nil){ completion!(); }
      }
    }
  }
}