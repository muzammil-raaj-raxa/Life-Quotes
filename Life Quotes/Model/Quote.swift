//
//  Quote.swift
//  LifeQuotes
//
//  Created by Mag isb-10 on 20/02/2024.
//

// Quote.swift

import UIKit

struct Quote: Identifiable {
    var id = UUID()
    var image: UIImage?
    var quoteText: String
  var author: String
}

