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

class DogApi {
    
    class func getBreeds(completionHandler: (_ breeds:[String]) -> Void){
        Alamofire.request("https://dog.ceo/api/breeds/list/all").responseJSON { (responseData) -> Void in
            if let value = responseData.result.value {
                let jsonResponse = JSON(value)
                if let status = jsonResponse["status"].string, status != "success"{
                    // todo: handle an unsuccessfull call
                    print("THE STATUS IS: \(status)")
                } else {
                    // all is well and we can continue
                    if let breeds = jsonResponse["message"].dictionary {
                        // create the breeds
                        print(breeds)
                    }
                }
            }
        }
    }
}
