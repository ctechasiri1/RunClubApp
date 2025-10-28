//
//  ActivitiesView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/18/25.
//

import SwiftUI

struct ActivitiesView: View {
    @StateObject private var viewModel = ActivitiesViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.runs, id: \.id) { run in
                    VStack {
                        HStack {
                            Image(systemName: "person")
                            Text(run.title)
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchRunData()
                }
            }
        }
    }
}

#Preview {
    ActivitiesView()
}
