//
//  ContinuationBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 20/09/26.
//

import SwiftUI
import Combine

class ContinuationBootCampMnanager {
    func getData(url: URL) async throws -> Data{
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            return data
        }
        catch let error{
            print(error.localizedDescription)
            throw error
        }
    }
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation {continuation  in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                }
                else if let error = error {
                    continuation.resume(throwing: error)
                }
                else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
        
    }
}
class ContinuationBootCampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let netWorkManager = ContinuationBootCampMnanager()
    func getImage() async {
        do {
            let data = try await netWorkManager.getData2(url: URL(string: "https://picsum.photos/200")!)
            image = UIImage(data: data)
        }
        catch {
            
        }
        
    }
    
    
    
}
struct ContinuationBootCamp: View {
    @StateObject private var viewModel = ContinuationBootCampViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.getImage()
        }
    }
}

#Preview {
    ContinuationBootCamp()
}
