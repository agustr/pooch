//
//  DogApi.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON
import CoreData

class DogApi {
    
    class func findOrCreate(_ breed: (key: String, value: JSON)) {
        if let subBreeds = breed.value.arrayObject as? [String] {
            if subBreeds.count > 0 {
//                let sBreed = SubBreed(context: context)
//                newBreed.addToSubbreeds(sBreed)
//            } else {
//                findOrCreate(<#T##breed: (key: String, value: JSON)##(key: String, value: JSON)#>)
//            }
            }
        }
    }
    
    class func findOrCreate( breed: String, subBreeds: [String]) {
        AppDelegate.persistentContainer.performBackgroundTask({ (context) in
            let request: NSFetchRequest<Breed> = Breed.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", breed)
            do{
                let matches = try context.fetch(request)
                if matches.count > 0 {
//                    if let existingBreed =  matches.first,let existingSubbreeds = existingBreed.subbreeds as [SubBreed]{
//
//                    }
                } else {
                    // add breed
                    let newBreed = Breed(context: context)
                    newBreed.name =  breed
                    do {
                        try context.save()
                    } catch {
                        // something went wrong with saving
                    }
                }
            } catch {
                // something went wrong with fetching
            }
        })
    }
    
    class func getBreeds(completionHandler:@escaping (_ breeds:[String:JSON]) -> Void) {
        Alamofire.request("https://dog.ceo/api/breeds/list/all").responseJSON { (responseData) -> Void in
            if let value = responseData.result.value {
                let jsonResponse = JSON(value)
                if let status = jsonResponse["status"].string, status != "success"{
                    // todo: handle an unsuccessfull call
                    print("THE STATUS IS: \(status)")
                } else {
                    // all is well and we can continue
                    if let breeds = jsonResponse["message"].dictionary {
                        completionHandler(breeds)
                    }
                }
            }
        }
    }
}
