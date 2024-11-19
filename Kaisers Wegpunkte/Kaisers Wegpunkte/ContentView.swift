//
//  ContentView.swift
//  Kaisers Wegpunkte
//
//  Created by sahi on 30.11.21.
//

import SwiftUI
import MapKit
import AVKit
import AVFoundation

struct ContentView: View {
    
    @StateObject var locationEnvironment = LocationEnvironment()
    
    var body: some View {
        VStack {
            Text("Meine Erledigungen")
                .font(.title).bold()
            
            MapView(locationEnvironment: locationEnvironment)
            
            let numberOfPlaces = locationEnvironment.places.count
            ForEach(0..<numberOfPlaces, id: \.self) {
                PlacesView(places: locationEnvironment.places[$0])
            }
            .padding(.horizontal, 10)
        }
    }
}

struct MapView: View {
    
    @StateObject var locationEnvironment: LocationEnvironment
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.543288, longitude: 13.350646), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: locationEnvironment.places) {
            place in
            MapAnnotation(coordinate: place.location, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                Circle()
                    .strokeBorder(Color.red, lineWidth: 10)
                    .frame(width: 44, height: 44)
            }
        }
            .frame(width: 400, height: 300)
            .onAppear() {
                locationEnvironment.initPositionService()
            }
    }
}

struct PlacesView: View, PlacesDelegate {
    
    @StateObject var places: Places
    @State var color: Color = .red
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Button(action: {
                (places.status != .green && places.status == .yellow) ? places.setStatus(.green) : places.setStatus(.red)
            }, label: {
                Text(places.headline + ": \n" + places.reminder)
            })
                .buttonStyle(.borderedProminent)
                .tint(color)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(places.headline), message: Text(places.reminder)
                    )
                }
        }
        .onAppear() {
            places.addDelegate(self)
        }
    }
    
    func changeStatus(to status: Status) {
        
        switch(status) {
        case .red:
            color = .red
        case .yellow:
            color = .yellow
            showAlert = true
            SoundManager.instance.playSound()
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                showAlert = false
            }
        case .green:
            color = .green
        }
    }
}

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound () {
        guard let url = Bundle.main.url(forResource: "sound", withExtension: ".mp3") else {return}
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
