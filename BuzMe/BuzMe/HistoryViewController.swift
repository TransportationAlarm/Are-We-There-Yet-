//
//  HistoryViewController.swift
//  BuzMe
//
//  Created by Anita on 3/30/16.
//  Copyright © 2016 BuzMe-codepath. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var passedDistance: String!
    var passedDestination: String!
    var passedOrigin: String!
    
    var passedDistanceArray: [String]?
    var passedDestinationArray: [String]?
    var passedOriginArray: [String]?
    
    var historyInfo = [String: [String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor.darkGrayColor()
        
        historyInformation()
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func historyInformation() {
        
        print(passedDistanceArray)
        print(passedDestinationArray)
        print(passedOriginArray)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let passedDestinationArray = passedDestinationArray {
            return passedDestinationArray.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HistoryTableViewCell", forIndexPath: indexPath) as! HistoryTableViewCell

        cell.startLabel.text = self.passedOriginArray![indexPath.item]
        cell.destinationLabel.text = self.passedDestinationArray![indexPath.item]
        cell.distanceLabel.text = self.passedDistanceArray![indexPath.item]
        
        cell.backgroundColor = UIColor.darkGrayColor()
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
