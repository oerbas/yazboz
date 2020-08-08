//
//  ThirdViewController.swift
//  yazboz
//
//  Created by Orhan Erbas on 4.08.2020.
//  Copyright © 2020 Orhan Erbas. All rights reserved.
//

import GoogleMobileAds
import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var player1Lbl: UITextField!
    @IBOutlet weak var player2Lbl: UITextField!
    @IBOutlet weak var player3Lbl: UITextField!
    @IBOutlet weak var player4Lbl: UITextField!
    @IBOutlet weak var score1Lbl: UITextField!
    @IBOutlet weak var score2Lbl: UITextField!
    @IBOutlet weak var score3Lbl: UITextField!
    @IBOutlet weak var score4Lbl: UITextField!
    @IBOutlet weak var endScore: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultButton: UIButton!
    
    var players = [String]()
    var scores1 = [String]()
    var scores2 = [String]()
    var scores3 = [String]()
    var scores4 = [String]()
    var endScores = ""
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
        
        self.navigationItem.title = "Okey Hesapla"
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 214/255.0, green: 212/255.0, blue: 175/255.0, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        if players.count > 0 {
            resultButton.isEnabled = true
        } else {
            resultButton.isEnabled = false
        }
        
    }
    
    @objc func errorMessage(mainText: String, message: String){
        let refreshAlert = UIAlertController(title: mainText, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: { (action: UIAlertAction!) in
            self.addButton.isEnabled = true
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    @objc func checkNull(){
        if let player1 = player1Lbl.text {
            if player1 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 1.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player2 = player2Lbl.text {
            if player2 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 2.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player3 = player3Lbl.text {
            if player3 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 3.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player4 = player4Lbl.text {
            if player4 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 4.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        
        if let score1 = score1Lbl.text {
            if score1 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 1.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score2 = score2Lbl.text {
            if score2 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 2.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score3 = score3Lbl.text {
            if score3 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 3.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score4 = score4Lbl.text {
            if score4 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 4.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        
        if let endScore = endScore.text {
            if endScore == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen Oyun Bitiş Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func getData(){
        let storedScores1 = UserDefaults.standard.object(forKey: "storedScores3_1")
        if let storedScore1 = storedScores1 as? Array<Any> {
            scores1.removeAll(keepingCapacity: false)
            for res in storedScore1 {
                scores1.append(res as! String)
            }
        }
        
        let storedScores2 = UserDefaults.standard.object(forKey: "storedScores3_2")
        if let storedScore2 = storedScores2 as? Array<Any> {
            scores2.removeAll(keepingCapacity: false)
            for res in storedScore2 {
                scores2.append(res as! String)
            }
        }
        
        let storedScores3 = UserDefaults.standard.object(forKey: "storedScores3_3")
        if let storedScore3 = storedScores3 as? Array<Any> {
            scores3.removeAll(keepingCapacity: false)
            for res in storedScore3 {
                scores3.append(res as! String)
            }
        }
        
        let storedScores4 = UserDefaults.standard.object(forKey: "storedScores3_4")
        if let storedScore4 = storedScores4 as? Array<Any> {
            scores4.removeAll(keepingCapacity: false)
            for res in storedScore4 {
                scores4.append(res as! String)
            }
        }
        
        let storedPlayers = UserDefaults.standard.object(forKey: "storedPlayers3")
            
        if let storedPlayer = storedPlayers as? Array<Any> {
            players.removeAll(keepingCapacity: false)
            for item in storedPlayer {
                players.append(item as! String)
            }
            player1Lbl.text = storedPlayer[0] as? String
            player2Lbl.text = storedPlayer[1] as? String
            player3Lbl.text = storedPlayer[2] as? String
            player4Lbl.text = storedPlayer[3] as? String
        }
        
        let storedEndScores = UserDefaults.standard.object(forKey: "storedEndScores")
        endScore.text = storedEndScores as? String
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult3VC"{
            let destinationVC = segue.destination as! ThirdResultViewController
            destinationVC.resPlayers = players
            destinationVC.resScores1 = scores1
            destinationVC.resScores2 = scores2
            destinationVC.resScores3 = scores3
            destinationVC.resScores4 = scores4
        }
    }
    
    @IBAction func showResult(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
    
    @IBAction func addScore(_ sender: Any) {
        if (player1Lbl.text == "" || player2Lbl.text == "" || player3Lbl.text == "" || player4Lbl.text == "" || score1Lbl.text == "" || score2Lbl.text == "" || score3Lbl.text == "" || score4Lbl.text == "" || endScore.text == "") {
            checkNull()
        } else {
            players.append(player1Lbl.text!)
            players.append(player2Lbl.text!)
            players.append(player3Lbl.text!)
            players.append(player4Lbl.text!)
            
            scores1.append(score1Lbl.text!)
            scores2.append(score2Lbl.text!)
            scores3.append(score3Lbl.text!)
            scores4.append(score4Lbl.text!)
            
            player1Lbl.text = players[0]
            player2Lbl.text = players[1]
            player3Lbl.text = players[2]
            player4Lbl.text = players[3]
            
            endScores = endScore.text!
            
            UserDefaults.standard.set(players, forKey: "storedPlayers3")
            
            UserDefaults.standard.set(scores1, forKey: "storedScores3_1")
            UserDefaults.standard.set(scores2, forKey: "storedScores3_2")
            UserDefaults.standard.set(scores3, forKey: "storedScores3_3")
            UserDefaults.standard.set(scores4, forKey: "storedScores3_4")
            
            UserDefaults.standard.set(endScores, forKey: "storedEndScores")
            
            getData()
            self.tableView.reloadData()
            resultButton.isEnabled = true
            
            var scoreTop1 = 0
            for item in scores1 {
                scoreTop1 += Int(item)!
                if scoreTop1 == Int(endScore.text!) {
                    performSegue(withIdentifier: "showResult3VC", sender: nil)
                }
            }
            
            var scoreTop2 = 0
            for item in scores2 {
                scoreTop2 += Int(item)!
                if scoreTop2 == Int(endScore.text!) {
                    performSegue(withIdentifier: "showResult3VC", sender: nil)
                }
            }
            
            var scoreTop3 = 0
            for item in scores3 {
                scoreTop3 += Int(item)!
                if scoreTop3 == Int(endScore.text!) {
                    performSegue(withIdentifier: "showResult3VC", sender: nil)
                }
            }
            
            var scoreTop4 = 0
            for item in scores4 {
                scoreTop4 += Int(item)!
                if scoreTop4 == Int(endScore.text!) {
                    performSegue(withIdentifier: "showResult3VC", sender: nil)
                }
            }
        }
    }
    
    @IBAction func deleteGame(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Oyun Silinecek!", message: "Tüm oyun puanlarınız silinecek eminmisiniz?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { (action: UIAlertAction!) in
            self.deleteGame()
        }))

        refreshAlert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: { (action: UIAlertAction!) in
            self.tableView.reloadData()
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    @objc func deleteGame(){
        players.removeAll(keepingCapacity: false)
        scores1.removeAll(keepingCapacity: false)
        scores2.removeAll(keepingCapacity: false)
        scores3.removeAll(keepingCapacity: false)
        scores4.removeAll(keepingCapacity: false)
        endScores = ""
        UserDefaults.standard.removeObject(forKey: "storedPlayers3")
        resultButton.isEnabled = false

        deleteScores()

        player1Lbl.text = ""
        player2Lbl.text = ""
        player3Lbl.text = ""
        player4Lbl.text = ""
        
        score1Lbl.text = ""
        score2Lbl.text = ""
        score3Lbl.text = ""
        score4Lbl.text = ""
        endScore.text  = ""
        
        self.tableView.reloadData()
    }
    
    @objc func deleteScores(){
        UserDefaults.standard.removeObject(forKey: "storedScores3_1")
        UserDefaults.standard.removeObject(forKey: "storedScores3_2")
        UserDefaults.standard.removeObject(forKey: "storedScores3_3")
        UserDefaults.standard.removeObject(forKey: "storedScores3_4")
        UserDefaults.standard.removeObject(forKey: "storedEndScores")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableView3") as! CustomTableViewCell
        cell.counterLbl.text = "\(indexPath.row+1)"
        
        cell.user1Lbl.text = scores1[indexPath.row]
        cell.user2Lbl.text = scores2[indexPath.row]
        cell.user3Lbl.text = scores3[indexPath.row]
        cell.user4Lbl.text = scores4[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scores1.remove(at: indexPath.row)
            scores2.remove(at: indexPath.row)
            scores3.remove(at: indexPath.row)
            scores4.remove(at: indexPath.row)
            
            deleteScores()
            
            UserDefaults.standard.set(scores1, forKey: "storedScores3_1")
            UserDefaults.standard.set(scores2, forKey: "storedScores3_2")
            UserDefaults.standard.set(scores3, forKey: "storedScores3_3")
            UserDefaults.standard.set(scores4, forKey: "storedScores3_4")
            
            self.tableView.reloadData()
        }
    }
    
}
