//
//  StartViewModel.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 06/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation

class StartViewModel {
    private let apiManager = ApiManager(baseUrl: API.baseUrl)
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?(isLoading)
        }
    }
    
    var updateLoadingStatus: ((Bool) -> Void)?
    var downloadSuccess: ((CharacterData?) -> Void)?
    
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
                    self?.updateLoadingStatus?(self?.isLoading ?? false)
                case .failure(let error):
                    print(error.localizedDescription)
//                    self?.updateLoadingStatus?(self?.isLoading ?? false)
                }
            }
        }
    }
}
