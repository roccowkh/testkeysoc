//
//  AlbumCell.swift
//  Test
//
//  Created by apple on 5/9/2021.
//

import UIKit

class AlbumCell: UIView {
    var myNames = ["dipen","laxu","anis","aakash","santosh","raaa","ggdds","house"]
    let label : UILabel = {
        let label = UILabel()
        label.text = "ABC"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
        self.backgroundColor = UIColor.red
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        self.addSubview(label)
    }
}
