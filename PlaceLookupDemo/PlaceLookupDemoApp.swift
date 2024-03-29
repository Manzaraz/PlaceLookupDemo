//
//  PlaceLookupDemoApp.swift
//  PlaceLookupDemo
//
//  Created by Christian Manzaraz on 23/01/2024.
//

import SwiftUI

@main
struct PlaceLookupDemoApp: App {
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
        }
    }
}
