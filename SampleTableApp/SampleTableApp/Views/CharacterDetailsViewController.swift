//
//  CharacterDetailsViewController.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import SnapKit
import UIKit

class CharacterDetailsViewController: UIViewController {
    weak var coordinator: AppCoordinator?
    var characterNameLabel: UILabel!
    var characterStatusLabel: UILabel!
    var characterGenderLabel: UILabel!
    var characterUrlLabel: UILabel!
    var episodeTableView: UITableView!
    var viewModel: CharacterDetailsViewModel! {
        didSet {
            characterNameLabel.text = viewModel.getCharacterName
            characterStatusLabel.text = viewModel.getStatus
            characterGenderLabel.text = viewModel.getGender
        }
    }
    
    init(viewModel: CharacterDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        characterNameLabel = UILabel()
        characterNameLabel.textColor = UIColor.black
        characterNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        characterNameLabel.textAlignment = .left
        characterNameLabel.numberOfLines = 1
        view.addSubview(characterNameLabel)
        
        characterStatusLabel = UILabel()
        characterStatusLabel.textColor = UIColor.black
        characterStatusLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        characterStatusLabel.textAlignment = .left
        characterStatusLabel.numberOfLines = 1
        view.addSubview(characterStatusLabel)
        
        characterGenderLabel = UILabel()
        characterGenderLabel.textColor = UIColor.black
        characterGenderLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        characterGenderLabel.textAlignment = .left
        characterGenderLabel.numberOfLines = 1
        view.addSubview(characterGenderLabel)
        
        characterUrlLabel = UILabel()
        characterUrlLabel.textColor = UIColor.black
        characterUrlLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        characterUrlLabel.textAlignment = .left
        characterUrlLabel.numberOfLines = 1
        view.addSubview(characterUrlLabel)
        
        episodeTableView = UITableView()
        view.addSubview(episodeTableView)
        
        characterNameLabel.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview().offset(10)
        }
        characterStatusLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(5)
        }
        characterGenderLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterStatusLabel.snp.bottom).offset(5)
        }
        characterUrlLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterGenderLabel.snp.bottom).offset(5)
        }
        episodeTableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterUrlLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(10)
        }
    }
}
