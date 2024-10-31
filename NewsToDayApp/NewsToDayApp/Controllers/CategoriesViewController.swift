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
    
    private lazy var nextButton : UIButton = {
        let element = UIButton()
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        element.backgroundColor = UIColor(named: K.BrandColors.purplePrimary)
        element.setTitleColor(.white, for: .normal)
        element.layer.borderWidth = 2
        element.layer.borderColor = UIColor(named: K.BrandColors.purplePrimary)?.cgColor
        element.layer.cornerRadius = 12
        element.setTitle("Next", for: .normal)
        element.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var spaceView : UIView = {
        let element = UIView()
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
    

    var selectedCategories: Set<String> = [] 
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCategories = CategoriesSetting.shared.getSettingLoad()
        setView()
        setConstraints()
        setDelegate()
    }
    
    // MARK: - Setup Delegate
    
    private func setDelegate(){
        collectionview.dataSource = self
        collectionview.delegate = self
    }
    
    // MARK: - Public Action
    
    @objc func nextButtonPressed(_ sender: UIButton){
        
    }
    
    public func categoryChanged(category : String){
        
        selectedCategories = CategoriesSetting.shared.getSettingLoad()
        
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
        // MARK: - Save Categories Settings
        CategoriesSetting.shared.saveSettings(selectedCategories)
        
        // MARK: - Refresh CollectionView
        for i in 0...categories.count-1 {
            if let cell = self.collectionview.cellForItem(at: NSIndexPath(row: i, section: 0) as IndexPath) as? CategoryCollectionViewCell {
                cell.button.backgroundColor = selectedCategories.contains(cell.button.titleLabel?.text ?? "") ?  UIColor(named: K.BrandColors.purplePrimary) : .white
              
                cell.button.layer.borderColor = selectedCategories.contains(cell.button.titleLabel?.text ?? "") ?  UIColor(named: K.BrandColors.purplePrimary)?.cgColor : UIColor(named: K.BrandColors.greyLighter)?.cgColor
                
                cell.button.setTitleColor(selectedCategories.contains(cell.button.titleLabel?.text ?? "") ?  .white : UIColor(named: K.BrandColors.greyDark), for: .normal)
            }
        }
    }
    
    
    // MARK: - Set View
    
    func setView(){
        
        view.backgroundColor = .white
        labelTitle.text = "Categories"
        labelTitleDescription.text = "Thousands of articles in each category"
        
        mainStack.addArrangedSubview(labelTitle)
        mainStack.addArrangedSubview(labelTitleDescription)
        mainStack.addArrangedSubview(collectionview)
        mainStack.addArrangedSubview(nextButton)
        mainStack.addArrangedSubview(spaceView)
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
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            spaceView.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        
        //cell.isSelected = self.selectedCategories.contains(category)
        cell.button.backgroundColor = self.selectedCategories.contains(category) ?  UIColor(named: K.BrandColors.purplePrimary) : .white
        
        cell.button.layer.borderColor = self.selectedCategories.contains(category) ?  UIColor(named: K.BrandColors.purplePrimary)?.cgColor : UIColor(named: K.BrandColors.greyLighter)?.cgColor
        
        cell.button.setTitleColor(self.selectedCategories.contains(category) ?  .white : UIColor(named: K.BrandColors.greyDark), for: .normal)
                                  
        cell.button.setTitle(categories[indexPath.row], for: .normal)
        cell.delegate = self
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
        element.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Life cycle
    
    weak var delegate : CategoriesViewController?
    
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
        //Select|Unselect caterory by name
        delegate?.categoryChanged(category: sender.currentTitle!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
