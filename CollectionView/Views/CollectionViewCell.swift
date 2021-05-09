//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Tugce Aybak on 8.05.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var imageViewHeightConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func fillCellProperties(item: Meditation){
        self.imageView.image = try! UIImage.init(withContentsOfUrl: URL(string: item.image.small)!)
        self.titleLabel.text = item.title
        self.descLabel.text = item.subtitle
        self.imageViewHeightConst.constant = 160
    }
    
    public func fillCellPropertiesForStories(item: Story){
        self.imageView.image = try! UIImage.init(withContentsOfUrl: URL(string: item.image.small)!)
        self.titleLabel.text = item.name
        self.descLabel.text = item.category
        self.imageViewHeightConst.constant = 120
    }

}
