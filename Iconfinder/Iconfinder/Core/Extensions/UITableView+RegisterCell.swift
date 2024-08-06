//
//  UITableView+RegisterCell.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

protocol ReusableCellIdentifiable {
    static var cellIdentifier: String { get }
}

protocol ReusableHeaderFooterCellIdentifiable: AnyObject {
    static var cellIdentifier: String { get }
}

extension UITableView {

    func cell<T: ReusableCellIdentifiable>(forRowAt indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as? T
    }

    func cell<T: ReusableCellIdentifiable>(forClass cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: T.cellIdentifier) as? T
    }

    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: cellClass.cellIdentifier)
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ forHeaderFooter: T.Type) {
        register(forHeaderFooter.self, forHeaderFooterViewReuseIdentifier: forHeaderFooter.description())
    }

    func dequeHeaderFooter<T: UITableViewHeaderFooterView>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.description()) as? T
    }

}

extension UITableViewCell: ReusableCellIdentifiable { }

extension UITableViewHeaderFooterView: ReusableHeaderFooterCellIdentifiable {}

extension ReusableCellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension ReusableHeaderFooterCellIdentifiable where Self: UITableViewHeaderFooterView {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
