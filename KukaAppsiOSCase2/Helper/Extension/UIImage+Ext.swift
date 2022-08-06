//
//  UIImage+Ext.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 4.08.2022.
//


import UIKit

enum Icon {
    case chevronLeft
    case chevronRight
    case changeOrder

    
    var image: UIImage {
        switch self {
            case .chevronLeft:           return UIImage(systemName: "chevron.left") ?? UIImage()
            case .chevronRight:          return UIImage(systemName: "chevron.right") ?? UIImage()
            case .changeOrder:           return UIImage(systemName: "line.3.horizontal.decrease") ?? UIImage()

        }
    }
}

