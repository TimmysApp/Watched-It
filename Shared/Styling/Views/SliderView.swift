//
//  SliderView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/02/2023.
//

import SwiftUI
import STools

public struct SliderView<Content: View>: View {
    @State private var reset = false
    @State private var progress = CGFloat.zero
    private let width: CGFloat
    private var resetOnCompletion = false
    private var text = " "
    private var onCompletion: (() -> Void)?
    private var slider: Content
    private var padding: CGFloat {
        return progress == 0 ? 2.5: progress - 37.5
    }
    private init(width: CGFloat, onCompletion: (() -> Void)?, slider: Content, text: String, resetOnCompletion: Bool) {
        self.width = width
        self.onCompletion = onCompletion
        self.slider = slider
        self.text = text
        self.resetOnCompletion = resetOnCompletion
    }
    public init(width: CGFloat, @ViewBuilder content: () -> Content) {
        self.width = width
        self.slider = content()
    }
    public var body: some View {
        slider
            .gesture(
                DragGesture()
                    .onChanged { newValue in
                        handle(drag: newValue.translation.width)
                    }.onEnded { newValue in
                        handle()
                    }
            ).padding(.leading, padding)
            .pin(to: .leading)
            .frame(width: width, height: 45)
            .background {
                Color.basic.opacity(0.2)
                    .overlay {
                        Text(text)
                            .foregroundColor(.gray)
                            .font(.caption)
                            .fontWeight(.light)
                    }.overlay(alignment: .leading) {
                        Color.basic.opacity(0.5)
                            .frame(width: progress)
                            .clipShape(ConfigurableRoundedRectangle(corners: [.bottomRight, .topRight], radius: progress == width ? 0: 9.5))
                    }.frame(width: width, height: 45)
            }.onChange(of: reset) { _ in
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_00)
                    withAnimation(.spring()) {
                        progress = 0
                    }
                }
            }.frame(width: width, height: 45)
    }
    private func handle(drag: CGFloat? = nil) {
        if let drag {
            let newProgress = (progress == 0 ? 50: progress) + drag
            guard drag > 0, newProgress < width else {
                guard newProgress > width else {return}
                progress = width
                return
            }
            progress = newProgress
        }else {
            guard progress < width else {
                onCompletion?()
                if resetOnCompletion {
                    reset.toggle()
                }
                return
            }
            reset.toggle()
        }
    }
    public func onCompletion(reseting resetOnCompletion: Bool = false, _ onCompletion: @escaping () -> Void) -> Self {
        return SliderView(width: width, onCompletion: onCompletion, slider: slider, text: text, resetOnCompletion: resetOnCompletion)
    }
    public func overlay(text: String) -> Self {
        return SliderView(width: width, onCompletion: onCompletion, slider: slider, text: text, resetOnCompletion: resetOnCompletion)
    }
}
