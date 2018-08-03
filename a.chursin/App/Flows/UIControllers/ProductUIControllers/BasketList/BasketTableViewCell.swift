import UIKit

class BasketTableViewCell: UITableViewCell
{
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productButton: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
