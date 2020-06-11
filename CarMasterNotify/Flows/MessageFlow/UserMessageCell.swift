import UIKit
import RxSwift

class UserMessageCell: UITableViewCell {

    @IBOutlet weak var progressBar: CircularProgressBar!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageText: UILabel!

    @IBOutlet weak var errorImage: UIImageView!
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
