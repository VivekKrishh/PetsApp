//
//  DataManager.swift
//  PetsApp_Vivek
//
//  Created by Vishnu on 11/1/22.
//

import Foundation

enum JsonFiles: String {
    case workingTime = "config"
    case petList = "pets_list"
}

class DataManager {
    
    static let shared = DataManager()
    
    var bundle: Bundle = Bundle.main
    
    private init() {}
    
    func getfilePath(for operation: Operation) -> String? {
        return bundle.path(forResource: operation.getJsonFiles().rawValue,
                                ofType: "json")
    }
    
    func parseWorkingTime(fileName: String? , completion: @escaping (Settings?, PetsError?) -> Void) {
        guard let filePath = fileName else {
            return completion(nil, PetsError.filePathError)
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            var configData = try JSONDecoder().decode(ConfigModel.self, from: data)
            configData.settings.computeStartAndEndTime()
            completion(configData.settings,nil)
        }catch {
            ConsoleLogger.log(message: "DataManager: parseWorkingTime with error: \(error)")
            completion(nil,.parsingError)
        }
    }
    
    func parsePetsList(filePath:String?, completion: @escaping (PetsListResponseModel?, Error?) -> Void) {
        guard let filePath = filePath else {
            return completion(nil, PetsError.filePathError)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let pets = try JSONDecoder().decode(PetsListResponseModel.self, from: data)
            completion(pets, nil)
        }catch {
            ConsoleLogger.log(message: "DataManager: parsePetsList with error: \(error)")
            completion(nil,PetsError.parsingError)
        }
    }
    

}


class ConsoleLogger {
    static func log(message: String) {
        print(message)
    }
}


