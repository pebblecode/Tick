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


class InterfaceController: WKInterfaceController, WCSessionDelegate, CLLocationManagerDelegate {
    // MARK: Properties
    
    var locationManager: CLLocationManager? = nil
    
    // MARK: WKInterfaceController
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestLocation()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }
    
    func locationManager(_manager: CLLocationManager, didFailWithError error: NSError) { }
    
    
    // MARK: Custom behaviour
    func inSession(action: (WCSession -> Any)){
        if WCSession.isSupported(){
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
            action(session)
        }
    }
    
    func getEvent(eventType: String) -> [String:AnyObject]{
        let timestamp = NSDate()
        let loc = (locationManager?.location)!.copy()
        let data = NSKeyedArchiver.archivedDataWithRootObject(loc)
        let userData = ["Timestamp": timestamp, "Type": eventType, "Loc": data]
        return userData
    }
    
    // MARK: Actions
    @IBAction func plusButtonTapped() {
        let event = getEvent("PlusTapped")
        inSession {
            let transfer = $0.transferUserInfo(event)
            debugPrint(transfer)
            return transfer
        }
    }

    @IBAction func minusButtonTapped() {
        let event = getEvent("MinusTapped")
        inSession { $0.transferUserInfo(event) }
    }

}
