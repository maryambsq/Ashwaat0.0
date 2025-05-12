//
//  TawafWidgetLiveActivity.swift
//  TawafWidgetLiveActivity
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 05/05/2025.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct TawafWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TawafActivityAttributes.self) { context in
            LiveActivityView(context: context) // Lock screen UI
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded region
                DynamicIslandExpandedRegion(.leading) {
                    Text("Round \(context.state.currentRound)")
                        .foregroundColor(Color(hex: "#305952"))
                        .font(.system(size: 16, weight: .medium))
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("\(context.state.elapsedSeconds / 60):\(String(format: "%02d", context.state.elapsedSeconds % 60))")
                        .foregroundColor(Color(hex: "#305952"))
                        .font(.system(size: 16, weight: .medium))
                }
            } compactLeading: {
                Image("quran_logo")
                    .resizable()
                    .frame(width: 24, height: 24)
            } compactTrailing: {
                Text("\(context.state.elapsedSeconds / 60):\(String(format: "%02d", context.state.elapsedSeconds % 60))")
                    .foregroundColor(Color(hex: "#305952"))
                    .font(.system(size: 16, weight: .medium))
            } minimal: {
                Image("quran_logo")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .keylineTint(Color(hex: "#305952"))
        }
    }
}

// MARK: - Main Live Activity View
struct LiveActivityView: View {
    let context: ActivityViewContext<TawafActivityAttributes>

    var body: some View {
        ZStack {
            // Background color #F1EFE9
            Color(hex: "#F1EFE9")
                .ignoresSafeArea()

            // Main content (progress ring and timer label)
            HStack {
                // Circular progress ring for rounds
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10) // Increased lineWidth for bolder look
                        .frame(width: 50, height: 50) // Reduced size to 50x50

                    // Progress ring with color #305952
                    Circle()
                        .trim(from: 0, to: CGFloat(context.state.currentRound) / CGFloat(context.attributes.totalRounds))
                        .stroke(Color(hex: "#305952"), lineWidth: 10) // Increased lineWidth for bolder look
                        .frame(width: 50, height: 50) // Reduced size to 50x50
                        .rotationEffect(.degrees(-90))

                    // Current round text
                    Text("\(context.state.currentRound)")
                        .font(.system(size: 22, weight: .bold)) // Bold and larger to match image
                        .foregroundColor(Color(hex: "#305952")) // Match specified color
                }
                .padding(.leading, 20)

                // Timer label and elapsed time
                VStack(alignment: .leading) {
                    Text("Timer")
                        .font(.system(size: 14, weight: .medium)) // Smaller size, medium weight
                        .foregroundColor(Color(hex: "#305952")) // Match specified color
                    Text("\(context.state.elapsedSeconds / 60):\(String(format: "%02d", context.state.elapsedSeconds % 60))")
                        .font(.system(size: 18, weight: .medium)) // Larger size, medium weight
                        .foregroundColor(Color(hex: "#305952")) // Match specified color
                }

                Spacer()
            }

            // Logo in the top right corner
            VStack {
                HStack {
                    Spacer()
                    Image("quran_logo") // Ensure this image is in Assets.xcassets
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 10)
                        .padding(.top, 5)
                }
                Spacer()
            }
        }
    }
}

// Extension to handle hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

//  This is the Live Activity UI layout y’all — it's the Lock Screen version
//  Circle shows the current round, timer shows elapsed time, logo now in top right corner
//  Swap out "quran_logo" with our actual asset name in Assets.xcassets
//  If you wanna change colors or sizes, just tweak the values here
//  Any layout edits → do them inside the ActivityConfiguration closure ONLY

//  For anyone tweaking or adding widgets:
// Don't put ActivityConfiguration inside @main WidgetBundle 😭
// Keep the actual widget in its own struct → TawafWidgetLiveActivity
// Then wrap it in TawafWidgetLiveActivityBundle with @main tag
//
// If y'all ever get that "underlying type" error again
// it means Xcode's confused where the real widget config lives.
//
// You can add more widgets inside the bundle later if needed.
