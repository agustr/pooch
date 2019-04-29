//
//  DogSubBreeds.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import UIKit
import AlamofireImage

class DogSubBreedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var dog: DogBreed? {
        didSet{
            getImage()
        }
    }
    var lastSelectedSubBreed:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getImage() {
        if let breedName = dog?.name{
            DogApi.getRandomBreedImage(breedName: breedName) { (url) in
                self.image.af_setImage(withURL: url)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = dog?.name
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dog?.subBreeds.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cellId")
        if let subBreedName = dog?.subBreeds[indexPath.row], let breedName = dog?.name {
            cell.textLabel?.text = "\(subBreedName) \(breedName)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lastSelectedSubBreed = self.dog?.subBreeds[indexPath.row]
        if lastSelectedSubBreed != nil {
            performSegue(withIdentifier: "dogBreedDetailsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dogBreedDetailsSegue" {
            if let destinationVC = segue.destination as? DogBreedDetailsViewController {
                destinationVC.dog = self.dog
                destinationVC.selectedSubBreed = lastSelectedSubBreed
            }
        }
    }
}
