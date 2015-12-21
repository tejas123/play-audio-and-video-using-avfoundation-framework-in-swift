//
//  ViewController.swift
//  AVFoundationDemo
//
//  Created by tag on 12/14/15.
//  Copyright © 2015 tag. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate
{
    var audioPlayer: AVAudioPlayer? = AVAudioPlayer()
    
    var playAudioRepeatedly: Bool = false
    
    let arrAudio: [String] = ["chime_bell_ding", "music_marimba_chord", "pop_drip"]
    
    @IBOutlet var btnPlayAudioRepeatedly: UIButton!
    @IBOutlet var btnStopAudio: UIButton!
    
    //    MARK: - View Life Cycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //    MARK: - AVAudioPlayerDelegate Methods
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool)
    {
        if (playAudioRepeatedly)
        {
            audioPlayer!.play()
        }
    }
    
    
    //    MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let videoPlayerViewController = self.storyboard!.instantiateViewControllerWithIdentifier("VideoPlayerViewController") as! VideoPlayerViewController
        videoPlayerViewController.videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
        
        self.navigationController!.pushViewController(videoPlayerViewController, animated: true)
    }
    
    
    //    MARK: - Action Methods
    
    @IBAction func btnPlayAudioTapped(sender: AnyObject)
    {
        playAudio()
    }
    
    @IBAction func btnPlayVideoTapped(sender: AnyObject)
    {
        getVideos()
    }
    
    @IBAction func btnPlayAudioRepeatedlyTapped(sender: AnyObject)
    {
        btnPlayAudioRepeatedly.enabled = false
        btnStopAudio.enabled = true
        playAudioRepeatedly = true
        playAudio()
    }
    
    @IBAction func btnStopAudioTapped(sender: AnyObject)
    {
        stopAudio()
    }
    
    
    //    MARK: - Other Methods
    
    func playAudio()
    {
        // get random number for sound from the array
        let intRandomNum = Int(arc4random_uniform(UInt32(arrAudio.count)))
        
        // set URL of the sound
        let soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(arrAudio[intRandomNum], ofType: "wav")!)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL)
            audioPlayer!.delegate = self
            
            // check if audioPlayer is prepared to play audio
            if (audioPlayer!.prepareToPlay())
            {
                audioPlayer!.play()
            }
        }
        catch
        { }
    }
    
    func stopAudio()
    {
        audioPlayer!.stop()
        btnPlayAudioRepeatedly.enabled = true
        btnStopAudio.enabled = false
        playAudioRepeatedly = false
    }
    
    func getVideos()
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .SavedPhotosAlbum
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        imagePickerController.delegate = self
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
}