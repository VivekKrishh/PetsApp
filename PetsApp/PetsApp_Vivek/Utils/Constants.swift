//
//  Constants.swift
//  PetsApp_Vivek
//

import Foundation

struct Constants {
    struct StoryboardIdentifiers {
        static let petDetailId = "PetDetailViewController"
    }
    struct CellIdentifiers {
        static let petListId = "PetsListTableCell"
    }
    struct ImageNames {
        static let noimage = "noimage"
    }
    struct CellHeight {
        static let petList = 140.0
    }
    struct Storyboard {
        static let main = "Main"
    }
    struct Texts {
        static let shopClosedMessage = "Shop is not open at the moment"
        static let pullToRefresh = "Pull to refresh"
    }
}

extension String {
    
    func toInt() -> Int? {
        return Int(self)
    }
}
