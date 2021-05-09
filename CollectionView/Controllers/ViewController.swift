//
//  ViewController.swift
//  CollectionView
//
//  Created by Tugce Aybak on 8.05.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let collectionCellIdentifier = "CollectionViewCell"
    
    private var meditationCollectionView : UICollectionView?
    private var storyCollectionView : UICollectionView?
    private var meditationsTitleView : UIView?
    private var storiesTitleView : UIView?
    private var banner : UIView?
    private var dataModel :DataModel?
    private var bannerVisible = false
    private let PADDING_SIZE = CGFloat(10.0)
    private let HEIGHT_OF_MEDITATION = CGFloat(230.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
        ServiceLauncher.init().callService{[weak self] (dataModel) in
            self?.dataModel = dataModel
            
            DispatchQueue.main.async {
                self?.addMetitationTitle()
                self?.addMeditationCollectionView()
                if(self?.dataModel?.isBannerEnabled ?? false){
                    self?.bannerVisible = true
                    self?.addBanner()
                }
                self?.addStoriesTitle()
                self?.addStoriesView()
            }
        } errorHandler:{ [weak self] (error ) in
            DispatchQueue.main.async {
                self?.showError()
            }
        }
        
    }
    
    func showError(){
        let errorLabel = UILabel()
        errorLabel.text = "Could not load data"
        errorLabel.textColor = .white
        self.view.addSubview(errorLabel)
        
    }
    
    func addMetitationTitle(){
        self.meditationsTitleView = createTitleView(text: "Meditations")
        self.view.addSubview(self.meditationsTitleView!)
        addConstraintsForViews(view1: self.meditationsTitleView, view2: nil, height: 20)
    }
    
    func addMeditationCollectionView(){
        
        self.meditationCollectionView = createCollectionView(tagId: 0, direction: .horizontal, itemSize: CGSize(width: 150, height: HEIGHT_OF_MEDITATION))
        
        guard let collection = self.meditationCollectionView else{
            return
        }
        self.view.addSubview(collection)
        addConstraintsForViews(view1: self.meditationCollectionView, view2: self.meditationsTitleView, height: HEIGHT_OF_MEDITATION)
        
    }
    
    func addBanner(){
        self.banner = UIView()
        self.banner?.clipsToBounds = true
        self.banner?.backgroundColor = .blue
        self.banner?.layer.cornerRadius = 8.0
        let label = UILabel()
        label.text = "Banner Text"
        label.textAlignment = .center
        label.textColor = .white
        self.banner?.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        self.banner?.addSubview(label)
        label.topAnchor.constraint(equalTo: self.banner!.topAnchor, constant: PADDING_SIZE).isActive = true
        label.bottomAnchor.constraint(equalTo: self.banner!.bottomAnchor, constant: -PADDING_SIZE).isActive = true
        label.leadingAnchor.constraint(equalTo: self.banner!.leadingAnchor, constant: PADDING_SIZE).isActive = true
        label.trailingAnchor.constraint(equalTo: self.banner!.trailingAnchor, constant: -PADDING_SIZE).isActive = true
        
        self.view.addSubview(self.banner!)
        
        addConstraintsForViews(view1: self.banner, view2: self.meditationCollectionView, height: 50)
    }
    
    func addStoriesTitle(){
        self.storiesTitleView = createTitleView(text: "Stories")
        self.view.addSubview(self.storiesTitleView!)
        if(bannerVisible){
            addConstraintsForViews(view1: self.storiesTitleView, view2: self.banner, height: 20)
        }else{
            addConstraintsForViews(view1: self.storiesTitleView, view2: self.meditationCollectionView, height: 20)
        }
    }
    
    func addStoriesView(){
        
        let itemSize = self.view.frame.width < 430 ? (self.view.frame.width - 30)/2 : 200
        self.storyCollectionView = createCollectionView(tagId: 1, direction: .vertical, itemSize: CGSize(width: itemSize, height: itemSize))
        
        guard let collection2 = self.storyCollectionView else{
            return
        }
        self.view.addSubview(collection2)
        
        addConstraintsForViews(view1: self.storyCollectionView, view2: self.storiesTitleView, height: 0)
        
        
    }
    
    func createCollectionView(tagId: Int, direction: UICollectionView.ScrollDirection, itemSize :CGSize) -> UICollectionView {
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = direction
        collectionLayout.itemSize = itemSize
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.tag = tagId
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: collectionCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionCellIdentifier)
        
        return collectionView;
    }
    
    func createTitleView(text: String) -> UIView{
        let title = UILabel()
        title.text = text
        title.textColor = .white
        title.font = UIFont(name: "HelveticaNeue-Medium", size: 17.0)!
        return title
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 0){
            return dataModel?.meditations.count ?? 0
        }else{
            return dataModel?.stories.count ?? 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! CollectionViewCell
        if(collectionView.tag == 0){
            cell.fillCellProperties(item: (self.dataModel?.meditations[indexPath.row])!)
        }else{
            cell.fillCellPropertiesForStories(item: (self.dataModel?.stories[indexPath.row])!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if(collectionView.tag == 0){
            let meditation = self.dataModel?.meditations[indexPath.row]
            detailViewController.setDetailData(imageName: meditation?.image.large, content: meditation?.content)
        }else{
            let story = self.dataModel?.stories[indexPath.row]
            detailViewController.setDetailData(imageName: story?.image.large, content: story?.text)
        }
        self.navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    
    func addConstraintsForViews(view1: UIView?, view2: UIView?, height : CGFloat){
        view1?.translatesAutoresizingMaskIntoConstraints = false
        view2?.translatesAutoresizingMaskIntoConstraints = false
        if(view2 != nil){
            view1?.topAnchor.constraint(equalTo: view2!.bottomAnchor, constant: PADDING_SIZE).isActive = true
        }else{
            view1?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: PADDING_SIZE).isActive = true
        }
        view1?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: PADDING_SIZE).isActive = true
        view1?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -PADDING_SIZE).isActive = true
        if(height != 0){
            view1?.heightAnchor.constraint(equalToConstant: height).isActive = true
        }else{
            view1?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: PADDING_SIZE).isActive = true
        }
    }

}

