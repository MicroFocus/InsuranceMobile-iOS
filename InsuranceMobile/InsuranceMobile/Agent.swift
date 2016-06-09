/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class Agent {
  static var agents: [Agent] = [
    Agent(firstName: "Alice", lastName: "Walker", address: "12 8th Street, Suite B", zipCode: "78731", city: "Austin", state: "TX", phone: "(512) 555-1212"),
    Agent(firstName: "Jim", lastName: "Taylor",  address: "12 8th Street, Suite B", zipCode: "1212", city: "Cupertino", state: "CA", phone: "(512) 555-1212"),
    Agent(firstName: "George", lastName: "Wilson",  address: "12 8th Street, Suite B", zipCode: "1212", city: "Chicago", state: "IL", phone: "(512) 555-1212"),
    Agent(firstName: "Willow", lastName: "Cameron",  address: "12 8th Street, Suite B", zipCode: "11921", city: "Boston", state: "VA", phone: "(512) 555-1212"),
    Agent(firstName: "Al", lastName: "Borland",  address: "1212 Main Street", zipCode: "10120", city: "New York", state: "NY", phone: "(512) 555-1212"),
    Agent(firstName: "Dave", lastName: "Clayton",  address: "1212 Main Street", zipCode: "30339", city: "Atlanta", state: "GA", phone: "(512) 555-1212")
  ]
  
  static func FindAgentsByName(name: String) -> [Agent] {
    if (name == "*") {
      return agents;
    }
    return agents.filter { $0.firstName.lowercaseString.containsString(name.lowercaseString) || $0.lastName.lowercaseString.containsString(name.lowercaseString)
    }
  }
  
  static func FindAgentsByZipCode(zipCode: String) -> [Agent] {
    if (zipCode == "*") {
      return agents;
    }
    return agents.filter { $0.zipCode == zipCode }
  }
  
  static func FindAllAgents() -> [Agent] {
    return agents
  }
  
  var firstName: String
  var lastName: String
  var address: String
  var city: String
  var zipCode: String
  var state: String
  var phone: String!
  
  init(firstName: String, lastName: String, address: String, zipCode: String, city: String, state: String, phone: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.address = address
    self.zipCode = zipCode
    self.city = city
    self.state = state
    self.phone = phone
  }
}