//
//  RunClubTabView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/17/25.
//

import SwiftUI

struct RunClubTabView: View {
    @EnvironmentObject private var viewModel: RunTrackerViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.selectedTab) {
                HomeView()
                    .tag(Tab.home)
                    .toolbarVisibility(.hidden, for: .tabBar)
            }
            tabBar
        }
    }
}

#Preview {
    RunClubTabView()
        .environmentObject(RunTrackerViewModel(locationService: LocationService()))
}

extension RunClubTabView {
    private func customTabBarItem(title: String, imageName: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            
            Image(systemName: imageName)
                .resizable()
                .foregroundStyle(isActive ? .white : .gray)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .foregroundStyle(.white)
        .fontWeight(.heavy)
        .frame(width: isActive ? 125 : 40, height: 60, alignment: .center)
        .background(isActive ? .primaryBackground : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var tabBar: some View {
        ZStack {
            HStack {
                ForEach(Tab.allCases, id:\.self) { tab in
                    Button {
                        viewModel.selectedTab = tab
                    } label: {
                        customTabBarItem(
                            title: tab.title,
                            imageName: tab.iconName,
                            isActive: viewModel.selectedTab == tab
                        )
                    }
                }
            }
            .padding(6)
        }
        .frame(width: 200, height: 80)
        .background(.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 26)
    }
}
