//
//  ViewController.swift
//  SwiftUIinUIKit
//
//  Created by Nivedita Angadi on 10/02/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        view.addSubview(button)
        button.center = view.center
        button.setTitle("Show Settings", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapButton() {
        let settingsViewController = UIHostingController(rootView: SettingsScreen())
        present(settingsViewController, animated: true)
    }


}

