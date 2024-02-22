

// Quote.swift

import UIKit

struct Quote: Identifiable {
    var id = UUID()
    var image: UIImage?
    var quoteText: String
    var author: String
  var quoteFont: UIFont?
}

