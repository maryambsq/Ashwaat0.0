//
//  AccessLocation.swift
//  Ashwaat0.0
//
//  Created by Ruba Meshal Alqahtani on 07/05/2025.
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorization()
    }
    
    func checkAuthorization() {
        authorizationStatus = manager.authorizationStatus
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
}

struct AccessLocation: View {
    @StateObject private var locationManager = LocationManager()
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BGColor").ignoresSafeArea()
                
                VStack {
                    Image("Location")
                        .resizable()
                        .frame(width: 300, height: 180)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.bottom, 50)
                        .padding(.leading, 10)
                    
                    Text("Allow Location Access")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.bottom)
                        .fontDesign(.rounded)
                    
                    Text("To accurately track your Tawaf and Sa'i, please allow location access while using the app.")
                        .font(.subheadline)
                        .foregroundColor(Color("ButtonTextColor"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 100)
                        .fontDesign(.rounded)
                    
                    Button(action: {
                        handleLocationAuthorization()
                    }) {
                        Text("Allow Access")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 290, height: 60)
                            .background(Color("ButtonTextColor"))
                            .cornerRadius(20)
                            .fontDesign(.rounded)
                    }
                }
                .padding(20)
            }
            .onChange(of: locationManager.authorizationStatus) { newStatus in
                if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                    shouldNavigate = true
                }
            }
            .navigationDestination(isPresented: $shouldNavigate) {
                WrongLocation()
            }
        }
    }
    
    private func handleLocationAuthorization() {
        guard let status = locationManager.authorizationStatus else {
            locationManager.requestPermission()
            return
        }
        
        switch status {
        case .notDetermined:
            locationManager.requestPermission()
        case .denied, .restricted:
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        default:
            break
        }
    }
}

#Preview {
    AccessLocation()
}

