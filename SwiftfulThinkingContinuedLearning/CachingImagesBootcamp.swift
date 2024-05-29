//
//  CachingImagesBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by enesozmus on 29.05.2024.
//

import SwiftUI

class CacheManager {
    
    static let instance: CacheManager = CacheManager() // Singleton
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 mb
        return cache;
    }()
    // 🟥 MARK: get
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    // 🟥 MARK: add
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    // 🟥 MARK: remove
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
}


class CacheViewModel: ObservableObject {
    
    let manager = CacheManager.instance
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    let imageName: String = "steve"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    // 🟥 MARK: get Image From Assets Folder
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    // 🟥 MARK: get From Cache
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
    }
    // 🟥 MARK: save To Cache
    func saveToCache() {
        guard let image = startingImage else { return }
        manager.add(image: image, name: imageName)
        infoMessage = "Good!"
    }
    // 🟥 MARK: remove From Cache
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
        cachedImage = nil
    }
}


struct CachingImagesBootcamp: View {
    
    @StateObject var vm: CacheViewModel = CacheViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    Text(vm.infoMessage)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(.purple)
                }
                HStack {
                    Button {
                        vm.saveToCache()
                    }label: {
                        Text("Save to Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(.blue, in: RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    }
                    Button {
                        vm.removeFromCache()
                    }label: {
                        Text("Delete from Cache")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding()
                            .background(.red, in: RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    }
                }
                Button {
                    vm.getFromCache()
                }label: {
                    Text("Get from Cache")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding()
                        .background(.green, in: RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                }
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    Text(vm.infoMessage)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(.purple)
                }
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

#Preview {
    CachingImagesBootcamp()
}

/*
 //
 //  FileManagerBootcamp.swift
 //  SwiftfulThinkingContinuedLearning
 //
 //  Created by enesozmus on 29.05.2024.
 //

 import SwiftUI

 class LocalFileManager {
     
     static let instance : LocalFileManager = LocalFileManager()
     
     // optinal
     let folderName: String = "MyApp_Images"
     
     
     init() {
         //createFolderIfNeeded()
     }
     
     
     // 🟥 MARK: save Image
     func saveImage(image: UIImage, name: String) {
         
         // 🔵 data
         //        guard
         //            let data: Data = image.jpegData(compressionQuality: 1.0) else {
         //            print("Error getting data")
         //            return
         //        }
         // 🔵 path
         // -> The relevant code has been moved to a separate function.
         //        guard
         //            let path: URL = FileManager
         //                .default
         //                .urls(for: .cachesDirectory, in: .userDomainMask)
         //                .first?
         //                .appendingPathComponent("\(name).jpg") else {
         //            print("Error getting path.")
         //            return
         //        }
         // 🔵 data and path
         guard
             let data: Data = image.jpegData(compressionQuality: 1.0),
             let path: URL = getPathForImage(name: name) else {
             print("Error getting path and data!")
             return
         }
         // 🔵 write
         do {
             try data.write(to: path)
             print("Success saving!")
         } catch let error {
             print("Failed saving: \(error.localizedDescription)")
         }
     }
     
     
     // 🟥 MARK: get Image
     func getImage(name: String) -> UIImage? {
         guard
             let path: String = getPathForImage(name: name)?.path(percentEncoded: false),
             FileManager.default.fileExists(atPath: path) else {
             print("🟥 Error: getImage")
             return nil
         }
         return UIImage(contentsOfFile: path)
     }
     
     
     // 🟥 MARK: get Path For Image
     func getPathForImage(name: String) -> URL? {
         // 🔵 path
         guard
             let path: URL = FileManager
                 .default
                 .urls(for: .cachesDirectory, in: .userDomainMask)
                 .first?
                 .appending(path: folderName)
                 .appending(path: "\(name).jpg") else {
             print("🟥 Error: getPathForImage")
             return nil
         }
         return path
     }
     
     
     // 🟥 MARK: delete Image
     func deleteImage(name: String) -> String {
         guard
             let path: String = getPathForImage(name: name)?.path(percentEncoded: false),
             FileManager.default.fileExists(atPath: path) else {
             return "Error getting path for delete func"
         }
         do {
             try FileManager.default.removeItem(atPath: path)
             return "Successfully deleted!"
         } catch let error {
             return "Error deleting image: \(error.localizedDescription)"
         }
     }
     
     
     // 🟥 MARK: create Folder If Needed
     func createFolderIfNeeded() {
         guard
             let path: String = FileManager
                 .default
                 .urls(for: .cachesDirectory, in: .userDomainMask)
                 .first?
                 .appending(path: folderName)
                 .path else { return }
         
         if !FileManager.default.fileExists(atPath: path) {
             do {
                 try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                 print("Success creating folder.")
             } catch let error {
                 print("Error creating folder. \(error)")
             }
         }
     }
     // 🟥 MARK: delete Folder
     func deleteFolder() {
         guard
             let path: String = FileManager
                 .default
                 .urls(for: .cachesDirectory, in: .userDomainMask)
                 .first?
                 .appending(path: folderName)
                 .path else { return }
         do {
             try FileManager.default.removeItem(atPath: path)
             print("Success deleting folder.")
         } catch let error {
             print("Error deleting folder. \(error)")
         }
     }
 }

 class FileManagerViewModel: ObservableObject {
     
     let manager: LocalFileManager = LocalFileManager.instance
     
     @Published var image: UIImage? = nil
     @Published var infoMessage: String = ""
     
     let imageName: String = "steve"
     
     
     init() {
         //getImageFromAssetsFolder()
         getImageFromAFileManager()
     }
     

     // 🟥 MARK: get Image From File Manager
     func getImageFromAFileManager() {
         image = manager.getImage(name: imageName)
     }
     // 🟥 MARK: save Image
     func saveImage() {
         guard let image = image else {
             return
         }
         manager.saveImage(image: image, name: imageName)
     }
     // 🟥 MARK: delete Image
     func deleteImage() {
         infoMessage = manager.deleteImage(name: imageName)
         print(infoMessage)
     }
 }

 struct FileManagerBootcamp: View {
     
     @StateObject var vm: FileManagerViewModel = FileManagerViewModel()
     
     var body: some View {
         NavigationStack {
             VStack {
                 if let image = vm.image {
                     Image(uiImage: image)
                         .resizable()
                         .scaledToFill()
                         .frame(width: 200, height: 200)
                         .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                 }
                 HStack {
                     Button {
                         vm.saveImage()
                     }label: {
                         Text("Save to FileManager")
                             .foregroundStyle(.white)
                             .font(.headline)
                             .padding()
                             .background(.blue, in: RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                     }
                     Button {
                         vm.deleteImage()
                     }label: {
                         Text("Delete from FileManager")
                             .foregroundStyle(.white)
                             .font(.headline)
                             .padding()
                             .background(.red, in: RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                     }
                     Text(vm.infoMessage)
                         .font(.largeTitle)
                         .fontWeight(.semibold)
                         .foregroundStyle(.purple)
                 }
                 Spacer()
             }
             .navigationTitle("File Manager")
         }
     }
 }

 #Preview {
     FileManagerBootcamp()
 }

 /*
     let directory:  [URL] = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
     let directory2: [URL] = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
     let directory3: URL   = FileManager.default.temporaryDirectory
  
  [file:///Users/enesozmus/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/1EC56300-C406-4371-B128-01A77A8E82C6/data/Containers/Data/Application/1787A0AC-B905-4C72-9E7D-FC62B4C38428/Documents/]
  
  [file:///Users/enesozmus/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/1EC56300-C406-4371-B128-01A77A8E82C6/data/Containers/Data/Application/1787A0AC-B905-4C72-9E7D-FC62B4C38428/Library/Caches/]
  
  file:///Users/enesozmus/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/1EC56300-C406-4371-B128-01A77A8E82C6/data/Containers/Data/Application/1787A0AC-B905-4C72-9E7D-FC62B4C38428/tmp/
  */
 /*
     let cachesDirectory: URL? = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
     let path: URL? = cachesDirectory?.appendingPathComponent("\(name).jpg")

  Optional(file:///Users/enesozmus/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/1EC56300-C406-4371-B128-01A77A8E82C6/data/Containers/Data/Application/28B27302-D1C2-4E4B-A41A-3C4584EFFFA0/Library/Caches/)
  Optional(file:///Users/enesozmus/Library/Developer/Xcode/UserData/Previews/Simulator%20Devices/1EC56300-C406-4371-B128-01A77A8E82C6/data/Containers/Data/Application/28B27302-D1C2-4E4B-A41A-3C4584EFFFA0/Library/Caches/steve.jpg)
  */

 */
