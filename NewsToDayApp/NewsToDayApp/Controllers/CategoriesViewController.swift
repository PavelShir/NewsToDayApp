//
//  CategoriesViewController.swift
//  NewsToDayApp
//
//  Created by Павел Широкий on 20.10.2024.
//
import SwiftUI
import UIKit

class CategoriesViewController: UIViewController {
    
    // MARK: - UI
    private lazy var labelTitle : UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 24, weight: .bold)
        element.textColor = UIColor(named: K.BrandColors.blackPrimary)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var labelTitleDescription : UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .light)
        element.textColor = UIColor(named: K.BrandColors.greyPrimary)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private lazy var mainStack : UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.alignment = .fill
        element.spacing = 8
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var collectionview : UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 160, height: 72)
        let element = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        element.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        element.showsVerticalScrollIndicator = false
        
        element.translatesAutoresizingMaskIntoConstraints = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    // MARK: - Variables
    
    var cellId = "Cell"
    
    let categories = [K.Categories.sports,
                      K.Categories.politics,
                      K.Categories.life,
                      K.Categories.gaming,
                      K.Categories.animals,
                      K.Categories.nature,
                      K.Categories.food,
                      K.Categories.art,
                      K.Categories.history,
                      K.Categories.fashion,
                      K.Categories.covid19,
                      K.Categories.middleEast ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        setView()
        setConstraints()
        setDelegate()
    }
    
    private func setDelegate(){
        collectionview.dataSource = self
        collectionview.delegate = self
    }
    
    // MARK: - Set View
    
    func setView(){
        
        
        /*labelTitle.text = "Categories"*/
        labelTitleDescription.text = "Thousands of articles in each category"
        mainStack.addArrangedSubview(labelTitle)
        mainStack.addArrangedSubview(labelTitleDescription)
        mainStack.addArrangedSubview(collectionview)
        view.addSubview(mainStack)
    }
}

// MARK: - Setup Constraints

extension CategoriesViewController {
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        
        cell.button.setTitle(categories[indexPath.row], for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - UI
    
    public var button : UIButton = {
        let element = UIButton()
        
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        element.backgroundColor = .white
        element.setTitleColor(UIColor(named: K.BrandColors.greyDark), for: .normal)
        element.layer.borderWidth = 2
        element.layer.borderColor = UIColor(named: K.BrandColors.greyLighter)?.cgColor
        element.layer.cornerRadius = 12
        element.addTarget(CategoryCollectionViewCell.self, action: #selector(buttonPressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setView()
    }
    
    // MARK: - Setup View
    
    private func setView(){
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    // MARK: - Actions
    
    @objc func buttonPressed(_ sender: UIButton) {
                
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        CategoriesViewController().showPreview()
    }
}


