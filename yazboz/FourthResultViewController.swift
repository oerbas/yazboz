//
//  FourthResultViewController.swift
//  yazboz
//
//  Created by Orhan Erbas on 7.08.2020.
//  Copyright © 2020 Orhan Erbas. All rights reserved.
//

import GoogleMobileAds
import UIKit

class FourthResultViewController: UIViewController {
    @IBOutlet weak var player1Lbl: UILabel!
    @IBOutlet weak var player2Lbl: UILabel!
    @IBOutlet weak var score1Lbl: UILabel!
    @IBOutlet weak var score2Lbl: UILabel!
    
    var resPlayers = [String]()
    var resScores1 = [String]()
    var resScores2 = [String]()
    
    var topScore    = 0
    var topScore2   = 0
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
        
        player1Lbl.text = resPlayers[0]
        player2Lbl.text = resPlayers[1]
        score1Lbl.text = String(topScore)
        score2Lbl.text = String(topScore2)
        
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
