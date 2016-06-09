/**
 * Copyright 2013 Micro Focus. All rights reserved.
 * Portions Copyright 1992-2009 Borland Software Corporation (a Micro Focus company).
 */

import Foundation

class Make {
  static let makes: [Make] = [
    Make(name: "Buick", models: ["Century", "Electra", "Enclave", "Le Sabre", "Roadmaster", "Skylark"]),
    Make(name: "Chrysler", models: ["300 M", "Aspen", "Crossfire", "Grand Voyager", "Le Baron", "PT Cruiser", "Sebring"]),
    Make(name: "Cadillac", models: ["BLS", "Deville", "Eldorado"]),
    Make(name: "Toyota", models: ["4-Runner", "Avalon", "Camry", "Hilux", "Celica"]),
    Make(name: "Pontiac", models: ["Firebird", "Trans Sport", "Solstice Cabriolet"]),
    Make(name: "Lexus", models: ["GS430", "RX400", "LS600h", "ES 350"])
  ]
  
  static func GetMake(name: String) -> Make? {
    return makes.filter { $0.name == name }.first
  }
  
  var name: String
  var models: [String]
  
  init(name: String, models: [String]) {
    self.name = name
    self.models = models
  }
}