//
//  FontStyles.swift
//  Life Quotes
//
//  Created by Mag isb-10 on 22/02/2024.
//

import UIKit

class FontStyles {
  var fontName: String
  var fontStyle: UIFont?
  var fontSelected: Bool
  
  init(fontName: String, fontStyle: UIFont?, fontSelected: Bool) {
      self.fontName = fontName
      self.fontStyle = fontStyle
      self.fontSelected = fontSelected
    }
}
