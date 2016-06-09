/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class User {
  static var users: [User] = [
    User(email: "john.smith@gmail.com", password : "john", firstName: "John", lastName: "Smith", birthday: "01.01.1980")
  ]
  
  static var currentUser: User?
  
  static func GetUser(email: String) -> User? {
    return users.filter { $0.email == email }.first
  }
  
  static func RegisterUser(user: User) -> Bool {
    if (GetUser(user.email) != nil) {
      return false
    }
    users.append(user)
    return true
  }
  
  static func Login(user: User) {
    currentUser = user
  }
  
  static func Logout() {
    currentUser = nil
  }
  
  var email: String!
  var password: String
  var firstName: String
  var lastName: String
  var birthday: String
  
  init(email: String, password: String, firstName: String, lastName: String, birthday: String) {
    self.email = email
    self.password = password
    self.firstName = firstName
    self.lastName = lastName
    self.birthday = birthday
  }
}