//
//  ViewController.swift
//  Tick
//
//  Created by Martin Schinz on 28/10/2015.
//  Copyright © 2015 pebble{code}. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    // MARK: Properties
    var session: WCSession? = nil
    var plus = 0
    var minus = 0
    
    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var minusLabel: UILabel!
    
    //MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        if session == nil && WCSession.isSupported() {
            session = WCSession.defaultSession()
            session?.delegate = self
            session?.activateSession()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onUIThread(action execute: dispatch_block_t){
        dispatch_async(dispatch_get_main_queue(), execute)
    }
    
    // MARK: WCSessionDelegate
    func session(_session: WCSession, didReceiveUserInfo userInfo: [String: AnyObject]){
        debugPrint("Session data received", userInfo)
        if userInfo.keys.contains("PlusTapped") {
            plus++
            onUIThread { self.plusLabel.text = String(self.plus)}
        }
        if userInfo.keys.contains("MinusTapped") {
            minus++
            onUIThread { self.minusLabel.text = String(self.minus)}
        }
    }
}
