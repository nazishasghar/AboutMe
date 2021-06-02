//
//  MapViewTesting.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 20/05/21.
//

import SwiftUI
import MapKit
struct City : Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MapViewTesting: View {
    @State var Request : [City] = []
    @State private var search : String = ""
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var coordinateRegion : MKCoordinateRegion = MKCoordinateRegion()
  
    var body: some View {
        ZStack(alignment: .top){

            Map(coordinateRegion: $coordinateRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: Request,annotationContent:{ place in
                MapPin(coordinate: CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude))
            })
            .animation(.easeInOut)
            .ignoresSafeArea(.all)
            TextField("Search For Places", text: $search, onEditingChanged: {_ in
                
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = search
                searchRequest.region = coordinateRegion

                let search = MKLocalSearch(request: searchRequest)
                search.start { (response, error) in
                    guard let response = response else {
                      return  print(error?.localizedDescription as Any)
                    }
                    
                    for item in response.mapItems {
                        if let name = item.name,
                            let location = item.placemark.location {
                            let pin = City(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                            $coordinateRegion.wrappedValue.center = pin.coordinate
                            Request.append(pin)
                            print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                        }
                    }
                    
                }
                
            }, onCommit: {
                Request.removeAll()
            }).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
        }
    }
    
}















struct MapViewTesting_Previews: PreviewProvider {
    static var previews: some View {
        MapViewTesting()
    }
}
