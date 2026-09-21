//
//  LocationViewModel.swift
//  SwiftfulMapApp
//
//  Created by Akanksha on 18/06/26.
//

import SwiftUI
import Combine
import MapKit

class LocationViewModel: ObservableObject {
    
    // Make locations non-optional and initialized
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            upDateRegion(location: mapLocation)
        }
    }
    @Published var mapRegion = MKCoordinateRegion()
    
    //show list of locations
    @Published var showLocationList:Bool = false
    
    // show sheet
    @Published var sheetLocation: Location? = nil
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Provide a default initializer so callers don't need to pass locations
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.upDateRegion(location: locations.first!)
    }
    
    private func upDateRegion(location: Location) {
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
    
    func toggleLoactionList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    func showNextLocation(location:Location){
        withAnimation(.easeInOut) {
            self.mapLocation = location
            showLocationList = false
        }
    }
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            return
        }
        let nextIndex = locations.index(after: currentIndex)
        if nextIndex < locations.endIndex {
            showNextLocation(location: locations[nextIndex])
        } else if let first = locations.first {
            showNextLocation(location: first)
        }
    }
}

