//
//  BreedsViewController.swift
//  pooch
//
//  Created by Agust Rafnsson on 2019-04-29.
//  Copyright © 2019 Electrolux. All rights reserved.
//

import UIKit
import SwiftyJSON

class BreedsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var breedsDatasource:[String:JSON] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return breedsDatasource?.count
    }
    
    func numberOfSections(in: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        if let dog = self.breedsDatasource[4]{
            cell.textLabel?.text =
        }
        
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
