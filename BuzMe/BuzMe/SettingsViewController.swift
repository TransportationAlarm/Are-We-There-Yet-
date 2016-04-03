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
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var tableView: UITableView!
    
    let soundsMap: [String: SystemSoundID]? = ["Choo Choo": 1023, "Descent": 1024, "Minuet": 1027, "News Flash": 1028, "Sherwood Forest": 1030]
    
    var reproductor = AVAudioPlayer()
   
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

        
//        //configure you cell here.
//        if !checked[indexPath.row] {
//            cell.accessoryType = .None
//        } else if checked[indexPath.row] {
//            cell.accessoryType = .Checkmark
//        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .Checkmark
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
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
        }
    }
    
    @IBAction func onVibrateRing(sender: AnyObject) {
        if (vibrateOnRingSwitch.on) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }

    @IBAction func onVibrateSilent(sender: AnyObject) {
        if (vibrateOnSilentSwitch.on) {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        let selectedValue = Float(sender.value)
        reproductor.volume = selectedValue
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
