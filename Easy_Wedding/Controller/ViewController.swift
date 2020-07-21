//
//  ViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 17/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import Firebase
import PopBounceButton

class ViewController: UIViewController {
    


    @IBOutlet weak var image_Background: UIImageView!
    @IBOutlet weak var btn_signUp_Manager: PopBounceButton!
    @IBOutlet weak var btn_signUp_User: PopBounceButton!
    @IBOutlet weak var btn_Login: PopBounceButton!
    
    var images = ["1","2","3","4"]
    var i = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(imageChange), userInfo: nil, repeats: true)

        //Mark: butoon curve
                
                btn_signUp_Manager.layer.cornerRadius = 20
                btn_signUp_Manager.clipsToBounds = true
                
                btn_signUp_User.layer.cornerRadius = 20
                btn_signUp_User.clipsToBounds = true
                
                btn_Login.layer.cornerRadius = 20
                btn_Login.clipsToBounds = true
    }

     @objc func imageChange(){
     //   self.image_Background.image = images[i]
            image_Background.image = UIImage.init(named: images[i])

        if i<images.count-1{
            i+=1
        }
        else{
            i=0
        }

    }

}

