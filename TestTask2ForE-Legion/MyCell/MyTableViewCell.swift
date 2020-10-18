//
//  MyTableViewCell.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let identifire = "MyTableViewCell"
    @IBOutlet var avatar: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.contentMode = .scaleAspectFit
        nameLbl.textColor = .gray
        distanceLbl.textColor = .gray
        // Initialization code
    }

    public func setup(name: String, distanse: String, image: String) {
        nameLbl.text = name
        distanceLbl.text = distanse
        //Cделал заглушку для аватарки, в реальном проекте обычно прилетает урл,
        //который потом нужно подгрузить асинхронно
        avatar.image = UIImage(named: "placeholder.png")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
