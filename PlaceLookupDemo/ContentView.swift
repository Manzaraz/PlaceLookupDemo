//
//  ContentView.swift
//  PlaceLookupDemo
//
//  Created by Christian Manzaraz on 23/01/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var showPlaceLookupStreet = false
    @State var returnedPlace = Place(mapItem: MKMapItem())
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Location:\n\(locationManager.location?.coordinate.latitude ?? 0.0), \(locationManager.location?.coordinate.longitude ?? 0.0)")
                    .padding(.bottom)
                
                Text("Returned Place: \nName: \(returnedPlace.name)\n\(returnedPlace.address)\nCoords: \(returnedPlace.latitude), \(returnedPlace.longitude)")
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showPlaceLookupStreet.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showPlaceLookupStreet) {
            PlaceLookupView(returnedPlace: $returnedPlace)
        }
    }
}

#Preview {
    ContentView() // Location doesn't show in Live Preview - use Simulator
        .environmentObject(LocationManager())
}
