//
//  QuotesBundle.swift
//  Quotes
//
//  Created by Mag isb-10 on 21/02/2024.
//

import WidgetKit
import SwiftUI

@main
struct QuotesBundle: WidgetBundle {
    var body: some Widget {
        Quotes()
        QuotesLiveActivity()
    }
}
