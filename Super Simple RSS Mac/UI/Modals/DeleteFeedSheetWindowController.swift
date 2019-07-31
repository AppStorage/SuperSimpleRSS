//
//  DeleteFeedSheet.swift
//  Super Simple RSS Mac
//
//  Created by Geof Crowl on 7/30/19.
//  Copyright © 2019 Geof Crowl. All rights reserved.
//

import Cocoa

class DeleteFeedSheetWindowController: NSWindowController {
    
    @IBOutlet var windowTextField: NSTextField!
    
    var hostWindow: NSWindow?
    var feed: Feed!
    
    convenience init(feed _feed: Feed) {
        
        self.init(windowNibName: NSNib.Name("DeleteFeedSheet"))
        
        feed = _feed
    }

    func runSheetOnWindow(_ _hostWindow: NSWindow) {
        
        hostWindow = _hostWindow
        
        hostWindow!.beginSheet(window!) { [unowned self] (returnCode: NSApplication.ModalResponse) in
            
            if returnCode == NSApplication.ModalResponse.OK {
                self.delete()
            }
        }
        
        if let windowTextField = windowTextField {
            
            // This updates after the modal is shown.
            // I would like to improve this.
            // Setting this earlier in the window cycle causes an error.
            
            let feedName = feed.name ?? feed.url?.absoluteString ?? "unnamed feed"
            windowTextField.stringValue = "Are you sure you want to delete \(feedName)?"
        }
    }
    
    func delete() {
        
        guard let feed = feed else { return }
        
        AppData.deleteFeed(feed)
        appDelegate?.refreshFeeds()
    }
    
    @IBAction func cancel(_ sender: Any) {
        hostWindow!.endSheet(window!, returnCode: NSApplication.ModalResponse.cancel)
    }
    
    @IBAction func deleteFeed(_ sender: Any) {
        hostWindow!.endSheet(window!, returnCode: NSApplication.ModalResponse.OK)
    }

}