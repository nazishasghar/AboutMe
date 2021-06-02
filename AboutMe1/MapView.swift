//
//  MapView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 12/05/21.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @State var search:String? = ""
    var body: some View{
        ZStack{
        
        MapView()
               
        }
    }
}
struct MapView: UIViewRepresentable {
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
    
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MainMapView()
    }
}
