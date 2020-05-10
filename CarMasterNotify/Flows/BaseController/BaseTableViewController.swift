//
//  BaseTableViewController.swift
//  CarMasterNotify
//
//  Created by Gulkov on 09.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = Theme.Color.background
        tableView.backgroundView = view
        tableView.backgroundColor = UIColor.clear
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.textColor = Theme.Color.defaultTextColor
    }
}
