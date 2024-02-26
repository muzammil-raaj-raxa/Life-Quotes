//
//  ThemeViewController.swift
//  Life Quotes
//
//  Created by Mag isb-10 on 22/02/2024.
//

import UIKit

protocol ThemeSelectionDelegate: AnyObject {
  func didSelectFont(font: UIFont)
}

class ThemeViewController: UIViewController, UIGestureRecognizerDelegate {
  
  @IBOutlet weak var themeTableView: UITableView!
  
  var currentIndexPath: IndexPath?
  weak var delegate: ThemeSelectionDelegate?
  
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
  
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      // Reset font selection state before displaying cells
      for index in 0..<font.count {
          font[index].fontSelected = false
      }
  }
  
  @IBAction func backBtnAction(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func doneButton(_ sender: UIButton) {
    
    if let selectedIndexPath = currentIndexPath {
      let selectedFont = font[selectedIndexPath.row].fontStyle
      delegate?.didSelectFont(font: selectedFont ?? UIFont.systemFont(ofSize: 17))
    }
    self.navigationController?.popViewController(animated: true)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  @objc func handleSwipeRight(_ gesture: UISwipeGestureRecognizer) {
    if let navigationController = navigationController , navigationController.viewControllers.count > 1 {
      navigationController.popViewController(animated: true)
    }
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
