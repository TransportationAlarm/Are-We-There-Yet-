//
//  SettingsViewController.swift
//  BuzMe
//
//  Created by Anita on 3/30/16.
//  Copyright © 2016 BuzMe-codepath. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var vibrateOnRingSwitch: UISwitch!
    @IBOutlet weak var vibrateOnSilentSwitch: UISwitch!
    
    var lastSelectedRow: NSIndexPath!
    
    var vibOnRingOn: Bool!
    var vibOnSilentOn: Bool!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selctedRow: Int!
    var audioPlayer: AVAudioPlayer!
    
    let soundsMap: [String: SystemSoundID]? = ["Choo Choo": 1023, "Descent": 1024, "Minuet": 1027, "News Flash": 1028, "Sherwood Forest": 1030]
    var checked = [Bool](count: 5, repeatedValue: false)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.soundsMap?.keys.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AlarmCell") as! AlarmTableViewCell
        let soundName = Array(soundsMap!.keys)
        cell.textLabel?.text = soundName[indexPath.row]
        
        
        if checkMarkToDisplay == indexPath.row {
            cell.accessoryType = .Checkmark
        }
        else{
            cell.accessoryType = .None
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark

        }
        
        if (indexPath.row == 0) {
            let soundName = Array(soundsMap!.keys)[0]
            let soundId = soundsMap![soundName]
            AudioServicesPlayAlertSound(soundId!)
        } else if (indexPath.row == 1) {
            let soundName = Array(soundsMap!.keys)[1]
            let soundId = soundsMap![soundName]
            AudioServicesPlayAlertSound(soundId!)
        } else if (indexPath.row == 2) {
            let soundName = Array(soundsMap!.keys)[2]
            let soundId = soundsMap![soundName]
            AudioServicesPlayAlertSound(soundId!)
        } else if (indexPath.row == 3) {
            let soundName = Array(soundsMap!.keys)[3]
            let soundId = soundsMap![soundName]
            AudioServicesPlayAlertSound(soundId!)
        } else {
            let soundName = Array(soundsMap!.keys)[4]
            let soundId = soundsMap![soundName]
            AudioServicesPlayAlertSound(soundId!)
        }
    
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return "Alarm:"
    
    
    }

    @IBAction func onVibrateRing(sender: AnyObject) {
        if (vibrateOnRingSwitch.on) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            vibOnRingOn = true
        } else {
            vibOnRingOn = false
        }
    }

    @IBAction func onVibrateSilent(sender: AnyObject) {
        if (vibrateOnSilentSwitch.on) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            vibOnSilentOn = true
        } else {
            vibOnSilentOn = false
        }
    }
    
    @IBAction func onClearHistoryPressed(sender: AnyObject) {
        
        // history page needs to be set up first
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
