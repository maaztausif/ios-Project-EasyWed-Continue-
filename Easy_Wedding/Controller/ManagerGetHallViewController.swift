//
//  ManagerGetHallViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 20/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class ManagerGetHallViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var hallTableView: UITableView!
    var hallArray = [HallInfo]()
    let db = Firestore.firestore()
    var auth = Auth.auth().currentUser!.uid
    var databaseRef: DatabaseReference!
    var image:UIImage! = nil
    var photoArray = [UIImage]()
    var documentArray = [String]()
    var allPhotoArray = [[UIImage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        retrieveData()
        retrieveDocuments()
        retrieveImages()

        hallTableView.delegate = self
        hallTableView.dataSource = self
//        hallTableView.separatorStyle = .none

        
        
        
        hallTableView.register(UINib(nibName: "HallInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "hallCell")
        hallTableView.reloadData()
        print("(view did load) hall array count = \(hallArray.count)")
    }

//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150 //or whatever you need
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("(rows) hall array count = \(hallArray.count)")
        return hallArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hallCell", for: indexPath) as! HallInfoTableViewCell
        cell.lbl_HallName.text = hallArray[indexPath.row].hall_Name
        cell.lbl_Price.text = hallArray[indexPath.row].rupees
        cell.lbl_NoOfPeople.text = hallArray[indexPath.row].no_Of_People
        //cell.hallImage.image = image
        cell.imagesArray = photoArray
//        cell.hallImage.image = photoArray[0]
        print("cell he ye ======= \(hallArray[indexPath.row].hall_Name)--")
        print("hall name of hall array = \(hallArray[0].hall_Name)=============")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HallInfoTableViewCell

        print("\(cell.lbl_HallName.text)========select row at")
        print(" hall 1 = \(hallArray[0].hall_Name)")
        print(" hall 2 = \(hallArray[1].hall_Name)")
        print(" \(hallArray[indexPath.row].hall_Name)")
        print("hallArray =count = \(hallArray.count)")
        print(" hall 1 = \(documentArray[0])")
        print(" hall 2 = \(documentArray[1])")
        print(" hall 3 = \(documentArray[2])")
//        self.hallTableView.reloadData()

    }
    
    func retrieveData(){
        print("retrieve data =============")
        let hallInfo = HallInfo()
        var i = 0
        
        
        db.collection("user:\(auth)").getDocuments { (ducomentSnapshot, error) in
            if error != nil{
                
            }else{

//                for document in ducomentSnapshot!.documents {
//                      print("\(document.documentID) => \(document.data())")
//                    let docRef = self.db.collection("user:\(self.auth)").document("\(document.documentID)")
//                                docRef.getDocument { (document, error) in
//                            if let document = document, document.exists {
//                                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                                hallInfo.hall_Name = document["Hall Name"] as! String
//                                hallInfo.no_Of_People = document["No Of People"] as! String
//                                hallInfo.rupees = document["Phone No"] as! String
//                                print("Document data: \(dataDescription)")
//                                print("\(hallInfo.hall_Name)===================")
//                                self.hallArray.append(hallInfo)
//                                print("hall name of hall array = \(self.hallArray[0].hall_Name)=============")
//                                self.hallTableView.reloadData()
//
//                            } else {
//                                print("Document does not exist")
//                            }
//                        }
//                    print("===================================================")
//                    self.hallTableView.reloadData()
//
//                    //print("hallArray = \(self.hallArray[i])")
//                    i += 1
//                  }
                
                //check
//                for i in self.documentArray{
//
//                                        let docRef = self.db.collection("user:\(self.auth)").document("\(i)")
//                                                    docRef.getDocument { (document, error) in
//                                                if let document = document, document.exists {
//                                                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                                                    hallInfo.hall_Name = document["Hall Name"] as! String
//                                                    hallInfo.no_Of_People = document["No Of People"] as! String
//                                                    hallInfo.rupees = document["Phone No"] as! String
//                                                    print("Document data: \(dataDescription)")
//                                                    print("\(hallInfo.hall_Name)===================")
//                                                    self.hallArray.append(hallInfo)
//                                                    print("hall name of hall array = \(self.hallArray[0].hall_Name)=============")
//                                                    self.hallTableView.reloadData()
//
//                                                } else {
//                                                    print("Document does not exist")
//                                                }
//                                            }
//                }
                
            }
        }
        
//        self.hallArray.append(hallInfo)
//        print("hall name of hall array = \(hallArray[0].hall_Name)=============")
//        self.hallTableView.reloadData()
    }
    
    func retrieveDocuments(){
        
        print("retrieve Document data =============")
        
        db.collection("user:\(auth)").getDocuments { (ducomentSnapshot, error) in
                   if error != nil{
                       
                   }else{
                    
                    for document in ducomentSnapshot!.documents {
                          print("\(document.documentID) => \(document.data())")
                        self.documentArray.append(document.documentID)
                        var hallInfo = HallInfo()

//                        print("hall name=\(document["Hall Name"])!!!!!!!!!!!!!!!!!!!!!!!!!")
                        var a = document["Hall Name"] as! String
                        print("var a = \(a)!!!!!!!!!!!!!!!!!!!!!!!!!")
                        hallInfo.hall_Name = document["Hall Name"] as! String
                        hallInfo.no_Of_People = document["No Of People"] as! String
                        hallInfo.rupees = document["Phone No"] as! String
//                        print("Document data: \(dataDescription)")
                        print("\(hallInfo.hall_Name)===================")
                        self.hallArray.append(hallInfo)
                        print("hall name of hall array = \(self.hallArray[0].hall_Name)=============")
                        self.hallTableView.reloadData()

                    }
//                    self.hallTableView.reloadData()

            }
        
        }


//        self.hallTableView.reloadData()
        print("ye ab chala he reload wala--------------------")
    }
    
    func retrieveImages(){
        print("retrieve images")
        
        if documentArray.count == 0{
            
        }else{
            for var i in 0...15{
                    let storageRef = Storage.storage().reference().child("user:\(auth):\(documentArray[i])/myImage\(i)")
                            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                              if  error != nil {
                                // Uh-oh, an error occurred!
                                print("/ Uh-oh, an error occurred!")
                                i = 16
                              } else {
                                // Data for "images/island.jpg" is returned
                                self.image = UIImage(data: data!)
                                self.photoArray.append(self.image)
                                print(" i = \(i) =  =  =\(self.image?.description)=======bhai ye discription he")
                               // print("photo array \(i) = \(self.photoArray[i].description)=======bhai ye discription he")
                                self.hallTableView.reloadData()
                                
                              }
                            }


            }
            allPhotoArray.append(photoArray)

        }
        

         

          //  i = i+1

        
        

        
        
        
        
        
        
//        let dbRef =  Database.database().reference().child("user:\(auth)")
//        dbRef.observeEventType(.childAdded, withBlock: { (snapshot) in
//          // Get download URL from snapshot
//            let downloadURL = snapshot.value as! String
//          // Create a storage reference from the URL
//          let storageRef = storage.referenceFromURL(downloadURL)
//          // Download the data, assuming a max size of 1MB (you can change this as necessary)
//          storageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
//            // Create a UIImage, add it to the array
//            let pic = UIImage(data: data)
//            picArray.append(pic)
//          })
//        })
        
        // Create a reference to the file you want to download
//        let islandRef = Database.database().ref   storageRef.child("images/island.jpg")
//        let storageRef = Storage.storage().reference().child("user:\(auth)")

//        storageRef.list(withMaxResults: 1 * 1024 * 1024) { (data, error) in
//                      if  error != nil {
//                        // Uh-oh, an error occurred!
//                        print("/ Uh-oh, an error occurred!")
//                      } else {
//                        // Data for "images/island.jpg" is returned
//
//                        for item in data.items{
//                            self.image = UIImage(cgImage: item as! CGImage)
//
//                            self.photoArray.append(UIImage(cgImage: item as! CGImage))
//                            print("item = \(item)======")
//                            print("\(self.image.description) = = == = = = ")
////                            self.photoArray.append(UIImage(data: item)!)
//                        }
//
//
////                        self.image = UIImage(data: data)
////                        print("\(self.image?.description)=======bhai ye discription he")
////                        self.hallTableView.reloadData()
//                      }
//                    }
        }
        
//        storageRef.listAll { (result, error) in
//            if error != nil{
//                print("/ Uh-oh, an error occurred!")
//
//            }else{
//                for item in result.items {
//                  // The items under storageReference.
//                    self.photoArray.append(UIImage(cgImage: item as! CGImage))
//                }
//            }
//        }
//    var storageRef = firebase.storage().ref("your_folder");

//        storageRef.listAll().then(function(result) {
//          result.items.forEach(function(imageRef) {
//            // And finally display them
//            displayImage(imageRef);
//          });
//        }).catch(function(error) {
//          // Handle any errors
//        })
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//          if  error != nil {
//            // Uh-oh, an error occurred!
//            print("/ Uh-oh, an error occurred!")
//          } else {
//            // Data for "images/island.jpg" is returned
//            self.image = UIImage(data: data!)
//            print("\(self.image?.description)=======bhai ye discription he")
//            self.hallTableView.reloadData()
//          }
//        }
 
        //        let storageRef = Storage.storage().reference().child("user:\(auth)")

//        let dbRef = Storage.storage().reference().child("user:\(auth)")
//
//        dbRef.
//
//        dbRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
//          // Get download URL from snapshot
//          let downloadURL = snapshot.value() as! String
//          // Create a storage reference from the URL
//          let storageRef = storage.referenceFromURL(downloadURL)
//          // Download the data, assuming a max size of 1MB (you can change this as necessary)
//          storageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
//            // Create a UIImage, add it to the array
//            let pic = UIImage(data: data)
//            picArray.append(pic)
//          })
//        })
        
    }





