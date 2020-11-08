//
//  HallInfoTableViewCell.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 19/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit

class HallInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_HallName: UILabel!
    @IBOutlet weak var lbl_NoOfPeople: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var hallImage: UIImageView!
    
    var imagesArray = [UIImage]()
    var allImageArray = [[UIImage]]()
//    var image = [UIImage]()
    var images = [UIImage]()

    var i = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        allImageArray.append(imagesArray)
        var image = allImageArray[0]
        // Configure the view for the selected state
        
//                Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)
    }
     @objc func imageChange(){
     //   self.image_Background.image = images[i]
            //hallImage.image = UIImage.init(named: imagesArray[i])
        //hallImage.image = UIImage.init(cgImage: imagesArray[i] as! CGImage)
        print("cell ka imageArray count he ye     =========\(imagesArray.count)")
//        var image = allImageArray[0]
//        allImageArray.append(imagesArray)
//        var image = allImageArray[0]

//        print("image = \(image.count)")
//        print("image = \(image.description)")
        print("image array = \(allImageArray.count)")
        hallImage.image = UIImage(data: imagesArray[i].pngData()!)
        //var c = imagesArray.count
        if i<imagesArray.count-1{
            i+=1
            print("Cell Ka Print hua he ======== \(i)")
        }
        else{
            i=0
        }

    }
}
