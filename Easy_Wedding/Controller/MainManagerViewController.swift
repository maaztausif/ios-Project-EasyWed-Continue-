//
//  MainManagerViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 17/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import TransitionButton
import PopBounceButton
import Firebase
class MainManagerViewController: UIViewController {


    
    @IBOutlet weak var btn_AddYourHall: PopBounceButton!
    @IBOutlet weak var btn_Calender: PopBounceButton!
    @IBOutlet weak var btn_Chat: PopBounceButton!
    @IBOutlet weak var btn_SignOut: TransitionButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_AddYourHall.layer.cornerRadius = 20
        btn_AddYourHall.clipsToBounds = true
        
        btn_Calender.layer.cornerRadius = 20
        btn_Calender.clipsToBounds = true
        
        btn_Chat.layer.cornerRadius = 20
        btn_Chat.clipsToBounds = true
    }
    
    @IBAction func signOut_Btn(_ sender: Any) {
        
        btn_SignOut.startAnimation()
        
        AnimationExpand()
    }
    
    
 
       
       
       
       
       func AnimationShake(){
           let qualityOfServiceClass = DispatchQoS.QoSClass.background
           let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
           sleep(3)
           
           backgroundQueue.async(execute: {

               DispatchQueue.main.async(execute: { () -> Void in

                self.btn_SignOut.stopAnimation(animationStyle: .shake, completion: {

                   })
               })
           })

           
       }
       
       func AnimationExpand(){
           let qualityOfServiceClass = DispatchQoS.QoSClass.background
           let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
           sleep(3)
           
                      backgroundQueue.async(execute: {
                          DispatchQueue.main.async(execute: { () -> Void in
                           self.btn_SignOut.stopAnimation(animationStyle: .expand, completion: {

                               let firebaseAuth = Auth.auth()
                                
                                do{
                                    try firebaseAuth.signOut()
                                   self.navigationController?.popToRootViewController(animated: true)
                                    
                                }catch let signOut as NSError{
                                    
                                    self.AnimationShake()
                                }
                               
                              })
                          })
                      })
           
       }

}
