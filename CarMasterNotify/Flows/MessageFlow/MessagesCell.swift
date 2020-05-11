import UIKit
import RxSwift

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var authorTextHeight: NSLayoutConstraint!
    
    private (set) var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.messageView.layer.cornerRadius = 8.0
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
