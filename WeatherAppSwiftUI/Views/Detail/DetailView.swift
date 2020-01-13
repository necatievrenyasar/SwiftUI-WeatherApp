//
//  DetailView.swift
//  WeatherAppSwiftUI
//
//  Created by Evren Yaşar on 29.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import SwiftUI

struct DetailRowModel: Identifiable {
    var id = UUID()
    var degree: Int
    var time: String
    var weather: WeatherType
}


struct DetailView: View {

    private var data: [DetailRowModel] {
        return [.init(degree: 12, time: "09:00", weather: .clouds),
                .init(degree: 13, time: "12:00", weather: .rain),
                .init(degree: 11, time: "15:00", weather: .clouds),
                .init(degree: 12, time: "17:00", weather: .rain)]
    }
     
    private let title: String
    
    
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.topColor,.centerColor,.bottomColor]), startPoint: .topLeading, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("12")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    Text("°")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .padding(.top, -40)
                        .padding(.leading, -10)
                    
                }.padding(.top, 100)
                
                Text("Ankara")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .padding(.top, 40)
                
                Text("Today 9:00 pm")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                Spacer()
                HStack(spacing: 34) {
                    TimeWeatherRow(model: data[0])
                    TimeWeatherRow(model: data[1])
                    TimeWeatherRow(model: data[2])
                    TimeWeatherRow(model: data[3])
                }
                Spacer()
            }
            .navigationBarTitle(Text("Detail View"), displayMode: .inline)
        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(title: "Sunday")
    }
}

struct TimeWeatherRow: View {
    
    let data: DetailRowModel
    init(model: DetailRowModel) {
        self.data = model
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(data.degree)")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                Text("°")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                    .padding(.leading, -10).padding(.top, -24)
            }.padding(.bottom, -24)
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(width: 54, height: 64, alignment: .center)
                
                Image(systemName:data.weather.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 50, alignment: .center)
                    .foregroundColor(.white)
            }
            Text(data.time)
                .font(.system(size: 16))
                .foregroundColor(.white)
        }
    }
}
