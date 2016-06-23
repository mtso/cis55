//
//  ViewController.swift
//  AudioDemo
//
//  Created by Matthew Tso on 6/15/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable Stop/Play button when application launches
        stopButton.enabled = false
        playButton.enabled = false
        
        // Set the audio file
        let directoryURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: .UserDomainMask).first! as NSURL
        let audioFileURL = directoryURL.URLByAppendingPathComponent("MyAudioMemo.m4a")
        
        // Setup audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
        } catch {
            print(error)
        }
        
        // Define the recorder setting
        let recorderSetting: [String: AnyObject] = [AVFormatIDKey: NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
                                                    AVSampleRateKey: NSNumber(float: 44100.0),
                                                    AVNumberOfChannelsKey: NSNumber(int: 2)]
        
        // Initiate and prepare the recorder
        do {
            try audioRecorder = AVAudioRecorder(URL: audioFileURL, settings: recorderSetting)
        } catch {
            print(error)
        }
        audioRecorder?.delegate = self
        audioRecorder?.meteringEnabled = true
        audioRecorder?.prepareToRecord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("try to alert audio recording finish recording")
        if flag {
            let alertMessage = UIAlertController(title: "Finished Recording", message: "Successfully recorded audio.", preferredStyle: .Alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertMessage, animated: true, completion: nil)
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        playButton.titleLabel?.text = "Play"
        playButton.selected = false
        
        let alertMessage = UIAlertController(title: "Finished Playing", message: "Finished playing the recording.", preferredStyle: .Alert)
        alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertMessage, animated: true, completion: nil)
    }
    
    @IBAction func play(sender: AnyObject) {
        if let recorder = audioRecorder {
            if !recorder.recording {
                do {
                    try audioPlayer = AVAudioPlayer(contentsOfURL: recorder.url)
                } catch {
                    print(error)
                }
                audioPlayer?.delegate = self
                audioPlayer?.play()
                
                playButton.titleLabel?.text = "Playing"
                playButton.selected = true
            }
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        recordButton.titleLabel?.text = "Record"
        recordButton.selected = false
        
        playButton.titleLabel?.text = "Play"
        playButton.selected = false
        
        stopButton.enabled = false
        playButton.enabled = true
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch {
            print(error)
        }
    }
    
    @IBAction func record(sender: AnyObject) {
        // Stop the audio player before recording
        if let player = audioPlayer {
            if player.playing {
                player.stop()
                playButton.titleLabel?.text = "Play"
                playButton.selected = false
            }
        }
        
        if let recorder = audioRecorder {
            if !recorder.recording {
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(true)
                } catch {
                    print(error)
                }
                
                // Start recording
                recorder.record()
                recordButton.titleLabel?.text = "Recording"
                recordButton.selected = true
            } else {
                recorder.pause()
                recordButton.titleLabel?.text = "Record"
                recordButton.selected = false
            }
        }
        
        stopButton.enabled = true
        playButton.enabled = false
    }
}



























