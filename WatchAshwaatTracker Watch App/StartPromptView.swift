//
//  StartPromptView.swift
//  TawafTracker
//
//  Created by Aliah Alhameed on 03/11/1446 AH.
//
import SwiftUI

struct StartPromptView: View {
    @State private var showNext = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Do you want us to\nstart counting your laps ?")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                Button(action: {
                    // Dismiss
                }) {
                    Text("Dismiss")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("NEXT")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showNext) {
                // وجهة الانتقال التالية
                Text("Next screen")
            }
        }
    }
}
#Preview {
    StartPromptView()
}

