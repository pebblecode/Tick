//
//  InterfaceController.swift
//  Tick WatchKit Extension
//
//  Created by Martin Schinz on 28/10/2015.
//  Copyright © 2015 pebble{code}. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // MARK: WKInterfaceController
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func inSession(action: (WCSession -> Any)){
        if WCSession.isSupported(){
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            action(session)
        }
    }
    
    // MARK: Actions
    @IBAction func plusButtonTapped() {
        let userInfo = ["PlusTapped" : "Once"]
        inSession { (session: WCSession) in session.transferUserInfo(userInfo)}
    }
    @IBAction func minusButtonTapped() {
    }

}
