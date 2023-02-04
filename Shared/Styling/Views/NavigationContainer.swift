//
//  NavigationContainer.swift
//  Watched It?
//
//  Created by Joe Maghzal on 31/01/2023.
//

import SwiftUI
import STools

public struct NavigationContainer2: View {
    @State private var isExpanded = false
    private var title = "Recents"
    public var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    titleView
                        .opacity(0)
                    ForEach(0..<100) { _ in
                        Text("osdhlwkhbfehwiflrhwjhrwtjrlwkhtjkrehtrejkhtjretrjkehjbghjtbkerwhjkbterwjhtre")
                    }
                }.background {
                    GeometryReader { proxy -> Color in
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut) {
                                if -proxy.frame(in: .named("scroll")).origin.y > 15 {
                                    isExpanded = true
                                }else {
                                    isExpanded = false
                                }
                            }
                        }
                        return Color.clear
                    }
                }
            }.coordinateSpace(name: "scroll")
            titleView
                .pin(to: .top)
        }
    }
    private var titleView: some View {
        HStack {
            if isExpanded {
                Spacer()
            }
            Text(title)
                .font(isExpanded ? .body: .largeTitle)
                .fontWeight(isExpanded ? .semibold: .bold)
                .shadow(color: Color.darkShadow, radius: 5)
            Spacer()
        }.transition(.slide)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Material.ultraThinMaterial.opacity(isExpanded ? 1: 0))
            .transition(.opacity)
    }
}

public struct NavigationContainer: View {
    @State private var isExpanded = false
    private var title = ""
    private var trailing: AnyView?
    private var content: [NavigationContent]
    public init(@NavigationBuilder content: () -> [NavigationContent]) {
        self.trailing = nil
        self.content = content()
    }
    private init(title: String, trailing: AnyView?, content: [NavigationContent]) {
        self.title = title
        self.trailing = trailing
        self.content = content
    }
    public var body: some View {
        NavigationStack {
            ZStack {
                if let content = content.first(where: {$0.scrollView})?.contentView {
                    ScrollView {
                        VStack(spacing: 0) {
                            titleView
                                .opacity(0)
                            content
                        }.background {
                            GeometryReader { proxy -> Color in
                                DispatchQueue.main.async {
                                    withAnimation(.easeInOut.speed(1.5)) {
                                        if -proxy.frame(in: .named("scroll")).origin.y > 15 {
                                            isExpanded = true
                                        }else {
                                            isExpanded = false
                                        }
                                    }
                                }
                                return Color.clear
                            }
                        }
                    }.coordinateSpace(name: "scroll")
                }else if let content = content.first(where: {$0.list})?.contentView {
                    List {
                        //                    VStack(spacing: 0) {
                        Section {
                            titleView
                                .frame(height: 1)
                                .opacity(0)
                                .background {
                                    GeometryReader { proxy -> Color in
                                        DispatchQueue.main.async {
                                            withAnimation(.easeInOut) {
                                                if -proxy.frame(in: .named("scroll")).origin.y > 1 {
                                                    isExpanded = true
                                                }else {
                                                    isExpanded = false
                                                }
                                            }
                                        }
                                        return Color.clear
                                    }
                                }
                        }.listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(nil)
                            .opacity(0)
                        content
                    }.coordinateSpace(name: "scroll")
                        .padding(.top, -60)
                }else if let content = content.first?.contentView {
                    VStack(spacing: 0) {
                        titleView
                            .opacity(0)
                        content
                    }
                }
                titleView
                    .pin(to: .top)
            }.toolbar(.hidden, for: .navigationBar)
        }
    }
    @ViewBuilder private var titleView: some View {
        let height: CGFloat = isExpanded ? 23: 45
        HStack {
            if isExpanded {
                Spacer()
                    .frame(height: height)
            }
            Text(title)
                .font(isExpanded ? .body: .largeTitle)
                .fontWeight(isExpanded ? .semibold: .bold)
                .shadow(color: Color.darkShadow, radius: 5)
                .frame(height: height)
            Spacer()
                .frame(height: height)
            if let trailing {
                trailing
                    .frame(height: height)
            }
        }.transition(.slide)
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background(Material.ultraThinMaterial.opacity(isExpanded ? 1: 0))
        .transition(.opacity)
    }
}

