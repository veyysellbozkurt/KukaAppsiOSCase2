//
//  ProductDetailVC.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit
import SnapKit

class ProductDetailVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.primary
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.backgroundColor = UIColor.primary
        return stackView
    }()
    
    private lazy var productImageFloor: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.cellBackground
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appBlack
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Adsız")
        return imageView
    }()
    
    private lazy var ratingCountLabel: UILabel = {
        let label = UILabel()
        label.text = "(27)"
        label.textColor = UIColor.weakLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.priceLabel
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to cart", for: .normal)
        button.backgroundColor = UIColor.appBlack
        button.tintColor = UIColor.primary
        return button
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textColor = UIColor.appBlack
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.normalLabel
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var addAndGetLabel: UILabel = {
        let label = UILabel()
        label.text = "Add And Get Discount"
        label.textColor = UIColor.appBlack
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.primary
        return collection
    }()
    
    private var starStackView =  UIStackView()
    private var divider = UIView()
    
    var product: Product?
    var isAddedToCart = false
    var productDetailVM = ProductDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .primary
        starStackView.addArrangedSubview(starImageView)
        starStackView.addArrangedSubview(ratingCountLabel)
        starStackView.axis = .horizontal
        starStackView.spacing = 5
        starStackView.distribution = .fillProportionally
        
        divider.backgroundColor = .weakLabel.withAlphaComponent(0.4)
        divider.addCornerRadius(10)

        addToCartButton.addTarget(self, action: #selector(revertAddToCartButton), for: .touchUpInside)
        addToCartButton.addCornerRadius(4)
        
        configureSubviews()
        setupConstraints()
        setDatas()
        setupCollectionView()
        fetchDatas()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = product?.title?.capitalized ?? "WD 2TB Elements Portable"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    private func fetchDatas() {
        self.collectionView.showActivityIndicator()
        productDetailVM.fetchDiscountProducts { isFetched in
            self.collectionView.hideActivityIndicator()
            if isFetched {
                DispatchQueue.main.async {
                    print("geldi ---- ",self.productDetailVM.discountProducts)
                    print("geldi ---- ",      self.productDetailVM.products)
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(title: "Error!", message: "There was an error!")
            }
        }
    }
    
    @objc func revertAddToCartButton() {
        isAddedToCart.toggle()
        addToCartButton.backgroundColor = isAddedToCart ? .gray : .appBlack
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GetDiscountCell.self, forCellWithReuseIdentifier: GetDiscountCell.identifier)
    }
    
    private func setDatas() {
        productNameLabel.text = product?.title
        priceLabel.text = "\(product?.price ?? 00.00) €".replacingOccurrences(of: ".", with: ",")
        descriptionLabel.text = product?.productDescription
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.productImageView.setImageWithKF(imageUrl: self.product!.image!, size: self.productImageView.bounds.size)
        }
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        productImageFloor.addSubview(productImageView)
        
        
        stackView.addArrangedSubview(productImageFloor)
        stackView.addArrangedSubview(productNameLabel)
        stackView.addArrangedSubview(starStackView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(addToCartButton)
        stackView.addArrangedSubview(descriptionTitleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(addAndGetLabel)
        stackView.addArrangedSubview(collectionView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self.view)
        }
        
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.bottom.equalTo(contentView)
        }

        productImageFloor.snp.makeConstraints { make in
            make.height.equalTo(300)
            make.left.equalTo(stackView.snp.left)
            make.right.equalTo(stackView.snp.right)
            make.top.equalTo(stackView.snp.top)
            make.bottom.equalTo(stackView.snp.top).offset(300)
        }
        
        productImageView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.center.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.equalTo(stackView).offset(15)
            make.right.equalTo(stackView).offset(-15)
            make.top.equalTo(productImageView.snp.bottomMargin).offset(-10)
        }
        
        starStackView.snp.makeConstraints { make in
            make.width.equalTo(135)
            make.height.equalTo(20)
            make.left.equalTo(stackView.snp.left).offset(15)
            make.top.equalTo(productNameLabel.snp.bottom).offset(5)
        }
        
        starImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        ratingCountLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(starStackView.snp.bottom).offset(5)
        }
        
        divider.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1.5)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.left.equalTo(stackView).offset(15)
            make.right.equalTo(stackView).offset(-15)
            make.top.equalTo(divider.snp.bottomMargin).offset(5)
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(stackView).offset(15)
            make.right.equalTo(stackView).offset(-15)
            make.top.equalTo(addToCartButton.snp.bottomMargin).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(115)
            make.left.equalTo(stackView).offset(15)
            make.right.equalTo(stackView).offset(-15)
            make.top.equalTo(descriptionTitleLabel.snp.bottom)
        }
        
        addAndGetLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalTo(stackView).offset(15)
            make.right.equalTo(stackView).offset(-15)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(14)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(400)
            make.left.equalTo(stackView).offset(15)
            make.right.equalTo(stackView).offset(-15)
            make.top.equalTo(addAndGetLabel.snp.bottom).offset(5)
        }
    }
}


extension ProductDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailVM.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GetDiscountCell.identifier, for: indexPath) as? GetDiscountCell else { fatalError() }
        cell.product = productDetailVM.products[indexPath.row]
        return cell
    }
    
}

extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPercent = deviceWidth - (deviceWidth * 0.051)
        return CGSize(width: widthPercent / 2.187, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
