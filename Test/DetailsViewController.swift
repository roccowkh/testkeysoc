//
//  DetailsViewController.swift
//  Test
//
//  Created by apple on 5/9/2021.
//

import UIKit
import SnapKit
import RxSwift

class DetailsViewController: UIViewController {
    let albumMananger = AlbumManageer.shared
    var collectionName: String?
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines=0
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let bookmarkButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initLayout()
    }
    
    func initLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(nameLabel)
        self.view.addSubview(bookmarkButton)
        self.view.addSubview(price)
        self.view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { maker in
            maker.leading.top.equalToSuperview().offset(12)
            maker.width.equalTo(80)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(20)
            maker.leading.greaterThanOrEqualTo(cancelButton.snp.trailing)
            
        }
        price.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        bookmarkButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        }

        
        cancelButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonOnClick), for: .touchUpInside)

    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func bookmarkButtonOnClick() {
        guard let collectionName = self.collectionName else {return}
        if (albumMananger.isBookmarked(name: collectionName)) {
            albumMananger.removeBookmark(name: collectionName)
            self.bookmarkButton.setTitle("bookmark", for: .normal)
        } else {
            albumMananger.addToBoomark(name: collectionName)
            self.bookmarkButton.setTitle("unbookmark", for: .normal)
        }
    }
}
