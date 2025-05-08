//
//  TawafStartView.swift
//  TawafTracker
//
//  Created by Aliah Alhameed on 06/11/1446 AH.
//

import SwiftUI

struct TawafStartView: View {
    var body: some View {
        ZStack {
            Color("BG")
                .ignoresSafeArea()
//            // الخلفية البيج مع الزخرفة
//            Image("background") // صورة الخلفية من Assets
//                .resizable()
//                .scaledToFit()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .frame(height: 250) // تحكم بحجم الخلفية
//                .opacity(0.95)
//                .offset(y: -20) // عشان تركز الخلفية فوق أكثر
            
//           // 2. الزخارف
//            VStack {
//                HStack {
//                    Spacer()
//                    Image("Decoration")
//                        .resizable()
//                        .ignoresSafeArea()
//                        .frame(width: 40, height: 40)
//                        .padding(.horizontal,-15)
//                        
//                }
//                Spacer()
//                HStack {
//                    Image("Decoration") // الزخرفة السفلية
//                        .resizable()
//                        .frame(width: 35, height: 33)
//                    Spacer()
//                }
//            }
//            .padding()
            
                
            VStack(spacing: 14) {
                
                Text("Tawaf")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("TC")) // أو .black
                                    .padding(.top, -10)

                // الصورة الخضراء مع الآية
                ZStack {
                    Image("greenBox") // الصورة الخضراء (فيها الآية والزخرفة)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .frame(height: 125)
                        .padding(.top, -30)
                    
                    // النص داخل الصورة
                    Text("Let’s begin counting your Ashwaat!")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(height: 150)

                // زر البدء
                Button(action: {
                    // تنفيذ عند الضغط
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Getstart"))
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 25)
                .padding(.top, -30) // ← وهنا رفعنا الزر لفوق شوي
                
            }
            .padding()
        }
    }
}

#Preview {
    TawafStartView()
}
