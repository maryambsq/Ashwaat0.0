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

    // للتحكم بالحركة
    @State private var progress: CGFloat = 0
    @State private var circleID = UUID()

    var body: some View {
        VStack(spacing: 40) {
            // العنوان والسهم
            Spacer()
           

            HStack {
                
                Spacer()
                Spacer()
               
                Button(action: {
                    // حالياً ما يسوي شيء
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.trailing)
                }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()

                Text("Sa’i")
                    .font(.system(size: 33, weight: .bold, design: .rounded))                    .foregroundColor(.greeno)
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

            // العداد الدائري
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

                Text("\(lapCount)")
                    .font(.system(size: 88, weight: .bold ,design: .rounded))
                    .foregroundColor(isTrackingPaused ? Color.stopgreeno : Color.greeno)
            }
            Spacer()

            // الزر أو التايمر
            if isTrackingPaused {
           
            Button("Resume") {
                    
                    resumeAfterPause() // هنا تحطون فنكشن الاستئناف

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
                    //هنا تحطون الفنكشن حق التراكنق
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
        .frame(maxWidth: .infinity, maxHeight: .infinity) // ← هذا اللي يخلي الخلفية تغطي كامل الشاشة
            .ignoresSafeArea()
      

       
        .onDisappear {
            timer?.invalidate()
        }
    }

    func startTimer() {//هذي الفنكشن حقت التست الي بتحطون التراكنق
        showStartButton = false
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeElapsed += 1

            if timeElapsed % 2 == 0 && lapCount < 7 {
                progress = 0
                circleID = UUID() // ✅ توليد معرف جديد = إعادة بناء الحلقة

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
                    }
                }
            }
        }
    }

    func resumeAfterPause() {//وهذي الفنكشن حقت لو طلع اليوز من الموقع
        isTrackingPaused = false
        startTimer()
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
