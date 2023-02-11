//
//  AuthenticationView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @State var signIn = false
    @State var movingUp = false
    var body: some View {
        VStack {
            Group {
                if signIn {
                    SignInView(signIn: $movingUp)
                }else {
                    SignUpView(signIn: $movingUp)
                }
            }.clipShape(RoundedRectangle(cornerRadius: movingUp ? 40: 0, style: .continuous))
            .padding(movingUp ? 50: 0)
            .shadow(radius: movingUp ? 10: 0)
            .zIndex(1)
            .transition(.move(edge: .trailing).combined(with: .opacity))
            .onChange(of: movingUp) { newValue in
                guard newValue else {return}
                Task {
                    try? await Task.sleep(nanoseconds: 4_000_000_00)
                    signIn.toggle()
                    try? await Task.sleep(nanoseconds: 4_000_000_00)
                    movingUp.toggle()
                }
            }
        }.edgesIgnoringSafeArea(.all)
        .animation(.spring(), value: signIn)
        .animation(.easeInOut, value: movingUp)
        .background(Color.black)
    }
    static var note: some View {
        (Text("Please note that ")
            .fontWeight(.light)
         + Text("Slothing")
            .fontWeight(.semibold)
         + Text(" accounts are independent of ")
            .fontWeight(.light)
         + Text("Watched It.")
            .fontWeight(.semibold)
         + Text(" Refer to our ")
            .fontWeight(.light)
         + Text("Terms & Conditions")
            .fontWeight(.medium)
            .foregroundColor(.link)
         + Text(", & ")
            .fontWeight(.light)
         + Text("Privacy Policy")
            .fontWeight(.medium)
            .foregroundColor(.link)
         + Text(" for more info.")
            .fontWeight(.light)
        ).font(.caption2)
            .multilineTextAlignment(.center)
            .opacity(0.6)
            .padding(.bottom, 30)
    }
}

struct AuthenticationHolderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
