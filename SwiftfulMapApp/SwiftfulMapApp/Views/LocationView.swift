//
//  LocationView.swift
//  SwiftfulMapApp
//
//  Created by Akanksha on 16/06/26.
//

import SwiftUI
import Combine
import MapKit


struct LocationView: View {
    
    @EnvironmentObject private var vm: LocationViewModel

    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            VStack {
                headerView
                Spacer()
                ZStack {
                    ForEach(vm.locations){
                        location in
                        if location == vm.mapLocation {
                            LocationPreviewView(location: location)
                                .shadow(color:Color.black.opacity(0.3),radius: 20)
                                .padding(.horizontal)
                                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                        }
                        
                    }
                }
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) {
            location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}

extension LocationView {
    private var headerView:some View {
        VStack(spacing: 0) {
            
            Button(action: vm.toggleLoactionList){
                Text(vm.mapLocation.name + " " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                    }
            }

            if vm.showLocationList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(20)
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates ){
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1.2 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
}
