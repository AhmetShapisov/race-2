import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var labels: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labels.font = UIFont(name: "Minecraft", size: 19)
    }


}
