//
//  File.swift
//  
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI

struct AuthenticationView: View {
    @State var signIn = true
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
            .roundedFont(.caption2, weight: .light)
         + Text("Slothing")
            .roundedFont(.caption2, weight: .semibold)
         + Text(" accounts are independent of ")
            .roundedFont(.caption2, weight: .light)
         + Text("Watched It.")
            .roundedFont(.caption2, weight: .semibold)
         + Text(" Refer to our ")
            .roundedFont(.caption2, weight: .light)
         + Text("Terms & Conditions")
            .roundedFont(.caption2, weight: .light)
            .foregroundColor(.link)
         + Text(", & ")
            .roundedFont(.caption2, weight: .light)
         + Text("Privacy Policy")
            .roundedFont(.caption2, weight: .medium)
            .foregroundColor(.link)
         + Text(" for more info.")
            .roundedFont(.caption2, weight: .light)
        ).multilineTextAlignment(.center)
        .opacity(0.6)
        .padding(.bottom, 20)
    }
}

struct AuthenticationHolderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
