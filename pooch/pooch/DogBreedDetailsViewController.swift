//
//  DogBreedDetailsViewController.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import UIKit


class DogBreedDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    @IBOutlet weak var image: UIImageView!
    var dog: DogBreed?{
        didSet{
            getImage()
        }
    }
    var selectedSubBreed: String?{
        didSet{
            getImage()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    var urls:[URL]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let name = dog?.name{
            DogApi.getAllBreedImage(breedName: name, subBreedName: selectedSubBreed) { (url) in
                self.urls = url
                self.tableView.reloadData()
            }
        }
    }
    
    func getImage() {
        if let breedName = dog?.name, let subBreed = selectedSubBreed {
            DogApi.getRandomBreedImage(breedName: breedName, subBreedName: subBreed) { (url) in
                self.image.af_setImage(withURL: url)
            }
        } else if let breedName = dog?.name{
            DogApi.getRandomBreedImage(breedName: breedName) { (url) in
                self.image.af_setImage(withURL: url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.urls?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cellId")
        if let urls = self.urls {
            cell.textLabel?.text = urls[indexPath.row].absoluteString
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urls = self.urls {
            let selectedUrl = urls[indexPath.row]
            self.image.af_setImage(withURL: selectedUrl)
        }
    }
}
