//
//  HomePresenter.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import UIKit

final class HomePresenter {

    // MARK: - Properties

    weak var viewInput: HomeViewInput?

    // MARK: - Private properties

    private var iconsList: IconsDTO?
    private let userRatesApiFactory = ApiFactory.makeIconsSeacherApi()
    private let iconsModelFactory = IconsModelFactory()
    private let fileManagerService = FileManagerService()
    private let coreDataService = CoreDataService(databaseName: .icons)

    // MARK: - Private functions

    private func getSafeImageAlert(with imageName: String) {
        let title = Texts.AlertMassege.safeImage
        let yesAction = UIAlertAction(title: Texts.AlertMassege.yes, style: .default) { _ in
            self.safeImage(imageName)
        }

        let NoAction = UIAlertAction(title: Texts.AlertMassege.cansel, style: .default)
        viewInput?.showAlert(title: title, message: nil, actions: [yesAction, NoAction])
    }

    private func getSavedImageAlert(isSaved: Bool) {
        var titel = ""
        if isSaved {
            titel = Texts.AlertMassege.savedImage
        } else {
            titel = Texts.AlertMassege.error
        }
        let action = UIAlertAction(title: titel, style: .default)
        viewInput?.showAlert(title: titel, message: nil, actions: [action])
    }

    private func getEmptiIconsAlert() {
        let OKAction = UIAlertAction(title: Texts.AlertMassege.OK, style: .cancel)
        viewInput?.showAlert(title: Texts.AlertMassege.emptyIcons, message: nil, actions: [OKAction])
    }

    private func safeImage(_ imageName: String) {
        var image: UIImage?
        do {
            image = try fileManagerService.image(withName: imageName.sha256() + ".png", in: .images)
        } catch {
            getBaseAlert(title: Texts.AlertMassege.error, message: Texts.ErrorMessage.failLoading)
            dump(error)
        }
        viewInput?.safeImage(with: image)
    }

    private func requestIconsList(with query: String) {
        self.userRatesApiFactory.getIcons(query: query) { data, errorMessage in
            defer { self.viewInput?.isLoading = false }

            guard let data else {
                self.getBaseAlert(title: Texts.AlertMassege.error, message: errorMessage ?? Texts.ErrorMessage.general)
                return
            }
            self.iconsList = data
            let model = self.iconsModelFactory.makeModels(from: data)
            self.viewInput?.models = model
            self.createLocalIconsList(for: query, icons: model)
            if model.isEmpty {
                self.getEmptiIconsAlert()
            }
        }
    }

    private func convert(_ icon: LocalIcon) -> IconsModel {
        return IconsModel(
            iconID: Int(icon.iconID),
            tags: icon.tags ?? "",
            sizes: icon.sizes ?? "",
            previewURL: icon.previewURL ?? "",
            downloadURL: icon.downloadURL ?? ""
        )
    }

    private func create(
        icons: LocalQueryRequest,
        icon: IconsModel,
        completion: (LocalIcon) -> Void
    ) {
        coreDataService.create(isSaveRequired: false) { (object: LocalIcon) in
            object.iconID = Int32(icon.iconID)
            object.sizes = icon.sizes
            object.tags = icon.tags
            object.previewURL = icon.previewURL
            object.downloadURL = icon.downloadURL
            object.icon = icons

            completion(object)
        }
    }

    private func createLocalIconsList(for query: String, icons: [IconsModel]) {
        coreDataService.create(isSaveRequired: true) { (object: LocalQueryRequest) in
            object.query = query
            var localIcon: [LocalIcon] = []

            for icon in icons {
                create(icons: object, icon: icon) { localIcon.append($0) }
            }
        }
    }

    private func fetchIconsList(with query: String) {
        do {
            let predicate = NSPredicate(format: "query == %@", query)
            if let request: LocalQueryRequest = try coreDataService.object(
                with: predicate,
                prefetchingRelationships: ["icons"]
            ) {
                if let iconsSet = request.icons as? Set<LocalIcon> {
                    viewInput?.models = iconsSet.compactMap(convert)
                }
                viewInput?.isLoading = false
            }
        } catch {
            dump(error)
            getBaseAlert(title: Texts.AlertMassege.error, message: Texts.ErrorMessage.failLoading)
            viewInput?.isLoading = false
        }
    }

    private func checkRequestExists(with query: String) -> Bool {
        let iconslist: [LocalQueryRequest]? = try? coreDataService.all()
        guard (iconslist?.first(where: { $0.query == query })) != nil else {
            return false
        }
        return true
    }
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {

    func getBaseAlert(title: String, message: String?) {
        let OKAction = UIAlertAction(title: Texts.AlertMassege.OK, style: .cancel)
        viewInput?.showAlert(title: title, message: message, actions: [OKAction])
    }

    func getIconsList(query: String?) {
        viewInput?.isLoading = true
        guard let query else { return }
        if checkRequestExists(with: query) {
            fetchIconsList(with: query)
        } else {
            requestIconsList(with: query)
        }
    }

    func viewDidSelectEntity(entity: IconsModel) {
        getSafeImageAlert(with: entity.previewURL)
    }
}
