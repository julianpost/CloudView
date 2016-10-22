//
//  TempViewController.swift
//  NOAA
//
//  Created by Julian Post on 7/24/16.
//  Copyright © 2016 Julian Post. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    
    @IBOutlet weak var tempViewOne: UIView!
    @IBOutlet weak var tempViewTwo: UIView!
    @IBOutlet weak var tempViewThree: UIView!
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            tempViewOne.layer.isHidden = false
            tempViewTwo.layer.isHidden = true
            tempViewThree.layer.isHidden = true
        
        case 1:
            tempViewOne.layer.isHidden = true
            tempViewTwo.layer.isHidden = false
            tempViewThree.layer.isHidden = true
            
        case 2:
            tempViewOne.layer.isHidden = true
            tempViewTwo.layer.isHidden = true
            tempViewThree.layer.isHidden = false
            
        default:
            tempViewOne.layer.isHidden = false
            tempViewTwo.layer.isHidden = true
            tempViewThree.layer.isHidden = true
        }
    }
    
    
    @IBAction func dismissView(_ sender: AnyObject) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FetchAllData.temp(tempViewOne, viewTwo: tempViewTwo, viewThree: tempViewThree)
        
        tempViewOne.layer.isHidden = false
        tempViewTwo.layer.isHidden = true
        tempViewThree.layer.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}

