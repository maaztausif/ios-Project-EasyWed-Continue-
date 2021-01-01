//
//  ManagerHallViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 18/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import Firebase
import ImageSlideshow
import PopBounceButton
import TextFieldEffects
import FirebaseStorage


class ManagerHallViewController: UIViewController,ImageSlideshowDelegate {

    

    @IBOutlet weak var lbl_ImageTxt: UILabel!
       
       
       var selectedAssets = [PHAsset]()
       var photoArray = [UIImage]()
       var photoName = [String]()
       var imageSource: [ImageSource] = []
       
       let db = Firestore.firestore()
       var auth  = Auth.auth().currentUser!.uid

    
    
       @IBOutlet weak var slideshow: ImageSlideshow!
    
    @IBOutlet weak var txt_HallName: HoshiTextField!
    @IBOutlet weak var txt_PhoneNo: HoshiTextField!
    @IBOutlet weak var txt_Location: HoshiTextField!
    @IBOutlet weak var txt_Email: HoshiTextField!
    @IBOutlet weak var txt_NoOfPeople: HoshiTextField!
    @IBOutlet weak var txt_Rupees: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ForImageSlideShow()

        // Do any additional setup after loading the view.
    }
    
     @objc func didTap() {
             let fullScreenController = slideshow.presentFullScreenController(from: self)
             // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
             fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
         }
        
        func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
            print("current page:", page)
            
        }
        
        
        func ForImageSlideShow(){
                
                slideshow.slideshowInterval = 5.0
                slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
                slideshow.contentScaleMode = UIViewContentMode.scaleToFill

                let pageControl = UIPageControl()
                pageControl.currentPageIndicatorTintColor = UIColor.lightGray
                pageControl.pageIndicatorTintColor = UIColor.black
                slideshow.pageIndicator = pageControl

                // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
                slideshow.activityIndicator = DefaultActivityIndicator()
                slideshow.delegate = self

        }
        
        
        
        @IBAction func addImages(_ sender: Any) {
            
            let vc = ImagePickerController()
            
            presentImagePicker(vc, animated: true, select: { (PHAsset)
                in
                
            }, deselect: { (PHAsset) in
                
            }, cancel: { ([PHAsset]) in
                
            }, finish: { (assets : [PHAsset]) in
                

                for i in 0..<assets.count{
                    self.selectedAssets.append(assets[i])
                    print("=====l=======l======\(i)")

                    
                }
                print("assets = =========\(assets)")
                self.convertAssetsToImages()
                
            }, completion: nil)
            
//            self.bs_presentImagePickerController(vc, animated: true, select: { (PHAsset)
//                in
//
//            }, deselect: { (PHAsset) in
//
//            }, cancel: { ([PHAsset]) in
//
//            }, finish: { (assets : [PHAsset]) in
//
//
//                for i in 0..<assets.count{
//                    self.selectedAssets.append(assets[i])
//                    print("=====l=======l======\(i)")
//
//
//                }
//                print("assets = =========\(assets)")
//                self.convertAssetsToImages()
//
//            }, completion: nil)
            
            
            
        }


        func convertAssetsToImages(){
            if selectedAssets.count != 0 {
                for i in 0..<selectedAssets.count{
                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    
                    option.isSynchronous = true
                    
                    manager.requestImage(for: selectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option) { (result, info) in
                        thumbnail = result!
     //                  self.imageView.image = thumbnail
                        
                        print("thumbnail =========== \(thumbnail.description)")
                        
                    }
                    
                    let data = thumbnail.jpegData(compressionQuality: 0.7)
                    
                    
                    let newImage = UIImage(data: data!)


                    self.photoArray.append(newImage! as UIImage)
                
               
                    
                }
                
                for image in self.photoArray {
                    let img = image
                    imageSource.append(ImageSource(image:  img))
                }
                
                
                
                
                lbl_ImageTxt.isHidden = true
                self.slideshow.setImageInputs(imageSource)

                    
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(ManagerHallViewController.didTap))
                slideshow.addGestureRecognizer(recognizer)

            }

        }
    
    //MARK: SAVE image And hall info in firebase
        
        @IBAction func SaveIntoDatabase(_ sender: Any) {
            
            if (txt_PhoneNo.text! == "")||(txt_HallName.text! == "")||(txt_Email.text! == "")||(txt_Location.text! == "")||(txt_NoOfPeople.text! == "")||(txt_Rupees.text! == "")||(photoArray.count == 0){
                
                print("Some Thing is Nill====================//")
                
            }else{
            
            var i = 0

            db.collection("user:\(auth)").document("\(txt_HallName.text!)").setData(["Hall Name":txt_HallName.text!,"Location":txt_Location.text!,"Email":txt_Email.text!,"No Of People":txt_NoOfPeople.text!,"Rupees":txt_Rupees.text!,"Phone No":txt_PhoneNo.text!]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    
                }
            }
            

            
            for image in photoArray{
                
                let storageRef = Storage.storage().reference().child("user:\(auth):\(txt_HallName.text!)/myImage\(i)")
                if let uploadData = image.pngData() {

                    storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                        if error != nil {
                            print("error")
                            
                        } else {
                            // your uploaded photo url.
                        }
                   }
                }
                i = i+1
            }
            

            }
            
        }
}


