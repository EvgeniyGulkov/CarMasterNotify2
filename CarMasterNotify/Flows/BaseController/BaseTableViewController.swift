//
//  BaseTableViewController.swift
//  CarMasterNotify
//
//  Created by Gulkov on 09.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

class BaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = Theme.Color.background
        tableView.backgroundView = view
        tableView.backgroundColor = Theme.Color.background
        tableView.dataSource = nil
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.textColor = Theme.Color.defaultTextColor
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header: UITableViewHeaderFooterView = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = Theme.Color.blueColor
        let controllerName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
        if let text = header.textLabel?.text {
            header.textLabel?.text = NSLocalizedString(text, tableName: controllerName, comment: "")
        }
    }
}
