//
//  ViewController.swift
//  LocalisationDemoApp
//
//  Created by Amitabha Saha on 04/03/20.
//  Copyright © 2020 Amitabha. All rights reserved.
//

import UIKit


extension String {
    func localized() ->String {

        if let language = UserDefaults.standard.value(forKey: "selected_region") as? String {
            let path = Bundle.main.path(forResource: language, ofType: "lproj")
            let bundle = Bundle(path: path!)
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
            
        } else {
            return NSLocalizedString(self, comment: "")
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var changeLanguageButton: UIButton!
    
    var selectedlanguage = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //print(UserDefaults.standard.string(forKey: "selected_regions")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI() {
        
        label1.text = "back_key".localized()
        label2.text = "name_key".localized()
        label3.text = "email_key".localized()
        label4.text = "unkown_key".localized()
    }
    
    @IBAction func changeAction(_ sender: Any) {
        
        let actionSheet = UIAlertController.init(title: "Select", message: "language", preferredStyle: .actionSheet)
        
        
        let english_action = UIAlertAction.init(title: "English", style: .default) { (action) in
            self.setLanguage(to: "en")
        }
        
        let spanish_action = UIAlertAction.init(title: "Spanish", style: .default) { (action) in
            self.setLanguage(to: "es")
        }
        
        let german_action = UIAlertAction.init(title: "German", style: .default) { (action) in
            self.setLanguage(to: "de")
        }
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        actionSheet.addAction(english_action)
        actionSheet.addAction(spanish_action)
        actionSheet.addAction(german_action)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func setLanguage(to: String) {
        UserDefaults.standard.set(to, forKey: "selected_region")
        if UserDefaults.standard.synchronize() {
            self.viewWillAppear(true)
        } else {
            print("Failed to save")
        }
    }
}

