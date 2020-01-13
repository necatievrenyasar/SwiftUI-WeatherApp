//
//  DayInfoRow.swift
//  WeatherAppSwiftUI
//
//  Created by Evren Yaşar on 28.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import SwiftUI
struct DayInfoRow: View {
    
    private var bottomColor = Color(red: 40/255, green: 30/255, blue: 90/255)
    let model: DayRowModel
    init(model: DayRowModel) {
        self.model = model
    }
    
    var body: some View {
        Group {
            HStack {
                //Day And Date
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.day).font(.system(size: 20)).fontWeight(.medium).foregroundColor(.white)
                    Text(model.date).font(.system(size: 14)).foregroundColor(.gray)
                }.padding(EdgeInsets(top: 24, leading: 28, bottom: 24, trailing: 0))
                Spacer()
                Text(model.degree).font(.system(size: 24)).foregroundColor(Color.white).padding(.trailing, -6)
                Text("°").font(.system(size: 24)).foregroundColor(Color.white).padding(.trailing, 2).padding(.top, -10)
                Image(systemName: model.weather.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 50, alignment: .center)
                    .padding(.trailing,20)
                    .foregroundColor(Color.white)
            }
        }.background(LinearGradient(gradient: Gradient(colors: [self.bottomColor, Color.clear]), startPoint: .top, endPoint: .bottom).opacity(0.1))
            .background(Color.clear)
    }
}
