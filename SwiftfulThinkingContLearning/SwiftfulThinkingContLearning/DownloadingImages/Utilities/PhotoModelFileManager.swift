//
//  PhotoModelFileManager.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 01/09/26.
//
import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    private init() {}
    let folderName = "DownloadedImages"
    
    private func createFolderIfNeeded() {
        guard let folderPath = getFolderPath() else { return }
        if !FileManager.default.fileExists(atPath: folderPath.path) {
            do {
                try? FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
                print("Created folder")
            }
            catch let error{
                
            }
        }
        
    }
    private func getFolderPath() -> URL?{
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?.appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key:String, value:UIImage) {
        guard let data = value.pngData(), let url = getImagePath(key: key) else { return }
        do {
            try data.write(to: url)
        }
        catch let error {
            print("Error saving to file manager")
        }
    }
    func get(key:String) -> UIImage? {
        guard let url = getImagePath(key: key), FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
}
