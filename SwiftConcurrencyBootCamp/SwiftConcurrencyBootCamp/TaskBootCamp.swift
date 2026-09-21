//
//  TaskBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 17/09/26.
//

import SwiftUI
import Combine

class TaskBootCampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return}
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            
            let image = UIImage(data: data)
            self.image = image
            print("IMAGE RETURNED SUCCESSFULLY!")
        } catch  {
            print(error.localizedDescription)
        }
    }
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return}
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            
            let image = UIImage(data: data)
            self.image2 = image
        } catch  {
            print(error.localizedDescription)
        }
    }
}
struct TaskBootcampHomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("CLICK ME! 🤓") {
                    TaskBootCamp()
                }
            }
        }
    }
}
struct TaskBootCamp: View {
    @StateObject private var viewModel = TaskBootCampViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = viewModel.image2 {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            //.task automatically cancel the task when view disappears
            await viewModel.fetchImage()
        }
        .onDisappear {
            // cancel the task when view disapperars
            fetchImageTask?.cancel()
        }
        
        .onAppear {
            fetchImageTask = Task {
                // waiting for first one to complete and then the second image is fetched
                await viewModel.fetchImage()
                await viewModel.fetchImage2()
            }
            // below the task are executed simultaneously and no one waits for the other
            /*Task {
             print(Thread.current)
             print(Task.currentPriority)
             await viewModel.fetchImage()
             }
             Task {
             print(Thread.current)
             print(Task.currentPriority)
             await viewModel.fetchImage2()
             }*/
            
            /*Task(priority: .low) {
             print("Low: \(Thread.current) \(Task.currentPriority.rawValue)")
             }
             Task(priority: .medium) {
             print("medium: \(Thread.current) \(Task.currentPriority.rawValue)")
             }
             Task(priority: .high) {
             try? await Task.sleep(nanoseconds: 2_000_000_000) // we should not use sleep func to give a chnace to other taks to run instead use yield func
             print("high: \(Thread.current) \(Task.currentPriority.rawValue)")
             }
             Task(priority: .background) {
             print("background: \(Thread.current) \(Task.currentPriority.rawValue)")
             }
             Task(priority: .utility) {
             print("utility: \(Thread.current) \(Task.currentPriority.rawValue)")
             }*/
            
            //Task.yield() is a function that voluntarily gives other tasks a chance to run.
            /*
             Task {
             print("A")
             
             await Task.yield()
             
             print("B")
             }
             
             Task {
             print("C")
             }
             */
            /*
             A
             C
             B
             */
            /*
             Task(priority: .low) {
             print("low: \(Thread.current) \(Task.currentPriority.rawValue)")
             Task {
             // child task will inherit the priority from parent task
             print("low2: \(Thread.current) \(Task.currentPriority.rawValue)")
             }
             Task.detached {
             //if you don't want to attach the child task to parent task, so that child task do not inherit the priority from  parent taks, but apple wants us to avoid this
             print("detached task: \(Thread.current) \(Task.currentPriority.rawValue)")
             }
             }
             */
            
        }
        
    }
}

#Preview {
    TaskBootCamp()
}
