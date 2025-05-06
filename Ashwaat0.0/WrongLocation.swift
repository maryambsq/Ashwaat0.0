//
//  WrongLocation.swift
//  Ashwaat0.0
//
//  Created by Ruba Meshal Alqahtani on 05/05/2025.
//

import SwiftUI

struct WrongLocation: View {
    var body: some View {
     
            GeometryReader { geometry in
                ZStack {
                    
                    Color("BGColor")
                        .ignoresSafeArea()

                    Image("Deco")
                        .ignoresSafeArea()
                        .position(x: geometry.size.width - 40, y: 0)
                        .environment(\.layoutDirection, .leftToRight)

                    Image("Deco2")
                        .position(x: 40, y: geometry.size.height - 20)
                        .environment(\.layoutDirection, .leftToRight)

                    VStack(spacing: 20) {
                       
                       

                        Spacer()

                        ZStack {
                            
                            Image("TawafBox1")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                                .offset(y: -30)

                            
                            VStack(spacing: 5) {
                                Text("Laps tracked")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                Text("Focus intact")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)

                                Text("Make sure you are in the intended location for performing the ritual to initiate tracking.")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 50)
                                                                .offset(y: 20)
                            }
                            .offset(y: -8)
                        }
                        .overlay(
                                                            Text("Get Started")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(width: 130, height: 45)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 10)
                                    .background(Color("DisabledButton"))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            .padding(.bottom, 2),
                            alignment: .bottom
                        )

                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                }
            }
           
        }
    }


#Preview {
    WrongLocation()
}
