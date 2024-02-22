//
//  ViewController.swift
//  LifeQuotes
//
//  Created by Mag isb-10 on 19/02/2024.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var quotestblView: UITableView!
  
  var currentIndex = 0
  
  var quotes: [Quote] = [
    Quote(image: UIImage(named: "image2.jpeg"), quoteText: "Dream, dare, conquer.", author: "- raaj"),
    Quote(image: UIImage(named: "image7.jpeg"), quoteText: "Curiosity is the engine of innovation.", author: "- Albert Einstein"),
    Quote(image: UIImage(named: "image8.jpeg"), quoteText: "Love conquers all.", author: "- Virgil"),
    Quote(image: UIImage(named: "image1.jpeg"), quoteText: "I write myself into existence." , author: "- Maxine Hong Kingston"),
    Quote(image: UIImage(named: "image5.jpeg"), quoteText: "Dream big." , author: "- Albert Einstein"),
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.hidesBackButton = true
    self.navigationController?.isNavigationBarHidden = true
    
    quotestblView.showsVerticalScrollIndicator = false
    quotestblView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    quotestblView.contentInsetAdjustmentBehavior = .never

    
    quotestblView.delegate = self
    quotestblView.dataSource = self
    quotestblView.register(UINib(nibName: "QuotesCell", bundle: .main), forCellReuseIdentifier: "QuotesCell")
    
    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
    swipeUp.direction = .up
    quotestblView.addGestureRecognizer(swipeUp)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
    swipeDown.direction = .down
    quotestblView.addGestureRecognizer(swipeDown)
    
    quotestblView.isScrollEnabled = false
  }
  
  @IBAction func forYouBtnAction(_ sender: UIButton) {
    
    print("For you clicked")
  }
  
  @IBAction func themeBtnAction(_ sender: UIButton) {
    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThemeViewController") as? ThemeViewController {
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  @IBAction func profileBtnAction(_ sender: UIButton) {
    print("Profile clicked")
  }
  
  @IBAction func configureBtnAction(_ sender: UIButton) {
    print("Configure clicked")
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      let visibleCells = quotestblView.visibleCells

      if let firstVisibleCell = visibleCells.first, let indexPath = quotestblView.indexPath(for: firstVisibleCell) {
        currentIndex = indexPath.row
      }

      quotestblView.isScrollEnabled = true
    }
  
  @objc func handleSwipeUp(_ gesture: UISwipeGestureRecognizer) {
        if currentIndex < quotes.count - 1 {
            currentIndex += 1
            quotestblView.scrollToRow(at: IndexPath(row: currentIndex, section: 0), at: .top, animated: true)
        }
  }

  @objc func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
        if currentIndex > 0 {
            currentIndex -= 1
            quotestblView.scrollToRow(at: IndexPath(row: currentIndex, section: 0), at: .top, animated: true)
        }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quotes.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuotesCell", for: indexPath) as? QuotesCell else {return UITableViewCell()}
    cell.img.contentMode = .scaleToFill
    cell.img.image = quotes[indexPath.row].image
    cell.quote.text = quotes[indexPath.row].quoteText
    cell.author.text = quotes[indexPath.row].author
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("index: \(indexPath.row)")
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return self.view.bounds.height
  }
}
