////
////  DownloadWithEscaping.swift
////  SwiftfulThinkingContLearning
////
////  Created by Akanksha on 23/07/26.
////
//
//import SwiftUI
//import Combine
//
//struct PostModel:Identifiable, Decodable {
//    let userId:Int
//    let id:Int
//    let title:String
//    let body:String
//}
//class DownloadWithEscapingViewModel: ObservableObject {
//    @Published var posts: [PostModel] = []
//    init(){
//        getPosts()
//    }
//    func getPosts() {
//        
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//        
//        downloadData(url: url) { (returnedData) in
//            if let data = returnedData {
//                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
//                DispatchQueue.main.async { [weak self] in
//                    self?.posts = newPosts
//                }
//            } else {
//                print("No data returned.")
//            }
//        }
//    }
//    
//    func downloadData(url:URL, completion: @escaping (Data?) -> ()) {
//        
//        
//        URLSession.shared.dataTask(with: url){ (data, response, error) in
//            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
//                print("no data")
//                completion(nil)
//                return
//            }
//            
//            guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else {
//                completion(nil)
//                return
//            }
//            DispatchQueue.main.async { [weak self] in
//                completion(data)
//            }
//            
//        }.resume()
//        
//    }
//}
//struct DownloadWithEscaping: View {
//    @StateObject var viewModel = DownloadWithEscapingViewModel()
//    var body: some View {
//        List {
//            ForEach(viewModel.posts) { post in
//                Text(post.title)
//                Text(post.body)
//            }
//        }
//    }
//}
//
//#Preview {
//    DownloadWithEscaping()
//}
