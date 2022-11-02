//
//  PetDetailViewModel.swift
//  PetsApp_Vivek
//

import Foundation

class PetDetailViewModel {
    
    var pet: Pet!
    
    init(pet: Pet) {
        self.pet = pet
    }
    
    func getPetTitle() -> String {
        return pet.title
    }
    
    func getPetContentURL() -> String {
        return pet.contentURL
    }
}
