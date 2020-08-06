//
//  MainTableViewController.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 03/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {    
    private let tableRefreshControl = UIRefreshControl()
    private let apiManager = ApiManager(baseUrl: API.baseUrl)
    
    var viewModel: MainTableViewModel!
    weak var coordinator: AppCoordinator?
        
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(for model: MainTableViewModel) {
        viewModel = model
        viewModel.updateLoadingStatus = { [weak self] () in
            let isLoading = self?.viewModel.isLoading ?? false
            if isLoading == false {
                DispatchQueue.main.async {
                    self?.tableRefreshControl.endRefreshing()
                }
            }
        }
        viewModel.valueChanges = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.cellId)
        tableView.showsVerticalScrollIndicator = true
        tableView.refreshControl = tableRefreshControl
        tableRefreshControl.addTarget(self, action: #selector(getCharacterData(_:)), for: .valueChanged)
    }
    
    @objc
    private func getCharacterData(_ sender: Any?) {
        viewModel.getCharactersFromApi()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellId, for: indexPath) as! MainTableViewCell
        let model = viewModel.getCharacterFor(row: indexPath.row)
        cell.setCharacter(for: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character: CharacterModel = viewModel.getCharacterFor(row: indexPath.row)
        coordinator?.showCharacterDetails(for: character)
    }
}
