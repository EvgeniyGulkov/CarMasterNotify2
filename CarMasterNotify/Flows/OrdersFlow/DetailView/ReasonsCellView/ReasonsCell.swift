import UIKit
import RxSwift

class ReasonsCell:UITableViewCell {
    private (set) var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
