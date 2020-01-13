//
//  FetchData.swift
//  WeatherAppSwiftUI
//
//  Created by Evren Yaşar on 28.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import SwiftUI
class FetchData: ObservableObject {
    
    @Published var resultData = Data()
    
    init(url: String) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.resultData = data
            }
        }
        
    }
    
}
