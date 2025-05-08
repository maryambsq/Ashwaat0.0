//
//  Summary.swift
//  Ashwaat0.0
//
//  Created by Ruba Meshal Alqahtani on 05/05/2025.
//

import SwiftUI

struct Summary: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("BGColor")
                        .ignoresSafeArea()

                    Image("Deco3")
                        .ignoresSafeArea()
                        .position(x: geometry.size.width - 100, y: 0)
                        .environment(\.layoutDirection, .leftToRight)
                    Image("Deco2")
                        .position(x: 40, y: geometry.size.height - 20)
                        .environment(\.layoutDirection, .leftToRight)
                    VStack(spacing: 20) {
                        Spacer()

                        ZStack {

                            Image("Summ")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300)
                                .offset(y: 40)

                            Text("May God accept your good deeds.")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(Color("AccentColor"))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                                .padding(.top, -120)
                                .alignmentGuide(.top) { d in d[.top] }
                                .padding(.horizontal, 60)

                            HStack {
                                Spacer() // Pushes content to the center

                                VStack(alignment: .leading, spacing: 15) {
                                    HStack(spacing: 10) {
                                        Image("TimerL")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        Text("you spent 40 min")
                                            .foregroundColor(Color("AccentColor"))
                                            .font(.body)
                                            .fontWeight(.bold)
                                    }

                                    HStack(spacing: 10) {
                                        Image("StaircaseL")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        Text("you took 4000 steps")
                                            .foregroundColor(Color("AccentColor"))
                                            .font(.body)
                                            .fontWeight(.bold)
                                    }

                                    HStack(spacing: 10) {
                                        Image("QuranL")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        Text("you completed Tawaf")
                                            .foregroundColor(Color("AccentColor"))
                                            .font(.body)
                                            .fontWeight(.bold)
                                    }
                                }
                                

                                Spacer() // Pushes from the other side
                            }

                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.environment(\.layoutDirection, .leftToRight) // Optional: to avoid RTL flipping

                            .offset(x: -20, y: 80)
                        }

                        Button(action: {

                        }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 130, height: 45)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 10)
                                .background(Color("ButtonTextColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .padding(.bottom, 10)

                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .navigationBarBackButtonHidden(true) 
        }
    }
}

#Preview {
    Summary()
}

