//
//  ThirdResultViewController.swift
//  yazboz
//
//  Created by Orhan Erbas on 4.08.2020.
//  Copyright © 2020 Orhan Erbas. All rights reserved.
//

import GoogleMobileAds
import UIKit

class ThirdResultViewController: UIViewController {
    @IBOutlet weak var user1Lbl: UILabel!
    @IBOutlet weak var user2Lbl: UILabel!
    @IBOutlet weak var user3Lbl: UILabel!
    @IBOutlet weak var user4Lbl: UILabel!
    @IBOutlet weak var score1Lbl: UILabel!
    @IBOutlet weak var score2Lbl: UILabel!
    @IBOutlet weak var score3Lbl: UILabel!
    @IBOutlet weak var score4Lbl: UILabel!
    
    var resPlayers = [String]()
    var resScores1 = [String]()
    var resScores2 = [String]()
    var resScores3 = [String]()
    var resScores4 = [String]()
    
    var topScore    = 0
    var topScore2   = 0
    var topScore3   = 0
    var topScore4   = 0
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sonuçlar"
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 214/255.0, green: 212/255.0, blue: 175/255.0, alpha: 1.0)
        
        for item in resScores1 {
            topScore += Int(item)!
        }
        
        for item in resScores2 {
            topScore2 += Int(item)!
        }
        
        for item in resScores3 {
            topScore3 += Int(item)!
        }
        
        for item in resScores4 {
            topScore4 += Int(item)!
        }
        
        user1Lbl.text = resPlayers[0]
        user2Lbl.text = resPlayers[1]
        user3Lbl.text = resPlayers[2]
        user4Lbl.text = resPlayers[3]
        score1Lbl.text = String(topScore)
        score2Lbl.text = String(topScore2)
        score3Lbl.text = String(topScore3)
        score4Lbl.text = String(topScore4)
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
      bannerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(bannerView)
      view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                            attribute: .bottom,
                            relatedBy: .equal,
                            toItem: bottomLayoutGuide,
                            attribute: .top,
                            multiplier: 1,
                            constant: 0),
         NSLayoutConstraint(item: bannerView,
                            attribute: .centerX,
                            relatedBy: .equal,
                            toItem: view,
                            attribute: .centerX,
                            multiplier: 1,
                            constant: 0)
        ])
     }
}
