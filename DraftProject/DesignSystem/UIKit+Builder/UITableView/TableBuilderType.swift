//
//  TableBuilderType.swift
//  vtb_lising
//
//  Created by Muhammadiyor Rasulov on 09/03/22.
//

import UIKit

protocol TableBuilderType: UIViewBuilderType {
    func setSeporator(style: UITableViewCell.SeparatorStyle, _ color: UIColor?, _ insets: UIEdgeInsets?) -> Self
    func subscribeToDelegate(_ delegate: UITableViewDelegate) -> Self
    func subscribeToDataSource(_ dataSource: UITableViewDataSource) -> Self
    func setRowHeight(_ height: CGFloat) -> Self
    func setTableViewStyle(_ style: UITableView.Style) -> Self
    func setHeaderSectionPadding(_ padding: CGFloat) -> Self
    func setRefreshControl(_ any: Any, _ selector: Selector, _ event: UIControl.Event) -> Self
}
