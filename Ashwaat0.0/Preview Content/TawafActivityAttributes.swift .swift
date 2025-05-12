//
//  TawafActivityAttributes.swift
//  Ashwaat00.00
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 05/05/2025.
//

import ActivityKit
import Foundation

struct TawafActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var currentRound: Int // Current round (1 to 7)
        var elapsedSeconds: Int // Elapsed time in seconds
    }

    var totalRounds: Int // Total rounds (7 for Tawaf or Sa’i)
}

//  NOTES FOR TEAM:
//  -----------------------------------------------------------
//  Don’t rename this file unless you update it in the widget too.
//  Widget + App must share this file for the activity to run.
//  Add App Group + Background Modes to the widget extension.
//  Real devices ONLY! No simulator Live Activities.
//  Clean build (Shift+Cmd+K) if you change anything.
//  This is what connects to the LiveActivityController to show lock screen data.
