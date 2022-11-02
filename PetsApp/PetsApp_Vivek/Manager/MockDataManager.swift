//
//  MockDataManager.swift
//  PetsApp_Vivek
//


import Foundation

//class MockDataManager: DataManager {
//    static let shared = MockDataManager()
//    var mockBundle: MockBundle = MockBundle.main as! MockBundle
//    
//    private func getfilePath(for operation: Operation) -> String? {
//        return mockBundle.path(forResource: operation.getJsonFiles().rawValue,
//                                ofType: "json")
//    }
//    
//    func parseWorkingTime(completion: @escaping (Settings?, Error?) -> Void) {
//        guard let filePath = getfilePath(for: .WORKING_TIME) else {
//            return completion(nil, PetsError.filePathError)
//        }
//        
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
//            var configData = try JSONDecoder().decode(ConfigModel.self, from: data)
//            configData.settings.computeStartAndEndTime()
//            completion(configData.settings,nil)
//        }catch {
//            ConsoleLogger.log(message: "DataManager: parseWorkingTime with error: \(error)")
//            completion(nil,error)
//        }
//    }
//
//}
//
//class MockBundle: Bundle {}
