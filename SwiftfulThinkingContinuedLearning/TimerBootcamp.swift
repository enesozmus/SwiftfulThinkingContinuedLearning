//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 24.05.2024.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    // 🔵 Current time example
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter;
    }
    // 🔵 Countdown example
    @State var count: Int = 10
    @State var finishText: String? = nil
    // 🔵 Countdown to date
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    func updateTimeRemaining() {
        //        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
        //let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        //timeRemaining = "\(hour):\(minute):\(second)"
        timeRemaining = "\(minute) minutes, \(second) seconds"
    }
    // Animation counter
    @State var counter: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            // 🔵 Current time example
            //            Text(dateFormatter.string(from: currentDate))
            //                .font(.system(
            //                    size: 98,
            //                    weight: .semibold,
            //                    design: .rounded)
            //                )
            //                .foregroundStyle(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            
            // 🔵 Countdown example
            //            Text(finishText  ?? "\(count)")
            //                .font(.system(size: 98, weight: .semibold, design: .rounded))
            //                .foregroundStyle(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            
            // 🔵 Countdown to date
            //            Text(timeRemaining)
            //                .font(.system(size: 98, weight: .semibold, design: .rounded))
            //                .foregroundStyle(.white)
            //                .lineLimit(1)
            //                .minimumScaleFactor(0.1)
            
            // 🔵 Animation
            //            HStack(spacing: 12){
            //                Circle()
            //                    .offset(y: counter == 1 ? 20 : 0)
            //                Circle()
            //                    .offset(y: counter == 2 ? 20 : 0)
            //                Circle()
            //                    .offset(y: counter == 3 ? 20 : 0)
            //            }
            //            .frame(width: 275)
            //            .foregroundStyle(.white)
            
            // 🔵 TabView exapmle
            TabView(selection: $counter,
                    content:  {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        //        .onReceive(timer, perform: { value in
        //            currentDate = value
        //        })
        //        .onReceive(timer, perform: { _ in
        //            if count < 1 {
        //                finishText = "Wow!"
        //            } else {
        //                count -= 1
        //            }
        //        })
        //        .onReceive(timer, perform: { _ in
        //            updateTimeRemaining()
        //        })
        //        .onReceive(timer, perform: { _ in
        //            withAnimation(.easeInOut(duration: 0.5)) {
        //                counter = counter == 3 ? 0 : counter + 1
        //            }
        //        })
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                counter = counter == 5 ? 1 : counter + 1
            }
        })
    }
}

#Preview {
    TimerBootcamp()
}

/*
    🔴 Timer
        → A timer that fires after a certain time interval has elapsed, sending a specified message to a target object.
        → Timers work in conjunction with run loops.
        → Swift’s Timer class is a flexible way to schedule work to happen in the future, either just once or repeatedly.

    

         static func publish(
             every interval: TimeInterval,
             tolerance: TimeInterval? = nil,
             on runLoop: RunLoop,
             in mode: RunLoop.Mode,
             options: RunLoop.SchedulerOptions? = nil
         ) -> Timer.TimerPublisher


        🟡 every interval→ The time interval on which to publish events. For example, a value of 0.5 publishes an event approximately every half-second.

        🟡 tolerance → The allowed timing variance when emitting events. Defaults to nil, which allows any variance.

        🟡 on runLoop → The run loop on which the timer runs.

        🟡 in mode→ The run loop mode in which to run the timer.

        🟡 options → Scheduler options passed to the timer. Defaults to nil.

        🟣 Return Value → A publisher that repeatedly emits the current date on the given interval.

    🔴 .onReceive(_:perform:)
        → Adds an action to perform when this view detects data emitted by the given publisher.

        🟡 publisher → The publisher to subscribe to.
        🟡 action → The action to perform when an event is emitted by publisher.
 */
