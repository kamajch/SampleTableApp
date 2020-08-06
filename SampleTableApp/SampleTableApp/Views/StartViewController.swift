//
//  StartViewController.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 03/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    
    var titleLabel: UILabel!
    var loader: UIActivityIndicatorView!
    
    var viewModel: StartViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setViewModel(for model: StartViewModel) {
        viewModel = model
        viewModel.updateLoadingStatus = { [weak self] (isLoading) in
            DispatchQueue.main.async {
                isLoading ? self?.loader.startAnimating() : self?.loader.stopAnimating()
            }
        }
        viewModel.downloadSuccess = { [weak self] (characters) in
            DispatchQueue.main.async {
                self?.coordinator?.showMainTable(for: characters)
            }
        }
        if NetworkStatusManager.shared.isInternetConnected() {
            viewModel.startLoadData()
        } else {
            showNoInternetInfo()
        }
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = "Ładowanie danych..."
        view.addSubview(titleLabel)
        
        loader = UIActivityIndicatorView()
        loader.color = UIColor.red
        view.addSubview(loader)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-50)
        }
        loader.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(40)
        }
    }
    private func showNoInternetInfo() {
        titleLabel.isHidden = true
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noInternet")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
}
