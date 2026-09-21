//
//  FileManagerBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 17/08/26.
//

import SwiftUI
import Combine

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    init() {
        createFolderIfNeeded()
    }
    func createFolderIfNeeded() {
        guard let folderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName) else {
            return
        }
        let path = folderURL.path
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
            }
            catch {
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path() else {
            print("Error getting path")
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
        }catch {
            print("error")
        }
    }
    
    func saveImage(image:UIImage, name:String){
        guard let data = image.jpegData(compressionQuality: 1.0), let path = getPathForImage(name: name) else {
            return
        }
        
        do {
            try data.write(to: path)
        }
        catch {
        }
        
    }
    func getImage(name:String) -> UIImage? {
        guard let url = getPathForImage(name: name) else { return nil }
        let path = url.path
        guard FileManager.default.fileExists(atPath: path) else { return nil }
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name:String) -> URL? {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).appendingPathComponent("\(name).jpg") else {
            print("Error getting path")
            return nil
        }
        return path
    }
    func deleteImage(name:String)-> String {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).appendingPathComponent("\(name).jpg") else {
            return ("Error getting path")
        }
        do {
            try FileManager.default.removeItem(at: path)
            return ("succcessfully deleted item")
        }
        catch {
            return ("error deleting the image")
        }
    }
    
}

class FileManagerVM: ObservableObject {
    @Published var image:UIImage? = nil
    let manager = LocalFileManager.instance
    let imageName = "myPic"
    @Published var infoMessage = ""
    
    init() {
        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image = image else {
            return
        }
        manager.saveImage(image: image, name: imageName)
        getImageFromFileManager()
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        image = nil
    }
     
}

struct FileManagerBootCamp: View {
    @StateObject var viewModel = FileManagerVM()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button {
                        viewModel.getImageFromAssetsFolder()
                    } label: {
                        Text("LOAD ASSET")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    Button {
                        viewModel.saveImage()
                    } label: {
                        Text("SAVE TO FM")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Button {
                        viewModel.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .padding()
                

                
                Spacer()
            }
            .navigationTitle("File Manager")
            .onAppear {
                viewModel.getImageFromFileManager()
            }
           
        }
    }
}

#Preview {
    FileManagerBootCamp()
}
