//
//  SuperSimpleApp.swift
//  Super Simple RSS Mac
//
//  Created by Geof Crowl on 11/3/21.
//  Copyright © 2021 Geof Crowl. All rights reserved.
//

import SwiftUI

@main
struct SuperSimpleApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    AppData.refreshFeeds {
                        print("App: refreshFeeds")
                    }
                }
            
        }
        .windowToolbarStyle(.unified(showsTitle: false))
        .commands {
            CommandGroup(replacing: .newItem, addition: {
                Button("Add Feed") {
                    // TODO: Add Feed
                    print("TODO: Super Simple App - Add Feed")
                }
                .keyboardShortcut("n", modifiers: [.command])
            })
            SidebarCommands()
//            CommandMenu("Feed") {
//                Button("Add Feed") {
//                    print("TODO: Super Simple App - Add Feed")
//                }
//                .keyboardShortcut("n", modifiers: .command)
//            }
        }
        
        WindowGroup("New Feed") {
            Text("New feed")
                .frame(width: 250, height: 250)
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: Window.newFeedWindow.rawValue))
        
        Settings {

            TabView {
                Text("General")
                    .font(.largeTitle)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("General")
                    }
                
                Text("Appearance")
                    .font(.largeTitle)
                    .tabItem {
                        Image(systemName: "paintpalette")
                        Text("Appearance")
                    }
            }
            .frame(minWidth: 300, minHeight: 250)
        }
    }
}

// Windows defined here
enum Window: String, CaseIterable {
    case mainWindow = "MainWindow"
    case newFeedWindow = "NewFeedWindow"
    
    func open(){
        if let url = URL(string: "SuperSimpleRSS://\(self.rawValue)") {
            print("opening \(self.rawValue)")
            NSWorkspace.shared.open(url)
        }
    }
}
