//
//  ManagerSignUpViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 17/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import Firebase
import TransitionButton
import TextFieldEffects


class ManagerSignUpViewController: UIViewController {
    
    @IBOutlet weak var btn_Register: TransitionButton!
    @IBOutlet weak var txt_Email: KaedeTextField!
    @IBOutlet weak var txt_Pass: KaedeTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("checking")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_Btn(_ button: TransitionButton) {
        btn_Register.startAnimation()

               
               if txt_Email!.text! == "" || (txt_Pass!.text == "") {
                   
                   AnimationShake()
                   
               }else{
                   
                   Auth.auth().createUser(withEmail: txt_Email.text!, password: txt_Pass.text!) { (user, error) in
                       if error != nil{
                        print("error aya he bhai================")

                           self.AnimationShake()
                        
                       }else{
                        print("error nai he bhai===============")

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

             self.btn_Register.stopAnimation(animationStyle: .shake, completion: {

                })
            })
        })

        
    }
    
    func AnimationExpand(){
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
                   backgroundQueue.async(execute: {
                       DispatchQueue.main.async(execute: { () -> Void in
                        self.btn_Register.stopAnimation(animationStyle: .expand, completion: {
                            self.performSegue(withIdentifier: "goToSubmit", sender: self)

                           })
                       })
                   })
        
    }
    
    


}
