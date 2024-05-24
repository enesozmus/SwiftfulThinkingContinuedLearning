//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 24.05.2024.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    // ✅ If we had just one publisher, this "timer" is perfect.
    // var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    // ✅ Yes, it's a publisher.
    // ✅ So basically every time this gets updated, it's publishing a new value just like the timer.
    // ✅ It's going to be every time someone types on the text field.
    // ⭕️ And we can listen to it, we can subscribe to it and then perform actions
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        //        timer = Timer
        //            .publish(every: 1, on: .main, in: .common)
        //            .autoconnect()
        //            .sink { [weak self] _ in
        //                guard let self = self else { return }
        //                self.count += 1
        //                if self.count >= 10 {
        //                    self.timer?.cancel();
        //                }
        //            }
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    // ⭕️
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            // Subscribes to an additional publisher and publishes a tuple upon receiving output from either publisher.
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton =  true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(
                    Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)),
                    in: RoundedRectangle(cornerRadius: 10)
                )
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                    vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            Button {
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            }
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    SubscriberBootcamp()
}

/*
    🔴 .sink(receiveValue:)
         → The sink operator in Combine is used to subscribe to a publisher and receive values emitted by that publisher.
         → It provides a mechanism for subscribing to publishers and efficiently handling values and completion events.
         → It allows you to specify closures that will be executed when new values are emitted, and when the publisher completes or encounters an error.

    ✅ Subscribe to a Publisher: You use the sink operator to subscribe to a publisher and specify the actions to take when values are emitted, the publisher completes, or an error occurs.

    ⭕️ Check success/failure depending on whether is completed.
             🟢 receiveValue -> If successful, you can receive.
             ❗️ failure(throw) -> otherwise will give an error.

    1️⃣ receiveValue: This closure is called when the publisher emits a new value. It takes a single argument that represents the emitted value.
    2️⃣ receiveCompletion: This closure is called when the publisher either completes successfully or encounters an error. It takes a Subscribers.Completion object as an argument, which can be .finished or .failure(error). You can handle errors in this closure.
    3️⃣ Cancellation: The sink operator returns a Cancellable object.
  
    🔴 .store(in: &self.cancellables):
         → This is a method of AnyCancellable that adds the subscription to the cancellables set.
         → This allows the subscription to be canceled later if needed.
 
    🔴 .debounce(for:scheduler:options:)
        → Publishes elements only after a specified time interval elapses between events.
            🟡 for dueTime -> The time the publisher should wait before publishing an element.
            🟡 scheduler -> The scheduler on which this publisher delivers elements
            🟡 options -> Scheduler options that customize this publisher’s delivery of elements
 
    🔴 .map(_:)
        → Transforms all elements from the upstream publisher with a provided closure.
            🟡 transform -> A closure that takes one element as its parameter and returns a new element.
 */
