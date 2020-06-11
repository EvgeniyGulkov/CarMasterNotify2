class OrderTableCell: BaseDarkTableViewCell {
    @IBOutlet weak var vinNumber: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var plateNumber: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var carLogo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        let image = UIImage(named: "Volvo")?.scaleToSize(scaledToSize: carLogo.frame.size)
        carLogo.image = image
    }

}
