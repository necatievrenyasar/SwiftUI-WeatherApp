//
//  Date+extentions.swift
//  WeatherAppSwiftUI
//
//  Created by Evren Yaşar on 28.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
extension Date {
    func formatter(_ format:String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
    }
}
