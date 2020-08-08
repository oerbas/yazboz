//
//  FirstViewController.swift
//  yazboz
//
//  Created by Orhan Erbas on 19.07.2020.
//  Copyright © 2020 Orhan Erbas. All rights reserved.
//

import GoogleMobileAds
import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var player1: UITextField!
    @IBOutlet weak var player2: UITextField!
    @IBOutlet weak var player3: UITextField!
    @IBOutlet weak var player4: UITextField!
    
    @IBOutlet weak var player1Score: UITextField!
    @IBOutlet weak var player2Score: UITextField!
    @IBOutlet weak var player3Score: UITextField!
    @IBOutlet weak var player4Score: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var players = [String]()
    var scores1 = [String]()
    var scores2 = [String]()
    var scores3 = [String]()
    var scores4 = [String]()
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
        
        self.navigationItem.title = "101 Hesapla"
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
        if let player1 = player1.text {
            if player1 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 1.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player2 = player2.text {
            if player2 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 2.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player3 = player3.text {
            if player3 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 3.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player4 = player4.text {
            if player4 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 4.Oyuncu İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        
        if let score1 = player1Score.text {
            if score1 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 1.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score2 = player2Score.text {
            if score2 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 2.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score3 = player3Score.text {
            if score3 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 3.Oyuncu Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score4 = player4Score.text {
            if score4 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 4.Oyuncu Puanını Giriniz!")
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
        let storedScores1 = UserDefaults.standard.object(forKey: "storedScores1")
        if let storedScore1 = storedScores1 as? Array<Any> {
            scores1.removeAll(keepingCapacity: false)
            for res in storedScore1 {
                scores1.append(res as! String)
            }
        }
        
        let storedScores2 = UserDefaults.standard.object(forKey: "storedScores2")
        if let storedScore2 = storedScores2 as? Array<Any> {
            scores2.removeAll(keepingCapacity: false)
            for res in storedScore2 {
                scores2.append(res as! String)
            }
        }
        
        let storedScores3 = UserDefaults.standard.object(forKey: "storedScores3")
        if let storedScore3 = storedScores3 as? Array<Any> {
            scores3.removeAll(keepingCapacity: false)
            for res in storedScore3 {
                scores3.append(res as! String)
            }
        }
        
        let storedScores4 = UserDefaults.standard.object(forKey: "storedScores4")
        if let storedScore4 = storedScores4 as? Array<Any> {
            scores4.removeAll(keepingCapacity: false)
            for res in storedScore4 {
                scores4.append(res as! String)
            }
        }
        
        let storedPlayers = UserDefaults.standard.object(forKey: "storedPlayers")
            
        if let storedPlayer = storedPlayers as? Array<Any> {
            players.removeAll(keepingCapacity: false)
            for item in storedPlayer {
                players.append(item as! String)
            }
            player1.text = storedPlayer[0] as? String
            player2.text = storedPlayer[1] as? String
            player3.text = storedPlayer[2] as? String
            player4.text = storedPlayer[3] as? String
        }
    }
    
    @IBAction func addScore(_ sender: Any) {
        if (player1.text == "" || player2.text == "" || player3.text == "" || player4.text == "" || player1Score.text == "" || player2Score.text == "" || player3Score.text == "" || player4Score.text == "") {
            checkNull()
        } else {
            players.append(player1.text!)
            players.append(player2.text!)
            players.append(player3.text!)
            players.append(player4.text!)
            
            scores1.append(player1Score.text!)
            scores2.append(player2Score.text!)
            scores3.append(player3Score.text!)
            scores4.append(player4Score.text!)
            
            player1.text = players[0]
            player2.text = players[1]
            player3.text = players[2]
            player4.text = players[3]
            
            UserDefaults.standard.set(players, forKey: "storedPlayers")
            
            UserDefaults.standard.set(scores1, forKey: "storedScores1")
            UserDefaults.standard.set(scores2, forKey: "storedScores2")
            UserDefaults.standard.set(scores3, forKey: "storedScores3")
            UserDefaults.standard.set(scores4, forKey: "storedScores4")
            resultButton.isEnabled = true
            
            getData()
            self.tableView.reloadData()
            addButton.isEnabled = true
        }
    }
    
    @IBAction func deleteData(_ sender: Any) {
        
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
        UserDefaults.standard.removeObject(forKey: "storedPlayers")
        resultButton.isEnabled = false
        
        deleteScores()

        player1.text = ""
        player2.text = ""
        player3.text = ""
        player4.text = ""
        
        player1Score.text = ""
        player2Score.text = ""
        player3Score.text = ""
        player4Score.text = ""
        
        self.tableView.reloadData()
    }
    
    @objc func deleteScores(){
        UserDefaults.standard.removeObject(forKey: "storedScores1")
        UserDefaults.standard.removeObject(forKey: "storedScores2")
        UserDefaults.standard.removeObject(forKey: "storedScores3")
        UserDefaults.standard.removeObject(forKey: "storedScores4")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableView1") as! CustomTableViewCell
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
            
            UserDefaults.standard.set(scores1, forKey: "storedScores1")
            UserDefaults.standard.set(scores2, forKey: "storedScores2")
            UserDefaults.standard.set(scores3, forKey: "storedScores3")
            UserDefaults.standard.set(scores4, forKey: "storedScores4")
            
            
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultVC"{
            let destinationVC = segue.destination as! ResultViewController
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
}
