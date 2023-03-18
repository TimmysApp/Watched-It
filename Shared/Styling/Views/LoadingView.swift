//
//  LoadingView.swift
//  
//
//  Created by Joe Maghzal on 17/03/2023.
//

import SwiftUI
import STools

struct LoadingViewModifier: ViewModifier {
    @State var blurRadius = CGFloat.zero
    @State var currentImage = CurrentImage.star
    let isLoading: Bool
    func body(content: Content) -> some View {
        content
            .disabled(isLoading)
            .stateModifier(isLoading) { view in
                view
                    .blur(radius: 5)
                    .overlay {
                        Image("Mask")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                            .clipped()
                            .blur(radius: 15)
                            .mask {
                                Canvas { context, size in
                                    context.addFilter(.alphaThreshold(min: 0.3))
                                    context.addFilter(.blur(radius: blurRadius >= 20 ? 20 - (blurRadius - 20): blurRadius))
                                    if let resolvedSymbol = context.resolveSymbol(id: 1) {
                                        context.draw(resolvedSymbol, at: CGPoint(x: size.width/2, y: size.height/2), anchor: .center)
                                    }
                                    context.drawLayer { layerContext in
                                        if let resolvedSymbol = context.resolveSymbol(id: 1) {
                                            layerContext.draw(resolvedSymbol, at: CGPoint(x: size.width/2, y: size.height/2), anchor: .center)
                                        }
                                    }
                                }symbols: {
                                    Image(systemName: currentImage.id)
                                        .roundedFont(.custom(50))
                                        .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8), value: currentImage)
                                        .tag(1)
                                }
                            }.shadow(radius: 10)
                            .edgesIgnoringSafeArea(.all)
                            .background(Color.basic.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }.onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
                        move()
                    }.transition(.opacity)
            }
    }
    func move() {
        if blurRadius <= 40 {
            blurRadius += 0.35
        }
        if blurRadius.rounded() == 40 {
            blurRadius = 0
            currentImage.toggle()
        }
    }
    enum CurrentImage: Int, Identifiable, CaseIterable {
        case star = 0
        case starFilled = 1
        var id: String {
            switch self {
                case .star:
                    return "hourglass.start"
                case .starFilled:
                    return "hourglass.end"
            }
        }
        mutating func toggle() {
            if self == .star {
                self = .starFilled
            }else {
                self = .star
            }
        }
    }
}

public extension View {
    func showLoading(_ isLoading: Bool) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
