//
//  CategoryCell.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//

import UIKit
import SnapKit

class CategoryCell: UITableViewCell {

    class var identifier: String {
        return String(describing: self)
    }
    
    private let categoryNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .normalLabel
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .cellBackground
        accessoryType = .disclosureIndicator
        separatorInset = .zero
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = .cellSelectionTint
        } else {
            self.backgroundColor = .cellBackground
        }
    }
    
    func setComponentValues(name: String) {
        categoryNameLabel.text = name.capitalized
    }
    
    private func setupViews() {
        addSubview(categoryNameLabel)
        categoryNameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview()
            make.left.equalToSuperview().offset(25)
        }
    }
}
