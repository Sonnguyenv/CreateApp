

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgeNews: UIImageView!
    @IBOutlet weak var titleLableNews: UILabel!
    @IBOutlet weak var dateLableNews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
