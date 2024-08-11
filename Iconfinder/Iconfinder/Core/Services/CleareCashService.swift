//
//  ClearCashService.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import UIKit

class CleareCashService {

    private let fileManagerService = FileManagerService()
    private let coreDataService = CoreDataService(databaseName: .icons)

    private func clearFileManager() {
        do {
            try fileManagerService.removeAllFiles(in: .images)
        } catch {
            dump(error)
        }
    }

    private func cleareCoreData() {
        coreDataService.recreateDatabase()
    }

    func clearCash() {
        clearFileManager()
        cleareCoreData()
    }
}
