//
//  CountdownViewModel.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/27/25.
//

import Foundation

class CountdownViewModel: ObservableObject {
    @Published var countdown: Int = 3
    
    var onTimerFinished: () -> Void = {}
    
    private var timer: Timer?
    
    func startCountdownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                self.stopTimer()
                self.onTimerFinished()
            }
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
