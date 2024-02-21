//
//  CustomLaunchScreen.swift
//  LifeQuotes
//
//  Created by Mag isb-10 on 19/02/2024.
//

import UIKit

class CustomLaunchScreen: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
   
    DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
      if let vc  = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
        
        self.navigationController?.pushViewController(vc, animated: true)
      }
    }
  }
}
