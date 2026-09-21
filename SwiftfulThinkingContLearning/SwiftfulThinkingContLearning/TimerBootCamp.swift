//
//  TimerBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 10/08/26.
//

import SwiftUI
import Combine

struct TimerBootCamp: View {
    //Current time
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    
/*
 Countdown
    @State var count: Int = 10
    @State var finishedString: String? = nil
 */
    
    // Countdown to date
    
    @State var timeRemaining = ""
    let futureDate:Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTiming() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let minutes = remaining.minute ?? 0
        let hours = remaining.hour ?? 0
        let seconds = remaining.second ?? 0
        timeRemaining = "\(hours):\(minutes):\(seconds)"
    }
    
    
    
    var dateFormatter:DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.pink, Color.blue]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { value in
           updateTiming()
        }
    }
}

#Preview {
    TimerBootCamp()
}