//MARK: - Public Modifiers
public extension NavigationContainer {
    func navigation(title: String) -> Self {
        return NavigationContainer(title: title, trailing: trailing, content: content)
    }
    func navigation(@ViewBuilder trailing: () -> some View) -> Self {
        return NavigationContainer(title: title, trailing: AnyView(trailing()), content: content)
    }
}

public struct NavigationContent: Identifiable {
    public var id = UUID()
    var contentView: AnyView
    var scrollView = false
    var list = false
}

internal extension View {
    var navigationContent: NavigationContent {
        return NavigationContent(contentView: AnyView(self))
    }
}

internal protocol Scrollable {
    associatedtype ScrollContent: View
    var bodyContent: ScrollContent {get}
    var navigationContent: NavigationContent {get}
}

extension ScrollView: Scrollable {
    var bodyContent: some View {
        return content
    }
    var navigationContent: NavigationContent {
        return NavigationContent(contentView: AnyView(bodyContent), scrollView: true)
    }
}

extension List: Scrollable {
    var bodyContent: some View {
        return self
    }
    var navigationContent: NavigationContent {
        return NavigationContent(contentView: AnyView(bodyContent), list: true)
    }
}

@resultBuilder
public struct NavigationBuilder {
    internal static func buildBlock<Content: View>(_ components: Content...) -> [NavigationContent] {
        return components.map { component in
            if let scrollView = component as? (any Scrollable) {
                return NavigationContent(contentView: AnyView(scrollView.bodyContent), scrollView: true)
            }
            return component.navigationContent
        }
    }
    internal static func buildEither<Content: View>(first component: Content) -> NavigationContent {
        if let scrollView = component as? (any Scrollable) {
            return NavigationContent(contentView: AnyView(scrollView.bodyContent), scrollView: true)
        }
        return component.navigationContent
    }
    internal static func buildEither<Content: View>(second component: Content) -> NavigationContent {
        if let scrollView = component as? (any Scrollable) {
            return scrollView.navigationContent
        }
        return component.navigationContent
    }
}

struct Test: View {
    var body: some View {
        NavigationContainer {
            List {
                ForEach(0..<100) { _ in
                    Text("osdhlwkhbfehwiflrhwjhrwtjrlwkhtjkrehtrejkhtjretrjkehjbghjtbkerwhjkbterwjhtre")
                }
            }
        }.navigation(title: "Recents")
    }
}

//public var body: some View {
    //    ZStack {
    //        List {
    //            //                    VStack(spacing: 0) {
    //            Section {
    //                titleView
    //                    .frame(height: 1)
    //                    .opacity(0)
    //                    .background {
    //                        GeometryReader { proxy -> Color in
    //                            DispatchQueue.main.async {
    //                                withAnimation(.easeInOut) {
    //                                    if -proxy.frame(in: .named("scroll")).origin.y > 1 {
    //                                        isExpanded = true
    //                                    }else {
    //                                        isExpanded = false
    //                                    }
    //                                }
    //                            }
    //                            return Color.clear
    //                        }
    //                    }
    //            }.listRowBackground(Color.clear)
    //                .listRowSeparator(.hidden)
    //                .listRowInsets(nil)
    //                .opacity(0)
    //            content.first(where: {$0.isScrollable})?.contentView
    //
    //        }.coordinateSpace(name: "scroll")
    //            .padding(.top, -60)
    //        //            ForEach(content.filter({!$0.isScrollable})) { content in
    //        //                content.contentView
    //        //            }
    //        titleView
    //            .pin(to: .top)
    //    }
    //    }
