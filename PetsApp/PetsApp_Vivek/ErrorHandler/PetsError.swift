//
//  PetsError.swift
//  PetsApp_Vivek
//
//

import Foundation
import UIKit

enum PetsError: Error {
    
    case fetchPetsError
    case parsingError
    case shopClosedError
    case filePathError
    
    func getImageName() -> Images {
        switch self {
        case .shopClosedError:
            return .SHOP_CLOSED
        default:
            return .SAD_PET
        }
    }
}


class ErrorHandler {
    
    func getErrorContent(forError error: PetsError) -> ErrorContent {
        let image: String = error.getImageName().rawValue
        var message: NSAttributedString
        switch error {
        case .shopClosedError:
            message = getShopClosedTitleText()
         default:
            message = NSAttributedString(string: "Something Went Wrong")
        }
        return (image, message)
    }
    
    func getShopClosedTitleText() -> NSAttributedString {

        let description = NSMutableAttributedString(string: "We're open from 9:00 - 6:00",
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                  NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        return description
    }

}


