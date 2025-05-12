//
//  LiveActivityController.swift
//  Ashwaat00.00
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 05/05/2025.
//

import ActivityKit
import Foundation

class LiveActivityController {
    static let shared = LiveActivityController()
    private var activity: Activity<TawafActivityAttributes>? = nil
    private var timerTask: Task<Void, Never>?

    func startLiveActivity(totalRounds: Int) {
        let attributes = TawafActivityAttributes(totalRounds: totalRounds)
        let initialState = TawafActivityAttributes.ContentState(currentRound: 1, elapsedSeconds: 0)

        do {
            activity = try Activity<TawafActivityAttributes>.request(
                attributes: attributes,
                contentState: initialState,
                pushType: nil
            )
            print("✅ Live Activity started!")
            // Start elapsed time update
            startTimer()
        } catch {
            print("❌ Failed to start Live Activity: \(error.localizedDescription)")
        }
    }

    private func startTimer() {
        timerTask?.cancel() // Cancel any existing timer
        timerTask = Task {
            var elapsedSeconds = 0
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                elapsedSeconds += 1
                let currentRound = await activity?.content.state.currentRound ?? 1
                let updatedState = TawafActivityAttributes.ContentState(currentRound: currentRound, elapsedSeconds: elapsedSeconds)
                await activity?.update(using: updatedState)
            }
        }
    }

    func updateLiveActivity(currentRound: Int) {
        Task {
            let elapsedSeconds = await activity?.content.state.elapsedSeconds ?? 0
            let updatedState = TawafActivityAttributes.ContentState(currentRound: currentRound, elapsedSeconds: elapsedSeconds)
            await activity?.update(using: updatedState)
            // End the activity if all rounds are complete
            if currentRound >= 7 {
                await activity?.end(dismissalPolicy: .immediate)
                timerTask?.cancel()
            }
        }
    }

    func stopLiveActivity() {
        Task {
            await activity?.end(dismissalPolicy: .immediate)
            timerTask?.cancel()
            print("🛑 Live Activity ended.")
        }
    }
}
// Live Activity not starting? Tell your widget it's an Activity Widget!
//  Double check:
// - TawafWidgetLiveActivity.swift uses ActivityConfiguration
// - Deployment = 16.1+
// - Both targets share TawafActivityAttributes.swift
// - Run MAIN app target only (not widget)
// - Clean & rebuild everything if you changed configs

//if u see a “.entitlements file not found” error
//just go to the LiveActivityExtension, add a new entitlements file named exactly TawafWidgetLiveActivityExtension.entitlements
//then in Build Settings > CODE_SIGN_ENTITLEMENTS, link it
//clean build and it should be all good 💅💥
