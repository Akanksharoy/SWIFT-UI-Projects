//
//  CacheBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 20/08/26.
//

import SwiftUI
import Combine

class CacehManager {
    static let instance = CacehManager()
    private init(){}
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 100 * 1024 * 1024
        return cache
    }()
    
    func add(image:UIImage, name:String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func get(name:String) -> UIImage?{
        return imageCache.object(forKey: name as NSString)
    }
    
    func delete(name:String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    
}
class CacheViewModel:ObservableObject {
    @Published var startImage:UIImage? = nil
    @Published var cachedImage:UIImage? = nil
    let cacheManager = CacehManager.instance
    let imageName = "myPic"
    
    init() {
        getImageFromAssetsFolder()
    }
    func getImageFromAssetsFolder() {
        startImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startImage else { return }
        cacheManager.add(image: image, name: imageName)
        cachedImage = cacheManager.get(name: imageName) // populate for UI
    }
    
    func removeFromCache() {
        cacheManager.delete(name: imageName)
    }
    func getFromCache(name:String) {
        cachedImage = cacheManager.get(name: name)
    }
}
struct CacheBootCamp: View {
    @StateObject var viewModel = CacheViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let image = viewModel.startImage {
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                            .cornerRadius(10)
                }
               
              
              
                HStack {
                    Button {
                        viewModel.saveToCache()
                    } label: {
                        Text("SAVE TO FM")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Button {
                        viewModel.removeFromCache()
                    } label: {
                        Text("Delete from FM")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding()
                if let image = viewModel.cachedImage {
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                            .cornerRadius(10)
                }

                
                Spacer()
            }
            .navigationTitle("Cache Manager")
            
           
        }
    }
}

#Preview {
    CacheBootCamp()
}
