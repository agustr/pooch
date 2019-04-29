//
//  BreedsViewController.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import UIKit
import SwiftyJSON

class BreedsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var breedsDatasource:[DogBreed] = []
    var lastSelectedDog: DogBreed?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Breeds"
        // Do any additional setup after loading the view.
        refresh()
    }
    
    func refresh() {
        DogApi.getBreeds { (breedsList) in
            self.breedsDatasource = breedsList
            self.tableView.reloadData()
        }
    }
    
    func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int{
        return breedsDatasource.count
    }
    
    func numberOfSections(in: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = breedsDatasource[indexPath.row].name
        print(breedsDatasource[indexPath.row].subBreeds.joined(separator: ", "))
        cell.detailTextLabel?.text = breedsDatasource[indexPath.row].subBreeds.joined(separator: ", ")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.lastSelectedDog = breedsDatasource[indexPath.row]
        let selectedBreed = breedsDatasource[indexPath.row]
        if selectedBreed.subBreeds.count > 0 {
            // navigat to subbreed page
            performSegue(withIdentifier: "DogSubBreedsSegue", sender: nil)
        } else {
            // navigate to breeds detail page
            performSegue(withIdentifier: "dogBreedDetailsSegue", sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DogSubBreedsSegue" {
            if let destinationVC = segue.destination as? DogSubBreedsViewController {
                destinationVC.dog = self.lastSelectedDog
            }
        }
        
        if segue.identifier == "dogBreedDetailsSegue" {
            if let destinationVC = segue.destination as? DogBreedDetailsViewController {
                destinationVC.dog = self.lastSelectedDog
            }
        }
    }
}
