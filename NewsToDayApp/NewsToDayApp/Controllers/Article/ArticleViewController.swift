//
//  Article.swift
//  NewsToDayApp
//
//  Created by Сергей Сухарев on 23.10.2024.
//

import UIKit
import Kingfisher

final class ArticleViewController: UIViewController {
    
    let article: Article
    let navigationBar = CustomNavigationBar()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let imageView = UIImageView()
    let labelTitle = UILabel()
    let labelDescription = UILabel()
    let labelAuthor = UILabel()
    let textView = UITextView()
    let buttonBack = UIButton()
    let buttonBookmark = UIButton()
    let buttonShared = UIButton()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(article)
        setupNavBar()
        setupView()
        setupConstraints()
        configuration()
    }
 
    private func setupView() {
//        view.addSubview(scrollView)
        view.addSubview(imageView)
        view.addSubview(buttonShared)
        view.addSubview(labelTitle)
        view.addSubview(labelDescription)
        view.addSubview(labelAuthor)
        view.addSubview(textView)
        
//        scrollView.addSubview(stackView)
//        stackView.addArrangedSubview(textView)
        
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: buttonBack)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonBookmark)
    }
    private func configuration() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        setupImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonBack.setImage(UIImage.backButtonNavBar, for: .normal)
        buttonBack.addTarget(self, action: #selector (backButtonTapped), for: .touchUpInside)
        
        buttonBookmark.setImage(UIImage.bookmarkNavBar, for: .normal)
        buttonBookmark.addTarget(self, action: #selector (sharedTapped), for: .touchUpInside)
        
        buttonShared.setImage(UIImage.share, for: .normal)
        buttonShared.addTarget(self, action: #selector (sharedTapped), for: .touchUpInside)
        buttonShared.translatesAutoresizingMaskIntoConstraints = false
        
        labelTitle.font = .systemFont(ofSize: 12, weight: .semibold)
        labelTitle.textColor = .white
        labelTitle.backgroundColor = .red
        labelTitle.layer.cornerRadius = 16
        labelTitle.textAlignment = .center
        labelTitle.sizeToFit()
        labelTitle.clipsToBounds = true
        //let atributesString = NSAttributedString()
        labelTitle.text = ("  \(article.source.name)             ")
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        
        labelDescription.font = .systemFont(ofSize: 20, weight: .bold)
        labelDescription.textColor = .white
//        labelDescription.backgroundColor = .red
        //labelDescription.layer.cornerRadius = 16
        labelDescription.textAlignment = .left
        labelDescription.numberOfLines = 4
        labelDescription.clipsToBounds = true
        labelDescription.sizeToFit()
        labelDescription.text = article.description
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        
        //labelAuthor.font = .systemFont(ofSize: 16, weight: .semibold)
        labelAuthor.textColor = .white
        labelAuthor.numberOfLines = 0
        //labelAuthor.backgroundColor = .red
        //labelAuthor.layer.cornerRadius = 16
        labelAuthor.sizeToFit()
        labelAuthor.textAlignment = .left
        labelAuthor.clipsToBounds = true
        let nameAuthor = article.author ?? "No Author"
        let autor = "Author"
//        labelAuthor.text = "autor"
        let attributes1 = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)
                ]
        let attributedText1 = NSMutableAttributedString(string: nameAuthor, attributes: attributes1)

        let attributes2 = [
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)
                ]
        let attributedText2 = NSMutableAttributedString(string: autor, attributes: attributes2)

        let combinedAttributedString = NSMutableAttributedString()
                combinedAttributedString.append(attributedText1)
                combinedAttributedString.append(NSAttributedString(string: "\n"))
                combinedAttributedString.append(attributedText2)

        labelAuthor.attributedText = combinedAttributedString
        labelAuthor.translatesAutoresizingMaskIntoConstraints = false
        
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .black
        textView.setContentHuggingPriority(.required, for: .vertical)
        textView.textAlignment = .justified
//        textView.clipsToBounds = false
        textView.showsVerticalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = article.content ?? "No content"
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func sharedTapped() {
        print("sharedTapped")
    }
    func setupImage() {
        let imageURL = URL(string: article.urlToImage ?? "")
        imageView.kf.indicatorType = .activity
        let placeholderImage = UIImage(named: "image")
        imageView.kf.setImage(
            with: imageURL,
            options: [
                KingfisherOptionsInfoItem
                    .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                    self.imageView.image = placeholderImage
                }
            }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
//            imageView.heightAnchor.constraint(equalToConstant: 384),
//            imageView.widthAnchor.constraint(equalToConstant: 374),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2.2),
            //imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, constant: 368),
//            buttonShared.heightAnchor.constraint(equalToConstant: 24),
//            buttonShared.widthAnchor.constraint(equalToConstant: 24),
            buttonShared.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            buttonShared.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            
            labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelTitle.heightAnchor.constraint(equalToConstant: 32),
            //labelTitle.widthAnchor.constraint(equalToConstant: 75),
            
            labelDescription.bottomAnchor.constraint(equalTo: labelAuthor.topAnchor, constant: -16),
            labelDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            labelDescription.heightAnchor.constraint(equalToConstant: 56),
//            labelDescription.widthAnchor.constraint(equalToConstant: 336),
            
            labelAuthor.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: -24),
            labelAuthor.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            labelAuthor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelAuthor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            labelAuthor.heightAnchor.constraint(equalToConstant: 32),
//            labelAuthor.widthAnchor.constraint(equalToConstant: 75),

            
            
            
//            buttonShared.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
//            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
          
            //textView.widthAnchor.constraint(equalToConstant: 500),
            //textView.heightAnchor.constraint(equalToConstant: 1000)
            
        ])
    }
    
}

@available(iOS 18.0, *)
#Preview { UINavigationController(rootViewController: ArticleViewController(article: .init(source: .init(id: "", name: ""), author: "World", title: "Hello", description: "adsd,/nfkelwnfjnbwejknfjkn dksalkfnaklsndfklnsadklnfkansaskf/n dklnsadklnfklds\n\nanlkfnklasdnf", url: "", urlToImage: "", publishedAt: "", content: "dsfsdfssfd ajknsjdfnklsndlf\nlsdflknl\nksddsfksdfak\nsdfsda\nfsdafasfsadfsaf\nsdfsdfasdfsadfsdfdwsf\nfsdfsafsadfdfdsn\n\n\\nasdak\n\nsdnaklf\n\n\n\n\n\nnkjdsnjkfnkjsanfjknsdjkbfjkbhwjqevfuyvwessdada\n\n\nsmfnmsakd mds f sm fm sdfs mf, dm fma ,m sdmf s ,f ,m\ns dfm sm df,\nm sdm fm sdm f,ms df sd, fm sdm, f")))}
