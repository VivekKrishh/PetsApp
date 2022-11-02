//
//  ConfigModel.swift
//  PetsApp_Vivek
//

import Foundation

// MARK: - ConfigModel
struct ConfigModel: Codable {
    var settings: Settings
}

// MARK: - Settings
struct Settings: Codable {
    var workHours: String 
    
    var startTime: Int?
    var endTime: Int?
    
    mutating func computeStartAndEndTime() {
        let separatedStrings = workHours.components(separatedBy: " ")
        let openTime = separatedStrings[1]
        let closeTime = separatedStrings[3]
        startTime = openTime.components(separatedBy: ":").first?.toInt()
        endTime = closeTime.components(separatedBy: ":").first?.toInt()
    }
}
