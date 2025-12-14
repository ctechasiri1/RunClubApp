//
//  LoginView.swift
//  RunClubApp
//
//  Created by Chiraphat Techasiri on 10/28/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            logoSection
            
            VStack(spacing: 20) {
                loginTitle
                
                loginEmailInput
                
                loginButon
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
    LoginView(viewModel: LoginViewModel())
}

extension LoginView {
    private var logoSection: some View {
        Image("Icon")
            .resizable()
            .frame(height: UIScreen.main.bounds.height / 2)
            .scaledToFit()
    }
    
    private var loginTitle: some View {
        Text("Welcome to the Club")
            .font(.system(.title, weight: .bold))
            .foregroundStyle(.secondaryBackground)
    }
    
    private var loginEmailInput: some View {
        TextField("Enter Email Here", text: $viewModel.email)
            .padding()
            .background(.ultraThickMaterial)
            .clipShape(Capsule())
            .padding()
    }
    
    private var loginButon: some View {
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
}
