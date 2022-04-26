//
//  FavouriteTableViewCell.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-18.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
