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
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {

    func getBaseAlert(title: String, message: String?) {
        let OKAction = UIAlertAction(title: Texts.AlertMassege.OK, style: .cancel)
        viewInput?.showAlert(title: title, message: message, actions: [OKAction])
    }

    func getIconsList(qwery: String?) {
        viewInput?.isLoading = true
        if let qwery {
            self.userRatesApiFactory.getIcons(query: qwery) { data, errorMessage in
                defer { self.viewInput?.isLoading = false }

                guard let data else {
                    self.getBaseAlert(title: Texts.AlertMassege.error, message: errorMessage ?? Texts.ErrorMessage.general)
                    return
                }
                self.iconsList = data
                let model = self.iconsModelFactory.makeModels(from: data)
                self.viewInput?.models = model
                if model.isEmpty {
                    self.getEmptiIconsAlert()
                }
            }
        }
    }

    func viewDidSelectEntity(entity: IconsModel) {
        getSafeImageAlert(with: entity.previewURL)
    }
}
