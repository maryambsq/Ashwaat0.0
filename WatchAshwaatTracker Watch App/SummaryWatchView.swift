//
//  SummaryWatchView.swift
//  TawafTracker
//
//  Created by Aliah Alhameed on 09/11/1446 AH.
//

import SwiftUI

struct SummaryWatchView: View {
    var body: some View {
        VStack {
            // ✅ عنوان الصفحة مع زر الإغلاق
            HStack {
                Text("Summary")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("TC"))
                Spacer()
                Button(action: {
                    // أكشن إغلاق الصفحة
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("TC"))
                        .font(.title3)
                }.buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top, 20)

            // ✅ التمرير العمودي مع تكبير المستطيل عند التفاعل
            ScrollView {
                VStack(spacing: 16) {
                    ScalableCardView(text: "You spent 40 min", icon: "timer", color: Color("GREEN"))
                    ScalableCardView(text: "You spent 4K steps", icon: "figure.walk", color: Color("GREEN"))
                    ScalableCardView(text: "You completed tawaf", icon: "checkmark.seal", color: Color("GREEN"))
                }
                .padding(.horizontal, 10)
            }
        }
        .background(Color("BG"))
        .ignoresSafeArea()
    }
}

struct ScalableCardView: View {
    let text: String
    let icon: String
    let color: Color
    @State private var scale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let calculatedScale = max(1.0, 1.2 - (abs(minY) / 300))

            VStack {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(text)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.leading, 5)
                }
                .padding()
                .frame(width: 180, height: 60) // ✅ حجم المستطيل
                .background(color)
                .cornerRadius(12)
                .scaleEffect(calculatedScale) // ✅ تطبيق التكبير بناءً على السحب
                .animation(.spring(), value: scale) // ✅ حركة سلسة
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 80) // ✅ ارتفاع المستطيل
    }
}

#Preview {
    SummaryWatchView()
}
