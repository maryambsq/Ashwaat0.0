//
//  SaeeWatchView.swift
//  Ashwaat0.0
//
//  Created by Aliah Alhameed on 09/11/1446 AH.

//
import SwiftUI
struct SaeeWatchView: View {
    @State private var lapCount = 0
    @State private var timeElapsed: Int = 0
    @State private var timer: Timer?
    @State private var isTrackingPaused = false
    @State private var showStartButton = true

    // للتحكم بالحركة
    @State private var progress: CGFloat = 0
    @State private var circleID = UUID()

    var body: some View {
        VStack(spacing: 10) {
            // العنوان والسهم
            Spacer()
           

            HStack {
                
//                Spacer()
//                Spacer()
               
                Button(action: {
                    // حالياً ما يسوي شيء
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.leading, 15)
                    
                }.buttonStyle(PlainButtonStyle())
                
               Spacer()
//                Spacer()
//                Spacer()
//                Spacer()

                Text("Sa'i")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))                    .foregroundColor(.TC)
                    .padding(.trailing, 66)
              
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()

            }.padding(.horizontal, 8) // ✅ قلل الهوامش العامة
                .padding(.top, 4) // ✅ خفف المسافة من الأعلى
                .padding(.bottom, 10)
            //Spacer()

            // العداد الدائري
            ZStack {
              
                Circle()
                    .stroke(Color.GREEN, lineWidth: 12)
                    .frame(width: 100, height: 100)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(isTrackingPaused ? Color.stopgreeno : Color.circlecolor, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 100, height: 100)
                    .id(circleID)
                    .animation(.easeInOut(duration: 1.0), value: progress)

                Text("\(lapCount)")
                    .font(.system(size: 32, weight: .bold ,design: .rounded))
                    .foregroundColor(isTrackingPaused ? Color.stopgreeno : Color.circlecolor)
            }
            Spacer()

            // الزر أو التايمر
            if isTrackingPaused {
           
            Button("Resume") {
                    
                    resumeAfterPause() // هنا تحطون فنكشن الاستئناف

                }
            .font(.system(size: 14, weight: .semibold)) // ← حجم النص
            .frame(width: 70, height: 30) // ← حجم الزر الكامل
            //.frame(maxWidth: .infinity)
            //.frame(height: 34) // ✅ تحديد ارتفاع الزر الصريح
            .padding(6)
            .background(Color.GREEN)
            .foregroundColor(.buttonText)
            .cornerRadius(20)
            .padding(.horizontal, 4) // ✅ زبط البادينق
            .padding(.bottom, 6) // ✅ ارفعه شوي لفوق
            .buttonStyle(PlainButtonStyle()) // ✅ إزالة أي ستايل افتراضي (يمنع ظهور الظل الأبيض)
            } else if showStartButton {
                Button("Start") {
                    
                    startTimer()
                    //هنا تحطون الفنكشن حق التراكنق
                }
                .font(.system(size: 14, weight: .semibold)) // ← حجم النص
                //.frame(width: 70, height: 30)
                //.frame(maxWidth: .infinity)
                .frame(width: 70, height: 30) // ✅ تحديد ارتفاع الزر الصريح
                .padding(6)
                .background(Color.TC)
                .foregroundColor(.buttonTextGreen)
                .cornerRadius(20)
                .padding(.horizontal, 4) // ✅ زبط البادينق
                .padding(.bottom, 6) // ✅ ارفعه شوي لفوق
                .buttonStyle(PlainButtonStyle())
            } else {
                Text(formattedTime)
                    .font(.system(size: 14, weight: .semibold))
                    //.font(.caption)
                    .padding(6)
                    //.frame(maxWidth: .infinity)
                    .frame(width: 70, height: 30)
//                    .padding(.horizontal, 40)
//                    .padding(.vertical, 10)
                    .background(Color.circlecolor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(Color.lightgreeno)
            }
//            Spacer()
//            Spacer()

        }
        .padding()
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
    SaeeWatchView()
}
