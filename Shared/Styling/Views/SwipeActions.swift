//
//  SwipeActions.swift
//  Watched It?
//
//  Created by Joe Maghzal on 28/01/2023.
//

import SwiftUI
import STools

public struct SwipeActionsViewModifer: ViewModifier {
    @State private var trailingPadding = CGFloat.zero
    @State private var leadingPadding = CGFloat.zero
    @State private var gesturePaused = false
    internal let itemWidth: CGFloat
    internal var isEnabled: Bool
    internal var actions: [SwipeAction]
    internal let shape: AnyShape?
    private var trailingButtonWidth: CGFloat {
        if trailingPadding == 0 || trailingPadding < itemWidth {
            return itemWidth + 20
        }
        return trailingPadding + 20
    }
    private var leadingButtonWidth: CGFloat {
        if leadingPadding == 0 || leadingPadding < itemWidth {
            return itemWidth + 20
        }
        return leadingPadding + 20
    }
    public func body(content: Content) -> some View {
        ZStack {
            HStack(spacing: 0) {
                ForEach(actions.filter({$0.isLeading})) { item in
                    item.content
                        .buttonStyle(.plain)
                        .padding(.trailing, 20)
                        .foregroundColor(.white)
                        .frame(width: leadingButtonWidth, height: item.height)
                        .background(item.tint)
                        .stateModifier(item.shape != nil) { view in
                            view
                                .clipShape(item.shape!)
                        } .hidden(leadingPadding == 0)
                }
                Spacer()
                ForEach(actions.filter({!$0.isLeading})) { item in
                    item.content
                        .buttonStyle(.plain)
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                        .frame(width: trailingButtonWidth, height: item.height)
                        .background(item.tint)
                        .stateModifier(item.shape != nil) { view in
                            view
                                .clipShape(item.shape!)
                        }.hidden(trailingPadding == 0)
                }
            }
            content
                .disabled(trailingPadding > 0 || leadingPadding > 0)
                .stateModifier(shape != nil) { view in
                    view
                        .clipShape(shape!)
                }.background {
                    Color.white
                        .hidden(trailingPadding == 0 && leadingPadding == 0)
                        .stateModifier(shape != nil) { view in
                            view
                                .clipShape(shape!)
                        }
                }.highPriorityGesture(
                    DragGesture()
                        .onChanged { newValue in
                            guard !gesturePaused && isEnabled else {return}
                            if newValue.translation.width < 0 {
                                guard leadingPadding == 0 else {
                                    withAnimation(.easeInOut) {
                                        leadingPadding = 0
                                    }
                                    gesturePaused = true
                                    return
                                }
                                let newPadding = abs(newValue.translation.width) + trailingPadding
                                guard newPadding < 170 else {return}
                                trailingPadding = newPadding/1.5
                            }else {
                                guard trailingPadding == 0 else {
                                    withAnimation(.easeInOut) {
                                        trailingPadding = 0
                                    }
                                    gesturePaused = true
                                    return
                                }
                                let newPadding = abs(newValue.translation.width) + leadingPadding
                                guard newPadding < 170 else {return}
                                leadingPadding = newPadding/1.5
                            }
                        }.onEnded { value in
                            withAnimation(.easeInOut) {
                                guard !gesturePaused && isEnabled else {
                                    gesturePaused = false
                                    return
                                }
                                trailingPadding = value.translation.width < 0 ? itemWidth: 0
                                leadingPadding = value.translation.width > 0 ? itemWidth: 0
                            }
                        }
                ).padding(.trailing, trailingPadding)
                .padding(.leading, leadingPadding)
                .onChange(of: isEnabled) { newValue in
                    trailingPadding = newValue ? trailingPadding: 0
                    leadingPadding = newValue ? leadingPadding: 0
                }
        }
    }
}

public extension View {
    func onSwipe(width: CGFloat, isEnabled: Bool = true, shape: (any Shape)? = nil, @SwipeActionsResultBuilder actions: () -> [SwipeAction]) -> some View {
        modifier(SwipeActionsViewModifer(itemWidth: width, isEnabled: isEnabled, actions: actions(), shape: shape == nil ? nil: AnyShape(shape!)))
    }
    func swipeContent(edge: HorizontalEdge) -> SwipeAction {
        return SwipeAction(content: AnyView(self), isLeading: edge == .leading, tint: .gray)
    }
}

public struct SwipeAction: Identifiable {
    //MARK: - Properties
    public var id = UUID()
    internal var content: AnyView
    internal var isLeading: Bool
    internal var tint: Color
    internal var shape: AnyShape?
    internal var height: CGFloat?
    internal var action: (() -> Void)?
    //MARK: - Modifiers
    public func with(tint: Color) -> Self {
        return SwipeAction(content: content, isLeading: isLeading, tint: tint, shape: shape, height: height, action: action)
    }
    public func shape(_ shape: any Shape) -> Self {
        return SwipeAction(content: content, isLeading: isLeading, tint: tint, shape: AnyShape(shape), height: height, action: action)
    }
    public func frame(height: CGFloat) -> Self {
        return SwipeAction(content: content, isLeading: isLeading, tint: tint, shape: shape, height: height, action: action)
    }
    public func action(_ action: @escaping () -> Void) -> Self {
        return SwipeAction(content: content, isLeading: isLeading, tint: tint, shape: shape, height: height, action: action)
    }
}
@resultBuilder
public struct SwipeActionsResultBuilder {
    internal static func buildBlock(_ components: SwipeAction...) -> [SwipeAction] {
        return components
    }
    internal static func buildEither(first component: SwipeAction) -> SwipeAction {
        return component
    }
    internal static func buildEither(second component: SwipeAction) -> SwipeAction {
        return component
    }
}

