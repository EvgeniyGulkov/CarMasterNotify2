extension UITableView {
    func scrollToBottom (animated: Bool = true) {
        let sections = self.numberOfSections
        if sections > 0 {
        let rows = self.numberOfRows(inSection: sections-1)
            if rows > 0 {
                self.scrollToRow(at: IndexPath(item: rows-1, section: sections-1),
                                 at: UITableView.ScrollPosition.bottom,
                                 animated: false)
            }
        }
    }
}
