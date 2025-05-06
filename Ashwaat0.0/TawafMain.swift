//
//  TawafMain.swift
//  Ashwaat0.0
//
//  Created by Ruba Meshal Alqahtani on 05/05/2025.
//

import SwiftUI

struct TawafMain: View {
    var body: some View {
        NavigationStack { // Use NavigationStack instead of NavigationView
            GeometryReader { geometry in
                ZStack {
                    
                    Color("BGColor")
                        .ignoresSafeArea()

                    Image("Deco")
                        .ignoresSafeArea()
                        .position(x: geometry.size.width - 40, y: 0)

                    Image("Deco2")
                        .position(x: 40, y: geometry.size.height - 20)

                    VStack(spacing: 20) {
                       
                        Text("Tawaf")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("AccentColor"))

                        Spacer()

                        ZStack {
                            
                            Image("TawafBox1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                                .offset(y: -30)

                            
                            VStack(spacing: 5) {
                                Text("Let’s begin")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                Text("counting your")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                Text("Ashwaat!")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .offset(y: -8)
                        }
                        .overlay(
                            NavigationLink(destination: tawaf()) {
                                Text("Get Started")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 130, height: 45)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 10)
                                    .background(Color("ButtonTextColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            .padding(.bottom, 2),
                            alignment: .bottom
                        )

                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .navigationBarBackButtonHidden(true) // Hide back button for this view
        }
    }
}

#Preview {
    TawafMain()
}


