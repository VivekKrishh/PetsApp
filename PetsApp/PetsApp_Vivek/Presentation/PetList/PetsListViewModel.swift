//
//  PetsListViewModel.swift
//  PetsApp_Vivek
//

import Foundation
import UIKit

typealias completionHandler = ((_ error: ErrorContent?) -> Void)
typealias ErrorContent = (imageName: String, message: NSAttributedString)

class PetsListViewModel {
        
    lazy var petsListData: [Pet]? = []
    
    var workingTime: Settings?
    
    let dataCenter: DataManager
    
    init(dataCenter: DataManager =  DataManager.shared) {
        self.dataCenter = dataCenter
    }
    
    //MARK: - Fetch Data
    func getData(filePath: String, completion: @escaping completionHandler) {
        fetchWorkingTime(filePath: filePath) { openTime, closeTime, error in
            if error == .filePathError {
                completion(ErrorHandler().getErrorContent(forError: .filePathError))
            }else if error == .parsingError {
                completion(ErrorHandler().getErrorContent(forError: .parsingError))
            } else {
                guard CheckTimeExist(startTime: openTime!, endTime: closeTime!) else {
                    completion(ErrorHandler().getErrorContent(forError: .shopClosedError))
                    return
                }
                self.getPetsData(filePath: DataManager.shared.getfilePath(for: .GET_PETS)!, completion: completion)
            }
        }
    }
    
    func fetchWorkingTime(filePath:String, onCompletion:@escaping(_ openTime:Int?, _ closeTime:Int?, _ error:PetsError?) -> Void) {
        
        dataCenter.parseWorkingTime(fileName: filePath) { settings, error in
            onCompletion(settings?.startTime, settings?.endTime, error)
        }
    }
    
    func getPetsData(filePath:String ,completion: @escaping completionHandler) {
        dataCenter.parsePetsList(filePath: filePath) { responseModel, error in
            if let response = responseModel,
               let pets = response.pets {
                self.petsListData = pets
            }
            completion(error == nil ? nil : ErrorHandler().getErrorContent(forError: error as! PetsError))
        }
    }
    
    //MARK: - Helper methods
    func getPetsCount() -> Int {
        guard let petList = self.petsListData else {
            return 0
        }
        return petList.count
    }
    
    func getPetAt(index: Int) -> Pet? {
        return self.petsListData?[index]
    }
    
    func getPetContentUrl(at index: Int) -> String {
        return getPetAt(index: index)?.contentURL ?? ""
    }
    
    func getPetName(at index: Int) -> String {
        return getPetAt(index: index)?.title ?? ""
    }
    
    func getAlertTitle() -> String {
        return Constants.Texts.shopClosedMessage
    }
    
    func getRefreshControlText() -> String {
        return Constants.Texts.pullToRefresh
    }
}

