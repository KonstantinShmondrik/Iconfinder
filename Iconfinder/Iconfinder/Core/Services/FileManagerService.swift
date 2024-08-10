//
//  FileManagerService.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import UIKit

enum FolderType: String {

    case images
}

class FileManagerService {

    enum FileManagerError: Error {

        case directoryNotFound, notFound, invalidExtension, missingExtension
    }

    enum FileType: String {

        case image

        var extensions: [String] {
            switch self {
            case .image: return ["jpg", "jpeg", "png", "gif", "tiff", "raw", "heic", "heif"]
            }
        }
    }

    private let fileManager = FileManager.default

    private func documentDirectoryUrl() throws -> URL {
        return try fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
    }

    private func validateExtension(ofFileName fileName: String, for type: FileType) throws {
        if NSString(string: fileName).pathExtension.isEmpty {
            throw FileManagerError.missingExtension
        }

        if !type.extensions.contains(NSString(string: fileName).pathExtension) {
            throw FileManagerError.invalidExtension
        }
    }

    private func createFolder(with folderType: FolderType) throws {
        do {
            let directory = try documentDirectoryUrl().appendingPathComponent(folderType.rawValue)
            try fileManager.createDirectory(
                at: directory,
                withIntermediateDirectories: true
            )
        } catch {
            dump(error)
            throw error
        }
    }

    func fileUrl(withName name: String, in folderType: FolderType? = nil) throws -> URL {
        let url: URL
        if let folder = folderType {
            url = try documentDirectoryUrl().appendingPathComponent(
                folder.rawValue,
                isDirectory: true
            ).appendingPathComponent(name)
        } else {
            url = try documentDirectoryUrl().appendingPathComponent(name)
        }
        return url
    }

    func image(withName name: String, in folderType: FolderType? = nil) throws -> UIImage? {
        try validateExtension(ofFileName: name, for: .image)

        do {
            let fileUrl = try fileUrl(withName: name, in: folderType).absoluteString.drop(prefix: "file://")
            guard let image = UIImage(contentsOfFile: fileUrl) else {
                throw FileManagerError.notFound
            }
            return image
        } catch {
            dump(error)
            throw error
        }
    }

    func save(data: Data, ofType type: FileType, withName name: String, in folderType: FolderType? = nil) throws {
        try validateExtension(ofFileName: name, for: type)

        do {
            if let folder = folderType {
                try createFolder(with: folder)
                let fileUrl = try fileUrl(withName: name, in: folder)
                try data.write(to: fileUrl)
            } else {
                let fileUrl = try fileUrl(withName: name)
                try data.write(to: fileUrl)
            }
        } catch {
            dump(error)
            throw error
        }
    }

    func imageFiles(from folderType: FolderType) throws -> [UIImage] {
        let imageNames = try filesList(in: folderType)
        var images: [UIImage] = []

        try imageNames.forEach { imageName in
            do {
                let image = try image(withName: imageName, in: folderType)
                if let image = image { images.append(image) }
            } catch {
                dump(error)
                throw error
            }
        }
        return images
    }

    func filesList(in folderType: FolderType) throws -> [String] {
        let documentFolder = try documentDirectoryUrl().appendingPathComponent(folderType.rawValue, isDirectory: true)
        let folderLinks = try fileManager.contentsOfDirectory(atPath: documentFolder.path)
        let folderFilesList = folderLinks.compactMap { $0.components(separatedBy: "/").last }
        return folderFilesList
    }

    func doesFileExist(with name: String, in folderType: FolderType? = nil) throws -> Bool {
        do {
            let fileUrl = try fileUrl(withName: name, in: folderType)
            return fileManager.fileExists(atPath: fileUrl.path)
        } catch {
            dump(error)
            throw error
        }
    }

    func removeFile(withName name: String, in folderType: FolderType? = nil) throws {
        do {
            let fileUrl = try fileUrl(withName: name, in: folderType)
            if fileManager.fileExists(atPath: fileUrl.path) {
                try fileManager.removeItem(at: fileUrl)
            }
        } catch {
            dump(error)
            throw error
        }
    }

    func removeAllFiles(in folderType: FolderType) throws {
        let documentUrl = try documentDirectoryUrl()
        let folderUrl = documentUrl.appendingPathComponent(folderType.rawValue, isDirectory: true)
        let fileUrls = try fileManager.contentsOfDirectory(at: folderUrl, includingPropertiesForKeys: nil)

        for fileUrl in fileUrls {
            do {
                try fileManager.removeItem(at: fileUrl)
            } catch {
                dump(error)
                throw error
            }
        }
    }
}
