//
//  VideoPlayer.swift
//  AVFoundationDemo
//
//  Created by tag on 12/14/15.
//  Copyright © 2015 tag. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: AVPlayerViewController
{
    var videoURL: NSURL? = nil
    var videoPlayer: AVPlayer? = AVPlayer()
    
    
    //    MARK: - View Life Cycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadVideo()
    }
    
    
    //    MARK: - NSNotification Methods
    
    func playerDidReachEndNotificationHandler(notification: NSNotification)
    {
        print("playerDidReachEndNotification")
    }
    
    
    //    MARK: - Other Methods
    
    func loadVideo()
    {
        videoPlayer = AVPlayer(URL: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = videoPlayer
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidReachEndNotificationHandler:", name: AVPlayerItemDidPlayToEndTimeNotification, object: videoPlayer!.currentItem)
        
        self.presentViewController(playerViewController, animated: true)
            {
                playerViewController.player!.play()
        }
    }
}