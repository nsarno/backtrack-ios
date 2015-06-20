//
//  BacktrackViewController.swift
//  Backtrack
//
//  Created by Arnaud Mesureur on 11/05/15.
//  Copyright (c) 2015 Arnaud Mesureur. All rights reserved.
//

import UIKit

class BacktrackViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    var code : String = "000000000000"
    var productData : JSON?
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let url = NSURL(string: "http://localhost:3000/products/\(self.code)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if (error != nil) {
                println("error: \(error.description)")
            }
            else {
                self.productData = JSON(data: data)["product"]
                dispatch_async(dispatch_get_main_queue()) {
                    let url = NSURL(string: self.productData!["image_urls"][0].stringValue)
                    let data = NSData(contentsOfURL: url!)
                    self.productImageView.image = UIImage(data: data!)
                    println(self.productData!)
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("DataCell") as! UITableViewCell
        if self.productData != nil {
            switch indexPath.row {
                case 0:
                    cell.textLabel?.text = self.productData!["manufacturer"].stringValue
                case 1:
                    cell.textLabel?.text = self.productData!["brand"].stringValue
                case 2:
                    cell.textLabel?.text = self.productData!["name"].stringValue
                case 3:
                    cell.textLabel?.text = self.productData!["blacklisted"].boolValue ? "Blacklisted" : "Not blacklisted"
                default:
                    cell.textLabel?.text = "Hello"
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
