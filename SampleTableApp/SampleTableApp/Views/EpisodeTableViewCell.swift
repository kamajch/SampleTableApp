//
//  EpisodeTableViewCell.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 05/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import Foundation
import UIKit

class EpisodeTableViewCell: UITableViewCell {
    static let cellId: String = "EpisodeTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.white
        contentView.addSubview(nameLabel)
        contentView.addSubview(episodeLabel)
        contentView.addSubview(dateLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.right.equalTo(episodeLabel.snp.left).offset(-10)
        }
        episodeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(dateLabel.snp.left)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.right.equalToSuperview().offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEpisode(for model: EpisodeModel) {
        nameLabel.text = model.name
        episodeLabel.text = model.episode
        dateLabel.text = model.airDate
    }
}
