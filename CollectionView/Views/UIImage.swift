//
//  UIImage.swift
//  CollectionView
//
//  Created by Tugce Aybak on 8.05.2021.
//

import UIKit

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
