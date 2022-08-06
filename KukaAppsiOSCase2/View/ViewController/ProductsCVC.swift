//
//  CategoryDetailTVC.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit

class ProductsCVC: UICollectionViewController {
    
    var selectedCategoryName: String?
    let productsVM = ProductViewModel()
    
    init(layout: UICollectionViewFlowLayout, categoryName: String) {
        super.init(collectionViewLayout: layout)
        self.selectedCategoryName = categoryName
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .primary
        
        setupCollectionView()
        fetchData()
    }
    
    private func fetchData() {
        self.collectionView.showActivityIndicator()
        productsVM.fetchProducts(categoryName: selectedCategoryName!.configuredForAPICall) { isFetched in
            self.collectionView.hideActivityIndicator()
            if isFetched {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showAlert(title: "Error", message: "There was an error!!")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.23) {
            self.navigationController?.addCustomBottomLine(color: .weakLabel.withAlphaComponent(0.57), height: 0.6)
        }
        navigationItem.title = selectedCategoryName?.capitalized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Icon.changeOrder.image, style: .done, target: self, action: #selector(changeOrder))
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .appBlack
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = ""
    }

    private func setupCollectionView() {
        collectionView.register(ProductsCell.self, forCellWithReuseIdentifier: ProductsCell.identifier)
    }
    
    @objc func changeOrder() {
        self.productsVM.products.removeAll()
        self.collectionView.reloadData()
        productsVM.isAscending.toggle()
        fetchData()
    }
}

extension ProductsCVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsVM.products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCell.identifier, for: indexPath) as? ProductsCell else { fatalError() }
        cell.product = productsVM.products[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailVC()
        vc.product = productsVM.products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: deviceWidth, height: 13)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: deviceWidth, height: 15)
    }
    
}


extension ProductsCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPercent = deviceWidth - (deviceWidth * 0.051)
        return CGSize(width: widthPercent / 2.178, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 18, bottom: 5, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
