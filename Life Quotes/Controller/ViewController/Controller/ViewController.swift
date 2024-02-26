//
//  ViewController.swift
//  LifeQuotes
//
//  Created by Mag isb-10 on 19/02/2024.
//

import UIKit
import WidgetKit

class ViewController: UIViewController, ThemeSelectionDelegate {
  
  @IBOutlet weak var quotestblView: UITableView!
  
  var selectedFont: String?
  var currentIndex = 0
  
  var quotes: [Quote] = [
    Quote(image: UIImage(named: "image2.png"), quoteText: "Dream, dare, conquer.", author: "- raaj"),
    Quote(image: UIImage(named: "image1.png"), quoteText: "Curiosity is the engine of innovation.", author: "- Albert Einstein"),
    Quote(image: UIImage(named: "image0.png"), quoteText: "Love conquers all.", author: "- Virgil"),
    Quote(image: UIImage(named: "image3.png"), quoteText: "I write myself into existence." , author: "- Maxine Hong Kingston"),
    Quote(image: UIImage(named: "image4.png"), quoteText: "Dream big." , author: "- Albert Einstein"),
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
    
    let defaultFontName = "CreamCake"
    let defaultFontSize: CGFloat = 45

    if let defaultFont = UIFont(name: defaultFontName, size: defaultFontSize) {
    for index in 0..<quotes.count {
            quotes[index].quoteFont = defaultFont
        }
    } else {
        // Fallback to system font if CreamCake is not available
        for index in 0..<quotes.count {
            quotes[index].quoteFont = UIFont.systemFont(ofSize: defaultFontSize)
        }
    }

    quotestblView.reloadData()
        
    
    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp(_:)))
    swipeUp.direction = .up
    quotestblView.addGestureRecognizer(swipeUp)
    
    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
    swipeDown.direction = .down
    quotestblView.addGestureRecognizer(swipeDown)
    
    quotestblView.isScrollEnabled = false
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let font = UserDefaults.standard.value(forKey: selectedUserDefaultFont) as? String {
      selectedFont = font
      quotestblView.reloadData()
    }
  }
  func didSelectFont(font: UIFont) {
    print("selectedfont: \(font)")
    
    let fixedFontSize: CGFloat = 30
    
    for index in 0..<quotes.count {
      // Use the selected font family and set a fixed font size
      quotes[index].quoteFont = UIFont(name: font.fontName, size: fixedFontSize) ?? UIFont.systemFont(ofSize: fixedFontSize)
    }
    quotestblView.reloadData()
  }
  
  func saveQuoteToWidget(quote: Quote) {
      let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.mag-isb.LifeQuotes.LifeQuote")

      // Convert UIImage to Data (PNG representation)
    if let image = quote.image, let imageData = image.pngData(), let containerURL = sharedContainerURL {
      let imagePath = containerURL.appendingPathComponent("imageData.png")
      
      do {
        try imageData.write(to: imagePath)
        UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")?.set(imagePath.path, forKey: "imageData")
      } catch {
        print("Error writing image data: \(error)")
      }
    }
      // Save other data as usual
      UserDefaults(suiteName: "group.mag-isb.LifeQuotes.LifeQuote")?.set(quote.quoteText, forKey: "quoteText")
      WidgetCenter.shared.reloadAllTimelines()
  }

  
  @IBAction func forYouBtnAction(_ sender: UIButton) {
      print("For you clicked")
  }
  
  @IBAction func themeBtnAction(_ sender: UIButton) {
    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThemeViewController") as? ThemeViewController {
      vc.delegate = self
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  @IBAction func profileBtnAction(_ sender: UIButton) {
    print("Profile clicked")
  }
  
  @IBAction func configureBtnAction(_ sender: UIButton) {
    let currentQuote = quotes[currentIndex]
    
    // Call the function to save the quote to the widget
    saveQuoteToWidget(quote: currentQuote)
    
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
    cell.quote.font = quotes[indexPath.row].quoteFont
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
