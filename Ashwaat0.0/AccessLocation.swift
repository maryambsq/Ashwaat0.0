//
//  AccessLocation.swift
//  Ashwaat0.0
//
//  Created by Maryam Amer Bin Siddique on 01/11/1446 AH.
//

import SwiftUI
import CoreLocation
import SwiftUI

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

    var body: some View {
        ZStack {
            Color("BGColor").ignoresSafeArea()
            
            VStack {
                Image("location")
                    .resizable()
                    .frame(width: 300, height: 180)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom, 50)
                    .padding(.leading, 30)
                
                Text("Allow Location Access")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.bottom)
                
                Text("To accurately track your Tawaf and Sa'i, please allow location access while using the app.")
                    .font(.subheadline)
                    .foregroundColor(Color("SecondaryColor"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 100)
                
                Button(action: {
                    handleLocationAuthorization()
                }) {
                    Text("Allow Location Access")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(Color("SecondaryColor"))
                        .cornerRadius(20)
                }
            }
            .padding()
            .onAppear {
                handleLocationAuthorization()
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
            // Open app settings
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
