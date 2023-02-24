//
//  LocationView.swift
//  MyTeslaApp
//
//  Created by lucas urbain on 24.02.23.
//

import SwiftUI
import MapKit

struct CarLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let carLocation = [CarLocation(latitude: 46.5777555, longitude: 7.0624775)]

struct LocationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.5777555, longitude: 7.0624775), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $location, annotationItems: carLocation, annotationContent: { location in
                MapAnnotation(coordinate: location.coordinate, content: {
                    CarPin()}
                )
            })
        
            CarLocationPanel()
            
            LinearGradient(gradient: Gradient(colors: [Color("DarkGray"), Color.clear,Color.clear]), startPoint: .top, endPoint: .bottom)
                .allowsHitTesting(false)
        
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        GeneralButton(icon: "chevron.left")
                    }
                    Spacer()
                    Button(action: {}) {
                        GeneralButton(icon: "speaker.wave.3.fill")
                    }
                }
                .padding()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkGray"))
        .foregroundColor(Color.white)
        .navigationBarHidden(true)
    }
}

struct CarPin: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: "car.fill")
                .frame(width: 36, height: 36, alignment: .center)
                .background(Color("Red"))
                .foregroundColor(Color.white)
                .clipShape(Circle())
            Text("Plaid")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 8) .stroke(Color.black.opacity(0.1), lineWidth: 0.1))
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}

struct CarLocationPanel: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Location")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    CustomDivider()
                    Label("Rue du Château 8, 1663 Gruyères, Suisse", systemImage: "location.fill")
                        .opacity(0.5)
                        .font(.footnote)
                }
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Summon")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Press and hold controls to move vehicle")
                            .opacity(0.5)
                            .font(.footnote)
                    }
                    CustomDivider()
                    fullButton(text: "Go to target")
                    HStack {
                        fullButton(text: "Forward", icon: "arrow.up")
                        fullButton(text: "Backward", icon: "arrow.down")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("DarkGray"))
            .foregroundColor(Color.white)
        }
    }
}
