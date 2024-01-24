//
//  PlaceLookupView.swift
//  PlaceLookupDemo
//
//  Created by Christian Manzaraz on 23/01/2024.
//

import SwiftUI
import MapKit

struct PlaceLookupView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var placeVM = PlaceViewModel() // we can init as a @StateObject here if this is the first or only place we'll use this View Model
    
    @State private var searchText = ""
    @Binding var returnedPlace: Place
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(placeVM.places) { place in
                VStack (alignment: .leading) {
                    Text(place.name)
                        .font(.title2)
                    Text(place.address)
                        .font(.callout)
                }
                .onTapGesture {
                    returnedPlace = place
                    dismiss()
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .onChange(of: searchText, { _, text in
                if !text.isEmpty {
                    placeVM.search(text: text, region: locationManager.region)
                } else {
                    placeVM.places = []
                }
                
            })
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    PlaceLookupView(returnedPlace: .constant(Place(mapItem: MKMapItem())))
        .environmentObject(LocationManager())
}
