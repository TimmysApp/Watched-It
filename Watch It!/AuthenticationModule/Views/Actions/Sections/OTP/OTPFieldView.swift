//
//  OTPFieldView.swift
//  Watch It!
//
//  Created by Joe Maghzal on 18/03/2023.
//

import SwiftUI
import STools

struct OTPFieldView: View {
    @FocusState var focusState: OTPDigit?
    @State var digits = [OTPDigit]()
    @Binding var code: String
    var error: Bool?
    var body: some View {
        HStack(spacing: 10) {
            ForEach($digits) { item in
                OTPTextField("", text: item.digit)
                    .onEmptyDelete {
                        await MainActor.run {
                            guard let index = digits.firstIndex(where: {$0.index == item.wrappedValue.index - 1}) else {return}
                            focusState = digits[index]
                        }
                    }.roundedFont(weight: .semibold)
                    .focused($focusState, equals: item.wrappedValue)
                    .frame(width: (screenWidth - 110)/6, height: (screenWidth - 110)/6)
                    .background {
                        Color.basic.opacity(0.3)
                            .background {
                                if let error {
                                    error ? Color.red: Color.green
                                }else {
                                    Color.clear
                                }
                            }
                    }.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .onChange(of: item.wrappedValue.digit) { newValue in
                        guard !newValue.isEmpty, let nextItem = digits.first(where: {$0.index == item.wrappedValue.index + 1}) else {return}
                        if newValue.count > 1 {
                            let lastCharacter = String(digits[item.wrappedValue.index].digit.removeLast())
                            digits[nextItem.index].digit = lastCharacter
                            focusState = nextItem
                        }else {
                            focusState = nextItem
                        }
                    }
            }
        }.onChange(of: digits) { newValue in
            code = newValue.map(\.digit).joined()
        }.task {
            digits = (0..<6).map({OTPDigit(index: $0, digit: "")})
            focusState = digits.first
        }
    }
}

struct OTPDigit: Identifiable, Equatable, Hashable {
    var id = UUID()
    var index: Int
    var digit: String
}
