

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgeView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
