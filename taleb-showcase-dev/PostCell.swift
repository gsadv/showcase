//
//  PostCell.swift
//  taleb-showcase-dev
//
//  Created by Hassan Ait-Taleb on 18-10-16.
//  Copyright © 2016 Hassan Ait-Taleb. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var showCaseImage: UIImageView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configureCell(postIn: Post){
        self.post = postIn
        self.descriptionText.text = postIn.postDescription
        self.likesLbl.text = "\(postIn.likes)"
    }
    
}
