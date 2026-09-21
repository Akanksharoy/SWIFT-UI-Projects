//
//  AsyncLetBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 18/09/26.
//

import SwiftUI


struct AsyncLetBootCamp: View {
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                    }
                }
            }
            .navigationTitle("Async Let 🥳")
            .onAppear {
                Task {
                    do {
                        // in below scenario the task are executed one by one but we want simultaneous execution so use async let
                        /*
                         let image1 = try await fetchImage()
                         self.images.append(image1)
                         
                         let image2 = try await fetchImage()
                         self.images.append(image2)
                         
                         let image3 = try await fetchImage()
                         self.images.append(image3)
                         */
                        // in below scenario all of them start execution simultaneously, not necessarily all of them have to return the same types
                        async let fetchImage1 = fetchImage()
                        async let fetchImage2 = fetchImage()
                        async let fetchImage3 = fetchImage()
                        async let fetchImage4 = fetchImage()
                        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        
                    }
                    catch {
                        
                    }
                }
            }
        }
    }
    
    func fetchImage() async throws -> UIImage {
        do{
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://picsum.photos/200")!)
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

#Preview {
    AsyncLetBootCamp()
}
