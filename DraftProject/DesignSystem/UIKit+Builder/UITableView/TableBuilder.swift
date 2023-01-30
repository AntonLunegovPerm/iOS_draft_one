//
//  TableBuilder.swift
//  vtb_lising
//
//  Created by Muhammadiyor Rasulov on 09/03/22.
//

import UIKit

class TableBuilder: TableBuilderType {
    
    private var tableView: UITableView
    
    init(_ tableView: UITableView = UITableView()) {
        self.tableView = tableView
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        TableBuilder() as! Self
    }
    
    func build() -> UITableView {
        tableView
    }
    
    // MARK: - UIViewBuilderType
    func useAutoLayout() -> Self {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setBackgroundColor(_ color: UIColor?) -> Self {
        tableView.backgroundColor = color
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = radius
        return self
    }
    
    func setBorder(width: CGFloat, color: UIColor) -> Self {
        tableView.layer.borderWidth = width
        tableView.layer.borderColor = color.cgColor
        return self
    }
    
    // MARK: - TableBuilderType
    func setSeporator(style: UITableViewCell.SeparatorStyle,
                      _ color: UIColor? = nil,
                      _ insets: UIEdgeInsets? = nil) -> Self {
        tableView.separatorStyle = style
        
        if let color = color {
            tableView.separatorColor = color
        }
        
        if let insets = insets {
            tableView.separatorInset = insets
        }
        return self
    }
    
    func subscribeToDelegate(_ delegate: UITableViewDelegate) -> Self {
        tableView.delegate = delegate
        return self
    }
    
    func subscribeToDataSource(_ dataSource: UITableViewDataSource) -> Self {
        tableView.dataSource = dataSource
        return self
    }
    
    func setRowHeight(_ height: CGFloat) -> Self {
        tableView.rowHeight = height
        return self
    }
    
    func setTableViewStyle(_ style: UITableView.Style) -> Self {
        tableView = UITableView(frame: .zero, style: style)
        return self
    }
    
    func setHeaderSectionPadding(_ padding: CGFloat) -> Self {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = padding
        }
        return self
    }
    
    func setRefreshControl(_ any: Any, _ selector: Selector, _ event: UIControl.Event) -> Self {
//        let refreshControl = VTBRefreshControl()
//        tableView.refreshControl = refreshControl
//        tableView.refreshControl?.addTarget(any, action: selector, for: event)
//        tableView.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
        return self
    }
}
