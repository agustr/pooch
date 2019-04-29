//
//  File.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import Foundation

class DogBreed  {
    var name: String
    var subBreeds: [String] = []
    
    init(name: String, subBreeds:[String] = []) {
        self.name =  name
        self.subBreeds = subBreeds
    }
}
