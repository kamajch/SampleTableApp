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
    var tableTitleLabel: UILabel!
    var episodeTableView: UITableView!
    
    var viewModel: CharacterDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setViewModel(for model: CharacterDetailsViewModel) {
        viewModel = model
        viewModel.valueChanged = { [weak self] in
            self?.episodeTableView.reloadData()
        }
        viewModel.downloadEpisodes()
    }
    private func setupView() {
        view.backgroundColor = UIColor.white
        characterNameLabel = UILabel()
        characterNameLabel.textColor = UIColor.black
        characterNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        characterNameLabel.textAlignment = .left
        characterNameLabel.numberOfLines = 1
        characterNameLabel.text = "B/D"
        view.addSubview(characterNameLabel)
        
        characterStatusLabel = UILabel()
        characterStatusLabel.textColor = UIColor.black
        characterStatusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        characterStatusLabel.textAlignment = .left
        characterStatusLabel.numberOfLines = 1
        characterStatusLabel.text = "B/D"
        view.addSubview(characterStatusLabel)
        
        characterGenderLabel = UILabel()
        characterGenderLabel.textColor = UIColor.black
        characterGenderLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        characterGenderLabel.textAlignment = .left
        characterGenderLabel.numberOfLines = 1
        characterGenderLabel.text = "B/D"
        view.addSubview(characterGenderLabel)
        
        characterUrlLabel = UILabel()
        characterUrlLabel.textColor = UIColor.black
        characterUrlLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        characterUrlLabel.textAlignment = .left
        characterUrlLabel.numberOfLines = 1
        view.addSubview(characterUrlLabel)
        
        tableTitleLabel = UILabel()
        tableTitleLabel.textColor = UIColor.black
        tableTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        tableTitleLabel.textAlignment = .center
        view.addSubview(tableTitleLabel)
        
        episodeTableView = UITableView()
        episodeTableView.separatorStyle = .none
        episodeTableView.backgroundColor = UIColor.white
        episodeTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.cellId)
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        view.addSubview(episodeTableView)
        
        characterNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        characterStatusLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterNameLabel.snp.bottom).offset(10)
        }
        characterGenderLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterStatusLabel.snp.bottom).offset(10)
        }
        characterUrlLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterGenderLabel.snp.bottom).offset(15)
        }
        tableTitleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(10)
            make.top.equalTo(characterUrlLabel.snp.bottom).offset(25)
        }
        episodeTableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(tableTitleLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(10)
        }
        
        characterNameLabel.text = viewModel.characterName
        characterStatusLabel.text = viewModel.characterStatus
        characterGenderLabel.text = viewModel.characterGender
        characterUrlLabel.text = viewModel.characterUrl
        tableTitleLabel.text = viewModel.titleText
    }
}

extension CharacterDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodesCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.cellId, for: indexPath) as! EpisodeTableViewCell
        cell.setEpisode(for: viewModel.getEpisode(for: indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
