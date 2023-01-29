//
//  Extensions.swift
//  Watched It?
//
//  Created by Joe Maghzal on 15/01/2023.
//

import SwiftUI
import STools
import DataStruct

extension View {
    @ViewBuilder func hidden(_ value: Bool) -> some View {
        if !value {
            self
        }
    }
    @ViewBuilder func hidden(_ value: @escaping () -> Bool) -> some View {
        hidden(value())
    }
    func fetch<T: Datable, Config: Any>(_ type: T.Type, config: Binding<Config>, for keyPath: WritableKeyPath<Config, [T]>) -> some View {
        onReceive(type.modelData.publisher()) { newValue in
            config.wrappedValue[keyPath: keyPath] = newValue
        }
    }
    func onSwipe(_ edge: HorizontalEdge, action: @escaping () -> Void) -> some View {
        gesture(
            DragGesture()
                .onEnded { value in
                    let swipingEdge = value.translation.width < 0 ? HorizontalEdge.leading: HorizontalEdge.trailing
                    guard swipingEdge == edge else {return}
                    action()
                }
        )
    }
    func with(status: String) -> some View {
        overlay(alignment: .topLeading) {
            Text(status)
                .font(.caption2)
                .fontWeight(.semibold)
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(5)
                .background(Color.tint.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding(.top, -10)
                .padding(.leading, -10)
                .compositingGroup()
                .shadow(color: .coloredShadow, radius: 5)
                .transition(.slide)
                .hidden(status.isEmpty)
        }
    }
}

extension Array {
    func limit(to limit: Int) -> Self {
        return reduce(into: Self()) { partialResult, element in
            guard partialResult.count < limit else {return}
            partialResult.append(element)
        }
    }
}

extension Array where Element: Equatable {
    func limit(to limit: Int) -> Self {
        return reduce(into: Self()) { partialResult, element in
            guard partialResult.count < limit && !partialResult.contains(element) else {return}
            partialResult.append(element)
        }
    }
}

extension Date {
    var formattedString: String {
        return string("EEE, d 'of' MMMM yyyy")
    }
}
