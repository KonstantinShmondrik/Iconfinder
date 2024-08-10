//
//  UIImageViewAsync.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 08.08.2024.
//

import UIKit

final class UIImageViewAsync: UIImageView {
    
    // MARK: - Properties
    
    var completion: (() -> Void)?
    
    // MARK: - Private properties
    
    private var task: URLSessionDataTask?
    
    private var fileManagerService = FileManagerService()
    private var downloadImageService = DownloadImageService()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicatorStyle = UIActivityIndicatorView.Style.medium
        let activityIndicator = UIActivityIndicatorView.init(style: indicatorStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Construction
    
    init() {
        super.init(frame: .zero)
        setActivityIndicator()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Functions
    
    /// Загрузка картинок по URL
    /// - Parameters:
    ///   - link: URL  изображения
    ///   - mode: ContentMode  по умолчанию  scaleAspectFit
    ///   - isActivityIndicator: наличие ActivityIndicator по умолчанию true
    func downloadedImage(from link: String,
                         contentMode mode: ContentMode = .scaleAspectFit,
                         isActivityIndicator: Bool = true) {
        
        if isActivityIndicator {
            activityIndicator.startAnimating()
        }
        
        downloadImageService.downloadedImage(from: link) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                self.image = image
                self.activityIndicator.removeFromSuperview()
                
                self.completion?()
            }
        }
    }
    
    // MARK: - Private functions
    
    private func setActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
