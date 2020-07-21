//
//  ManagerGetHallViewController.swift
//  Easy_Wedding
//
//  Created by maaz bin tausif on 20/07/2020.
//  Copyright © 2020 maaz bin tausif. All rights reserved.
//

import UIKit
import Firebase


class ManagerGetHallViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var hallTableView: UITableView!
    var hallArray = [HallInfo]()
    let db = Firestore.firestore()
    var auth = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hallTableView.delegate = self
        hallTableView.dataSource = self
//        hallTableView.separatorStyle = .none
        
        retrieveData()
        
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
        print("cell he ye ======= \(hallArray[indexPath.row].hall_Name)--")
        print("hall name of hall array = \(hallArray[0].hall_Name)=============")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HallInfoTableViewCell

        print("\(cell.lbl_HallName.text)========select row at")
    }
    
    func retrieveData(){
        print("retrieve data =============")
        let hallInfo = HallInfo()
        let docRef = db.collection("user:\(auth)").document("grace")

        DispatchQueue.global(qos:.userInteractive).sync {
                    docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    hallInfo.hall_Name = document["Hall Name"] as! String
                    hallInfo.no_Of_People = document["No Of People"] as! String
                    hallInfo.rupees = document["Phone No"] as! String
                    print("Document data: \(dataDescription)")
                    print("\(hallInfo.hall_Name)===================")
                    self.hallArray.append(hallInfo)
                    print("hall name of hall array = \(self.hallArray[0].hall_Name)=============")
                    self.hallTableView.reloadData()

                } else {
                    print("Document does not exist")
                }
            }
        }
        

//        self.hallArray.append(hallInfo)
//        print("hall name of hall array = \(hallArray[0].hall_Name)=============")
//        self.hallTableView.reloadData()
    }

}
