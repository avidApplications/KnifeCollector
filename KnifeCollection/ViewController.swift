//
//  ViewController.swift
//  KnifeCollection
//
//  Created by Bradley Stovall on 3/16/17.
//  Copyright © 2017 Bradley Stovall. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var knives : [Knife] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
        do {
            knives = try context.fetch(Knife.fetchRequest())
            tableView.reloadData()
        } catch {
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let knife = knives[indexPath.row]
        cell.textLabel?.text = knife.title
        cell.imageView?.image = UIImage(data: knife.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let knife = knives[indexPath.row]
        performSegue(withIdentifier: "knifeSegue", sender: knife)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! KnifeViewController
        nextVC.knife = sender as? Knife
    }
}
