//
//  TabOneViewController.swift
//  Test
//
//  Created by apple on 4/9/2021.
//

import UIKit
import SnapKit
class TabOneViewController: UIViewController {
    let tableView = UITableView()
    let albumManager = AlbumManageer.shared
    var list = [Album]()
    let v = AlbumCell()
    var safeArea: UILayoutGuide!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "Tab 1"
//        self.view.addSubview(v)
//        v.snp.makeConstraints { maker in
//            maker.centerX.equalToSuperview()
//            maker.centerY.equalToSuperview()
//            maker.width.height.equalToSuperview()
//        }
        setupTableView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print (albumManager.album)
    }
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      }
    
}
extension TabOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumManager.album?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = albumManager.album?[indexPath.row].collectionName
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        let collectionName = albumManager.album?[indexPath.row].collectionName ?? ""
        vc.collectionName = collectionName
        vc.nameLabel.text = collectionName
        if (albumManager.isBookmarked(name: collectionName)) {
            vc.bookmarkButton.setTitle("unbookmark", for: .normal)
        } else {
            vc.bookmarkButton.setTitle("bookmark", for: .normal)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
}
