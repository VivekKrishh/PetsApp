//
//  Operation.swift
//  PetsApp_Vivek
//
//

import Foundation

enum Operation {
    case WORKING_TIME
    case GET_PETS
    
    func getJsonFiles() -> JsonFiles {
        switch self {
        case .WORKING_TIME:
            return .workingTime
        case .GET_PETS:
            return .petList
        }
    }
    
    func getImageName() -> Images {
        switch self {
        case .WORKING_TIME:
            return .SAD_PET
        case .GET_PETS:
            return .SHOP_CLOSED
        }
    }
}

enum Images: String {
    case SAD_PET = "Sad"
    case SHOP_CLOSED = "shopClosed"
}
