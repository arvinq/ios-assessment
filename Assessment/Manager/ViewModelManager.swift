//
//  ViewModelManager.swift
//  Assessment
//
//  Created by Arvin Quiliza on 4/3/22.
//

import UIKit

class ViewModelManager {
    
    var networkManager: NetworkManagerProtocol
    
    // properties that triggers binding and updates our view
    var alertMessage: String? {
        didSet { self.presentAlert?() }
    }
    
    var photoCellViewModelList: [PhotoViewModel] = [] {
        didSet { self.reloadCollection?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.animateLoadView?() }
    }
    
    // bindings
    var presentAlert: (()->())?
    var reloadCollection: (()->())?
    var animateLoadView: (()->())?
    var bindPhotoForFocus: (()->())?
        
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Returns an individual view model at a given index in the array.
    func getPhotoCellViewModel(on index: Int) -> PhotoViewModel {
        return photoCellViewModelList[index]
    }
    
    /// Main entry point that communicates with NetworkManager to fetch the photos and trigger an update to the collectionView
    func getPhotos() {
        self.isLoading = true
        self.networkManager.getPhotos { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let photos):
                var photoCellViewModels = [PhotoViewModel]()
                photoCellViewModels.append(contentsOf: photos.map{ PhotoViewModel(photo: $0) })
                self.photoCellViewModelList = photoCellViewModels // will trigger the reload
                
            case .failure(let error):
                self.alertMessage = error.rawValue
            }
        }
    }
}
