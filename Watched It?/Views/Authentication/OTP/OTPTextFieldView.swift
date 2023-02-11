//
//  OTPTextFieldView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import SwiftUI
import STools

struct OTPTextFieldView: View {
    @FocusState var focusState: OTPDigit?
    @State var digits = [OTPDigit]()
    var body: some View {
        HStack(spacing: 10) {
            ForEach($digits) { item in
                TextField("", text: item.digit)
                    .focused($focusState, equals: item.wrappedValue)
                    .multilineTextAlignment(.center)
                    .frame(width: (screenWidth - 110)/6, height: (screenWidth - 110)/6)
                    .background(Color.basic.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .onChange(of: item.wrappedValue.digit) { newValue in
                        if newValue.isEmpty {
                            
                        }else if let nextItem = digits.first(where: {$0.index == item.wrappedValue.index + 1}) {
                            focusState = nextItem
                        }
                    }
            }
        }.onAppear {
            digits = (0..<6).map({OTPDigit(index: $0, digit: "")})
        }
    }
}

struct OTPDigit: Identifiable, Equatable, Hashable {
    var id = UUID()
    var index: Int
    var digit: String
}

struct OTPTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextFieldView()
            .padding(20)
            .background(Color.sheetBackground)
    }
}
