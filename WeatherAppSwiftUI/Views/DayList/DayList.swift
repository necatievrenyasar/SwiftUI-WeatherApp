//
//  ContentView.swift
//  WeatherAppSwiftUI
//
//  Created by Evren Yaşar on 27.12.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import SwiftUI

struct DayList: View {
    
    private var topColor = Color(red: 146/255, green: 78/255, blue: 163/255)
    private var centerColor = Color(red: 64/255, green: 49/255, blue: 140/255)
    private var bottomColor = Color(red: 40/255, green: 30/255, blue: 90/255)
    
    @ObservedObject var viewModel = DayListViewModel()
    
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(red: 40/255, green: 30/255, blue: 90/255, alpha: 1)
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [topColor,centerColor, bottomColor]), startPoint: .topLeading, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ForEach(self.viewModel.datas) { value in
                        NavigationLink(destination: DetailView(title:"" )){
                            DayInfoRow(model: value)
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
                    
                .navigationBarTitle(Text("Weather App"), displayMode: .inline)
            }
            
        }.onAppear {
            self.viewModel.start()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayList()
    }
}
