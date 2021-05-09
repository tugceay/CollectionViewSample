//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Tugce Aybak on 8.05.2021.
//

import UIKit

class DetailViewController: UIViewController {

    private var detailText : String?
    private var imageName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView()
        let description = UILabel()
        
        imageView.image = try! UIImage.init(withContentsOfUrl: URL(string: self.imageName!)!)
        imageView.alpha = 0.7
        description.text = self.detailText
        description.font = UIFont(name: "HelveticaNeue", size: 16.0)!
        description.numberOfLines = 0
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        
        description.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(description)
        
        description.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        description.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        description.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        description.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true

        // Do any additional setup after loading the view.
    }
    
    public func setDetailData(imageName: String?, content: String?){
        self.detailText = content
        self.imageName = imageName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
