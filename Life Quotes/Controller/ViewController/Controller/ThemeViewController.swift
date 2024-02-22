//
//  ThemeViewController.swift
//  Life Quotes
//
//  Created by Mag isb-10 on 22/02/2024.
//

import UIKit

class ThemeViewController: UIViewController, UIGestureRecognizerDelegate {

  @IBOutlet weak var themeTableView: UITableView!
  var currentIndexPath: IndexPath?
  
  //MARK: - Font names and styles
  
  var font: [FontStyles] = [
    FontStyles(fontName: "Arial", fontStyle: UIFont(name: "Arial", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Helvetica", fontStyle: UIFont(name: "Helvetica", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Times New Roman", fontStyle: UIFont(name: "Times New Roman", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Courier New", fontStyle: UIFont(name: "Courier New", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Georgia", fontStyle: UIFont(name: "Georgia", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Palatino", fontStyle: UIFont(name: "Palatino", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Verdana", fontStyle: UIFont(name: "Verdana", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "American Typewriter", fontStyle: UIFont(name: "American Typewriter", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Avenir", fontStyle: UIFont(name: "Avenir", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Futura", fontStyle: UIFont(name: "Futura", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
    FontStyles(fontName: "Copperplate", fontStyle: UIFont(name: "Copperplate", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
    FontStyles(fontName: "Optima", fontStyle: UIFont(name: "Optima", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
    FontStyles(fontName: "Didot", fontStyle: UIFont(name: "Didot", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
    FontStyles(fontName: "Garamond", fontStyle: UIFont(name: "Garamond", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
    FontStyles(fontName: "Hoefler Text", fontStyle: UIFont(name: "Hoefler Text", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Baskerville", fontStyle: UIFont(name: "Baskerville", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Symbol", fontStyle: UIFont(name: "Symbol", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Charter", fontStyle: UIFont(name: "Charter", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Menlo", fontStyle: UIFont(name: "Menlo", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Courier", fontStyle: UIFont(name: "Courier", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Bradley Hand", fontStyle: UIFont(name: "Bradley Hand", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Chalkduster", fontStyle: UIFont(name: "Chalkduster", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Noteworthy", fontStyle: UIFont(name: "Noteworthy", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Marker Felt", fontStyle: UIFont(name: "Marker Felt", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Zapfino", fontStyle: UIFont(name: "Zapfino", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Gill Sans", fontStyle: UIFont(name: "Gill Sans", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Geneva", fontStyle: UIFont(name: "Geneva", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Tahoma", fontStyle: UIFont(name: "Tahoma", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false),
        FontStyles(fontName: "Impact", fontStyle: UIFont(name: "Impact", size: 17) ?? UIFont.systemFont(ofSize: 17), fontSelected: false)
    ]

  
  override func viewDidLoad() {
        super.viewDidLoad()

    themeTableView.delegate = self
    themeTableView.dataSource = self
    themeTableView.register(UINib(nibName: "FontStyleCell", bundle: .main), forCellReuseIdentifier: "FontStyleCell")
    
    themeTableView.rowHeight = 50.0
    themeTableView.separatorStyle = .none
    themeTableView.showsVerticalScrollIndicator = false
    themeTableView.allowsSelection = true
    
    let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(_:)))
    swipeRightGesture.direction = .right
    view.addGestureRecognizer(swipeRightGesture)
    
    swipeRightGesture.delegate = self
    }
  
  @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
    if let navigationController = navigationController , navigationController.viewControllers.count > 1 {
      navigationController.popViewController(animated: true)
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  @IBAction func backBtnAction(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}

extension ThemeViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return font.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FontStyleCell", for: indexPath) as? FontStyleCell else {
      return UITableViewCell()
    }
    cell.fontStyleLabel.text = font[indexPath.row].fontName
    cell.fontStyleLabel.font = font[indexPath.row].fontStyle
    cell.accessoryType = font[indexPath.row].fontSelected ? .checkmark : .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let currentIndexPath = currentIndexPath {
      font[currentIndexPath.row].fontSelected = false
      tableView.reloadRows(at: [currentIndexPath], with: .automatic)
    }
    
    currentIndexPath = indexPath
      
    font[indexPath.row].fontSelected = true
    tableView.reloadRows(at: [indexPath], with: .automatic)
    
  }
}
