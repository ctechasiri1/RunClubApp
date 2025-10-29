//
//  LoginView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/28/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Image("Icon")
                .resizable()
                .frame(height: UIScreen.main.bounds.height / 2)
                .scaledToFit()
            
            VStack(spacing: 20) {
                Text("Welcome to the Club")
                    .font(.system(.title, weight: .bold))
                    .foregroundStyle(.secondaryBackground)
                
                TextField("Enter Email Here", text: $viewModel.email)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(Capsule())
                    .padding()
                
                Button {
                    print("Magic link login action working")
                    viewModel.loginAction()
                } label: {
                    Text("Login")
                        .foregroundStyle(.primaryBackground)
                        .font(.system(.title2, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(viewModel.email.count < 7)
                .onOpenURL { url in
                    print("Handle magic link being triggered")
                    viewModel.handleMagicLink(url: url)
                }
            }
            .frame(height: 300)
            .frame(maxWidth: .infinity)
            .background(.primaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .offset(y: -80)
            
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
