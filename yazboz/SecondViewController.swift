//
//  SecondViewController.swift
//  yazboz
//
//  Created by Orhan Erbas on 3.08.2020.
//  Copyright © 2020 Orhan Erbas. All rights reserved.
//

import GoogleMobileAds
import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var player1: UITextField!
    @IBOutlet weak var player2: UITextField!
    @IBOutlet weak var score1: UITextField!
    @IBOutlet weak var score2: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var players = [String]()
    var scores1 = [String]()
    var scores2 = [String]()
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
        
        self.navigationItem.title = "Eşli 101 Hesapla"
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
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 1.Takım İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let player2 = player2.text {
            if player2 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 2.Takım İsmini Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        
        if let score1 = score1.text {
            if score1 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 1.Takım Puanını Giriniz!")
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
        if let score2 = score2.text {
            if score2 == "" {
               errorMessage(mainText: "Boş Alan Bıraktınız!", message: "Lütfen 2.Takım Puanını Giriniz!")
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
        let storedScores1 = UserDefaults.standard.object(forKey: "storedScores2_1")
        if let storedScore1 = storedScores1 as? Array<Any> {
            scores1.removeAll(keepingCapacity: false)
            for res in storedScore1 {
                scores1.append(res as! String)
            }
        }
        
        let storedScores2 = UserDefaults.standard.object(forKey: "storedScores2_2")
        if let storedScore2 = storedScores2 as? Array<Any> {
            scores2.removeAll(keepingCapacity: false)
            for res in storedScore2 {
                scores2.append(res as! String)
            }
        }
        
        let storedPlayers = UserDefaults.standard.object(forKey: "storedPlayers2")
            
        if let storedPlayer = storedPlayers as? Array<Any> {
            players.removeAll(keepingCapacity: false)
            for item in storedPlayer {
                players.append(item as! String)
            }
            player1.text = storedPlayer[0] as? String
            player2.text = storedPlayer[1] as? String
        }
    }
    
    
    @IBAction func addScore(_ sender: Any) {
        if (player1.text == "" || player2.text == "" || score1.text == "" || score2.text == "") {
            checkNull()
        } else {
            players.append(player1.text!)
            players.append(player2.text!)
            
            scores1.append(score1.text!)
            scores2.append(score2.text!)
            
            player1.text = players[0]
            player2.text = players[1]
            
            UserDefaults.standard.set(players, forKey: "storedPlayers2")
            
            UserDefaults.standard.set(scores1, forKey: "storedScores2_1")
            UserDefaults.standard.set(scores2, forKey: "storedScores2_2")
            resultButton.isEnabled = true
            getData()
            self.tableView.reloadData()
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
        UserDefaults.standard.removeObject(forKey: "storedPlayers2")
        resultButton.isEnabled = false
        
        deleteScores()

        player1.text = ""
        player2.text = ""
        
        score1.text = ""
        score2.text = ""
        
        self.tableView.reloadData()
    }
    
    @objc func deleteScores(){
        UserDefaults.standard.removeObject(forKey: "storedScores2_1")
        UserDefaults.standard.removeObject(forKey: "storedScores2_2")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableView2") as! SecondTableViewCell
         cell.counterLbl.text = "\(indexPath.row+1)"
         cell.score1Lbl.text = scores1[indexPath.row]
         cell.score2Lbl.text = scores2[indexPath.row]

         return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            scores1.remove(at: indexPath.row)
            scores2.remove(at: indexPath.row)
            
            deleteScores()
            
            UserDefaults.standard.set(scores1, forKey: "storedScores2_1")
            UserDefaults.standard.set(scores2, forKey: "storedScores2_2")
            
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "secondResultVC"{
            let destinationVC = segue.destination as! SecondResultViewController
            destinationVC.resPlayers = players
            destinationVC.resScores1 = scores1
            destinationVC.resScores2 = scores2
        }
    }
    
    @IBAction func showResult(_ sender: Any) {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
    
}
