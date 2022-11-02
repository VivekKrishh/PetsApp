//
//  PetsListTableCell.swift
//  PetsApp_Vivek
//


import UIKit
import Kingfisher

class PetsListTableCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var dateAddedLabel: UILabel!
    
    //MARK: Configure Cell
    func configureCellWith(model: Pet?) {
        self.petNameLabel.text = model?.title ?? ""
        self.petImageView.kf.setImage(with: URL(string: model?.imageURL ?? ""), placeholder: UIImage(named: Constants.ImageNames.noimage), options: nil, progressBlock: nil, completionHandler: nil)
        self.dateAddedLabel.text = getDateTime(timeStamp: model?.dateAdded ?? "") //Todo : convert date to format
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
