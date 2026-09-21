//
//  TaskGroupBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 18/09/26.
//

import SwiftUI
import Combine
class TaskGroupBootcampDataManager {
    func fetchImageWithAsyncLet() async throws -> [UIImage]{
        // ok if the number is less
        // what if we have to perform hundred of tasks
        async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/200")
        async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/200")
        async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/200")
        async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/200")
        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
        return [image1, image2, image3, image4]
        
    }
    func fetImagesWithTaskGroup() async throws -> [UIImage] {
        let urlString = ["https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200"]
        var images:[UIImage] = []
        images.reserveCapacity(urlString.count)

        try await withThrowingTaskGroup(of: UIImage?.self) { group in
            for url in urlString {
                group.addTask {
                    try? await self.fetchImage(urlString: url)
                }
            }
            for try await image in group {
                if let image = image {
                    images.append(image)
                }
            }
        }
        return images
    }
    
    func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
            
        }
        catch {
            throw error
        }
        
    }
}
class TaskGroupBootCampViewModel: ObservableObject {
    @Published var images: [UIImage] = []
    let manager = TaskGroupBootcampDataManager()
    func  getImages() async {
        if let images = try? await manager.fetImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
    
}
struct TaskGroupBootCamp: View {
    @StateObject private var viewModel = TaskGroupBootCampViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let 🥳")
            .task {
                await viewModel.getImages()
            }
            
        }
    }
}

#Preview {
    TaskGroupBootCamp()
}
