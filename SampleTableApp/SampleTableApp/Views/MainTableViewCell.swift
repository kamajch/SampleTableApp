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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(characterImage)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(characterStatusLabel)
        
        characterImage.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview().offset(10)
            make.width.equalTo(100)
        }
        characterNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(130)
            make.left.equalTo(characterImage.snp.right).offset(20)
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
    }

    func setCharacter(for model: CharacterModel) {
        characterNameLabel.text = model.name
        characterStatusLabel.text = model.status
        characterImage.loadImage(urlString: model.imageUrl ?? "")
//        if let url = URL(string: model.imageUrl ?? "") {
//            loadImage(from: url)
//        }
    }
    
    private func loadImage(from url: URL) {
        self.characterImage.loadImage(urlString: url.absoluteString)
        let apiManager = ApiManager(baseUrl: url)
        apiManager.downloadImage(url: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.characterImage.image = image
                    self?.characterImage.clipsToBounds = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}



extension UIImageView {
    func loadImage(urlString: String) {
        let imageCache = NSCache<NSString, UIImage>()
              
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            imageCache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()

    }
}

