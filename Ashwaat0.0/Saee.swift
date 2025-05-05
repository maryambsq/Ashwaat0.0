//
//  Saee.swift
//  Ashwaat0.0
//
//  Created by Razan on 01/05/2025.
//
import SwiftUI

struct Saee: View {
    @State private var lapCount = 0
    @State private var timeElapsed: Int = 0
    @State private var timer: Timer?
    @State private var isTrackingPaused = false
    @State private var showStartButton = true

    @State private var progress: CGFloat = 0
    @State private var circleID = UUID()
    
    @State private var navigateToNext = false // ✅ التنقل للنهاية
    @State private var backToHome = false     // ✅ الرجوع للصفحة الرئيسية

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                HStack {
                    Spacer()
                    Spacer()
                    
                    // ✅ NavigationLink مخفي للرجوع إلى Home
                    NavigationLink(destination: HomeView1(), isActive: $backToHome) {
                        EmptyView()
                    }

                    // ✅ زر السهم يرجع للصفحة الرئيسية
                    Button(action: {
                        backToHome = true
                    }) {
                        Image(systemName: Locale.characterDirection(forLanguage: Locale.current.language.languageCode?.identifier ?? "") == .rightToLeft ? "chevron.right" : "chevron.left")
                            .font(.system(size: 40, weight: .medium))
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.trailing)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Text("Sa’i")
                        .font(.system(size: 33, weight: .bold, design: .rounded))
                        .foregroundColor(.greeno)
                        .padding(.trailing, 10)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }

                Spacer()

                // ✅ NavigationLink للانتقال التلقائي بعد آخر شوط
                NavigationLink(destination: FinishPage1(), isActive: $navigateToNext) {
                    EmptyView()
                }

                ZStack {
                    Circle()
                        .stroke(Color.circlecolor, lineWidth: 40)
                        .frame(width: 300, height: 300)

                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(isTrackingPaused ? Color.stopgreeno : Color.greeno, style: StrokeStyle(lineWidth: 40, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 300, height: 300)
                        .id(circleID)
                        .animation(.easeInOut(duration: 1.0), value: progress)

                    Text(formattedEnglishNumber(lapCount))
                        .font(.system(size: 88, weight: .bold ,design: .rounded))
                        .foregroundColor(isTrackingPaused ? Color.stopgreeno : Color.greeno)
                }
                .environment(\.layoutDirection, .leftToRight)

                Spacer()

                if isTrackingPaused {
                    Button("Resume") {
                        resumeAfterPause()
                    }
                    .font(.title.bold())
                    .foregroundColor(.buttonText)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 10)
                    .background(Color.greeno)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } else if showStartButton {
                    Button("Start") {
                        startTimer()
                    }
                    .font(.title.bold())
                    .foregroundColor(.buttonText)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 10)
                    .background(Color.greeno)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } else {
                    Text(formattedTime)
                        .font(.title.bold())
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Color.circlecolor)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .foregroundColor(Color.lightgreeno)
                }

                Spacer()
                Spacer()
            }
            .background(Color.BG)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            .onDisappear {
                timer?.invalidate()
            }
           
        }
    }

    func startTimer() {
        showStartButton = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeElapsed += 1

            if timeElapsed % 2 == 0 && lapCount < 7 {
                progress = 0
                circleID = UUID()

                withAnimation(.easeInOut(duration: 1.0)) {
                    progress = 1
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    lapCount += 1

                    if lapCount == 6 {
                        isTrackingPaused = true
                        timer?.invalidate()
                    }

                    if lapCount == 7 {
                        timer?.invalidate()
                        navigateToNext = true // ✅ الانتقال التلقائي
                    }
                }
            }
        }
    }

    func resumeAfterPause() {
        isTrackingPaused = false
        startTimer()
    }

    func formattedEnglishNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }

    var formattedTime: String {
        let minutes = timeElapsed / 60
        let seconds = timeElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    Saee()
}

// ✅ صفحة النهاية المؤقتة (تقدرين تغيرينها لاحقًا)
struct FinishPage1: View {
    var body: some View {
        Text("انتهيت من السعي 🎉")
            .font(.largeTitle.bold())
            .foregroundColor(.green)
            .navigationBarBackButtonHidden(true)
    }
}

// ✅ الصفحة الرئيسية التجريبية
struct HomeView1: View {
    var body: some View {
    
            Text("الصفحة الرئيسية")
                .font(.largeTitle.bold())
                .foregroundColor(.blue)
                .navigationBarBackButtonHidden(true)
                 
    }
}
