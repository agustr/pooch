//
//  ViewController.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DogApi.getBreeds { (strings) in
            for string in strings {
                print(string)
            }
        }
    }


}

