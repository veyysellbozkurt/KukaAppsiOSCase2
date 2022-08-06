//
//  GetDiscountCell.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 6.08.2022.
//

import UIKit

import UIKit
import Kingfisher
import SnapKit

class GetDiscountCell: UICollectionViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }
    
    var product: Product! {
        didSet {
            setComponentAttributes()
        }
    }
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .normalLabel
        label.font = UIFont.systemFont(ofSize: 13.5, weight: .regular)
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .priceLabel
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private let productRationCount: UILabel = {
        let label = UILabel()
        label.textColor = .weakLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let addToCartButton: UIButton = {
       let button = UIButton()
        button.addCornerRadius(4)
        button.setTitle("Add to cart", for: .normal)
        button.backgroundColor = UIColor.appBlack
        button.tintColor = UIColor.primary
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCornerRadius(5)
        self.backgroundColor = .cellBackground
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setComponentAttributes() {
        productName.text = product.title
        productPrice.text = "\(product.price ?? 00.00) €".replacingOccurrences(of: ".", with: ",")
        productRationCount.text = "(\(product.rating?.count ?? 27))"
    }
    
    private func setupViews() {
        addSubview(productImageView)
        addSubview(productName)
        addSubview(productPrice)
        addSubview(addToCartButton)
        
        let starView = UIImageView()
        starView.image = UIImage(named: "Adsız")
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.addArrangedSubview(starView)
        stackView.addArrangedSubview(productRationCount)
        stackView.distribution = .fillProportionally
        addSubview(stackView)

        productImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.52)
            make.height.equalToSuperview().multipliedBy(0.42)
            make.top.equalTo(15)
            make.centerX.equalToSuperview()
        }
        productName.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(55)
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(20)
            make.top.equalTo(productName.snp.bottom).offset(5)
            make.left.equalTo(10)
        }
        starView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.67)
            make.height.equalToSuperview().multipliedBy(0.77)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        productRationCount.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview().multipliedBy(0.77)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        productPrice.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(30)
            make.top.equalTo(stackView.snp.bottomMargin).offset(2)
            make.centerX.equalToSuperview()
        }
        addToCartButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.86)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-8)
            make.centerX.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.productImageView.setImageWithKF(imageUrl: self.product.image!, size: self.productImageView.bounds.size)
        }
    }
}
