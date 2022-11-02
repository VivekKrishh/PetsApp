//
//  PetsListResponseModel.swift
//  PetsApp_Vivek
//


import Foundation

// MARK: - PetsList
struct PetsListResponseModel: Codable {
    var pets: [Pet]?
}

// MARK: - Pet
struct Pet: Codable {
    var imageURL: String
    var title: String
    var contentURL: String
    var dateAdded: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case contentURL = "content_url"
        case dateAdded = "date_added"
    }
}
