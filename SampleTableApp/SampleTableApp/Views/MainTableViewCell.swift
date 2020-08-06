//
//  MainTableViewCell.swift
//  SampleTableApp
//
//  Created by Klaudiusz Majchrowski on 04/08/2020.
//  Copyright © 2020 Klaudiusz Majchrowski. All rights reserved.
//

import SnapKit
import UIKit

class MainTableViewCell: UITableViewCell {
    static let cellId: String = "MainTableCell"
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .left
        return label
    }()
    private lazy var characterImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    private var imageDownloadingTask: URLSessionTask?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .none
        contentView.addSubview(characterImage)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(characterStatusLabel)
        
        characterImage.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        characterNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(130)
            make.left.equalTo(characterImage.snp.right).offset(10)
        }
        characterStatusLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(characterNameLabel.snp.right).offset(20)
            make.right.equalToSuperview().offset(20)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.characterImage.image = nil
        self.characterNameLabel.text = nil
        self.characterStatusLabel.text = nil
        imageDownloadingTask?.cancel()
    }

    func setCharacter(for model: CharacterModel) {
        characterNameLabel.text = model.name
        characterStatusLabel.text = model.status
        imageDownloadingTask = characterImage.loadImage(urlString: model.imageUrl ?? "")
    }
}
