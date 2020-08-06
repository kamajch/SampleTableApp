//
//  StartViewModel.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 06/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import UIKit

class StartViewModel {
    private let apiManager = ApiManager(baseUrl: API.baseUrl)
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?(isLoading)
        }
    }
    
    var updateLoadingStatus: ((Bool) -> Void)?
    var downloadSuccess: ((CharacterData?) -> Void)?
    var downloadError: ((UIAlertController?) -> Void)?
    
    func startLoadData() {
        getCharactersFromApi()
    }
    
    private func getCharactersFromApi() {
        if isLoading == false {
            isLoading = true
            apiManager.getCharactersFromApi { [weak self] result in
                self?.isLoading = false
                switch result {
                case .success(let characters):
                    self?.downloadSuccess?(characters)
                case .failure(let error):
                    self?.downloadError?(self?.getAlert(message: error.localizedDescription))
                }
            }
        }
    }
    
    private func getAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Download error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
