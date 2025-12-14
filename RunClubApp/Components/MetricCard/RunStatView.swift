//
//  RunStatView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 12/14/25.
//

import SwiftUI

struct RunStatView: View {
    let stat: String
    let statTitle: String
    
    var body: some View {
        VStack {
            Text(stat)
                .font(.system(.title, design: .default, weight: .bold))
                .foregroundStyle(.primaryBackground)
            
            Text(statTitle)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RunStatView(stat: "0.04", statTitle: "MILES")
}
