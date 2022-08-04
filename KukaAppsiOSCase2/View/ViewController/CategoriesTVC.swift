//
//  CategoriesTVCTableViewController.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit
import Alamofire

class CategoriesTVC: UITableViewController {
    
    let categoryVM = CategoryViewModel()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primary
        self.navigationItem.title = "Categories"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.navigationLargeTitle,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30, weight: .medium)]
        setupTableView()
        fetchData()
    }
    
    private func fetchData() {
        self.tableView.showActivityIndicator()
        categoryVM.fetchCategories { isFetched in
            self.tableView.hideActivityIndicator()
            if isFetched {
                self.tableView.reloadData()
            } else {
                self.showAlert(title: "Error", message: "There was an error!!")
            }
        }
    }
    
    private func setupTableView() {
        tableView.separatorColor = .tableViewSeparator
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryVM.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else { fatalError() }
        cell.setComponentValues(name: categoryVM.categories[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
