//
//  RunClubTabView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

enum Tab  {
    case home, profile
}

struct RunClubTabView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView {
            HomeView()
                .tag(Tab.home)
                .tabItem {
                    Image(systemName: "house.fill")
                        .background(.clear)
                }
                
        }
        
    }
}

#Preview {
    RunClubTabView()
}
