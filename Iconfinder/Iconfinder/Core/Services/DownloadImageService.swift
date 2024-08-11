//
//  DownloadImageService.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import UIKit

class DownloadImageService {
    
    // MARK: - Private properties
    
    private var task: URLSessionDataTask?
    
    private var fileManagerService = FileManagerService()
    
    private var isImage = false
    
    // MARK: - Functions
    
    /// Загрузка картинок по URL
    /// - Parameters:
    ///   - link: URL  изображения
    func downloadedImage(from link: String, completion: ((UIImage) -> Void)? = nil) {
        guard let url = URL(string: link) else { return }
        
        let fileName = link.sha256() + ".png"
        
        do {
            isImage = try fileManagerService.doesFileExist(with: fileName, in: .images)
        } catch {
            dump(error)
        }
        
        guard !isImage else {
            var image = UIImage()
            do {
                image = try fileManagerService.image(withName: fileName, in: .images) ?? UIImage()
            } catch {
                dump(error)
            }
            completion?(image)
            return
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(
            memoryCapacity: Constants.ImageCacheParam.memoryCapacity,
            diskCapacity: Constants.ImageCacheParam.diskCapacity,
            diskPath: "images"
        )
        configuration.httpMaximumConnectionsPerHost = Constants.ImageCacheParam.maximumConnections
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession(configuration: configuration)
        
        if let task = task {
            task.cancel()
        }
        
        self.task = session.dataTask(with: url) {
            data,
            response,
            error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.global(qos: .utility).async {
                do {
                    try self.fileManagerService.save(
                        data: data,
                        ofType: .image,
                        withName: fileName,
                        in: .images
                    )
                } catch {
                    dump(error)
                }
            }
            
            DispatchQueue.main.async {
                completion?(image)
            }
        }
        task?.resume()
    }
    
    func taskCancel() {
        task?.cancel()
    }
}
