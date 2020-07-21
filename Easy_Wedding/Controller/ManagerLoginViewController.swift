//
//  ManagerLoginViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 17/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import Firebase
import TransitionButton
import TextFieldEffects

class ManagerLoginViewController: UIViewController {

    
    
    @IBOutlet weak var txt_Email: KaedeTextField!
    @IBOutlet weak var txt_Pass: KaedeTextField!
    @IBOutlet weak var btn_Login: TransitionButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func register_Btn(_ button: TransitionButton) {
        btn_Login.startAnimation()
              
              if (txt_Email.text == "")||(txt_Pass.text == ""){
                   AnimationShake()
               }else{
                   
                   Auth.auth().signIn(withEmail: txt_Email.text!, password: txt_Pass.text!) { (authResult, error) in
                       if error != nil{
                           self.AnimationShake()
                       }else{
                           self.AnimationExpand()
                       }
                   }
                   
               }
    }
    



    
    
    func AnimationShake(){
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
        
        backgroundQueue.async(execute: {

            DispatchQueue.main.async(execute: { () -> Void in

             self.btn_Login.stopAnimation(animationStyle: .shake, completion: {

                })
            })
        })

        
    }
    
    func AnimationExpand(){
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
                   backgroundQueue.async(execute: {
                       DispatchQueue.main.async(execute: { () -> Void in
                        self.btn_Login.stopAnimation(animationStyle: .expand, completion: {
                            self.performSegue(withIdentifier: "goToSubmit", sender: self)

                           })
                       })
                   })
        
    }

    

}
