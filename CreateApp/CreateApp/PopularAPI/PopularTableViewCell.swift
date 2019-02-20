
import UIKit

class PopularTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLablePopular: UILabel!
    @IBOutlet weak var imgPopular: UIImageView!
    @IBOutlet weak var descriptionRaw: UILabel!
    @IBOutlet weak var startDateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
