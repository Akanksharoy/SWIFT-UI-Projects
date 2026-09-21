//
//  DownloadWithcombine.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 10/08/26.
//

import SwiftUI
import Combine
struct PostModel:Identifiable, Decodable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    // Combine discussion:
    /*
    // 1. sign up for monthly subscription for package to be delivered
    // 2. the company would make the package behind the scene
    // 3. recieve the package at your front door
    // 4. make sure the box isn't damaged
    // 5. open and make sure the item is correct
    // 6. use the item!!!!
    // 7. cancellable at any time!!
    
    // 1. create the publisher
    // 2. subscribe publisher on background thread
    // 3. recieve on main thread
    // 4. tryMap (check that the data is good)
    // 5. decode (decode data into PostModels)
    // 6. sink (put the item into our app)
    // 7. store (cancel subscription if needed)
    */
    init()
    {
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
    }
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
            guard
                let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            return output.data
        }
    
   
}
struct DownloadWithcombine: View {
    @StateObject var viewModel = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts){
                post in
                Text(post.title)
                    .font(.headline)
                Text(post.body)
                    .font(.caption2)
            }
        }
    }
}

#Preview {
    DownloadWithcombine()
}
