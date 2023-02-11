//
//  CirclesView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 04/02/2023.
//

import SwiftUI
import STools

struct CirclesView: View {
    let colors = CirclesColors()
    var body: some View {
        VStack {
            Circle()
                .fill(colors.circle1)
                .frame(width: screenWidth/2, height: screenWidth/2)
                .shadow(color: colors.circle1Shadow, radius: 50, x: 0, y: 0)
                .shadow(color: colors.circle1Shadow, radius: 50, x: 0, y: 0)
                .pin(to: .leading)
                .padding(.top, -screenWidth/6)
            Circle()
                .fill(colors.circle2)
                .frame(width: screenWidth/1.5, height: screenWidth/1.5)
                .shadow(color: colors.circle2Shadow, radius: 50, x: 0, y: 0)
                .shadow(color: colors.circle2Shadow, radius: 50, x: 0, y: 0)
                .pin(to: .trailing)
                .padding(.trailing, -50)
                .padding(.top, -50)
            Circle()
                .fill(colors.circle3)
                .frame(width: screenWidth/1.75, height: screenWidth/1.75)
                .shadow(color: colors.circle3Shadow, radius: 50, x: 0, y: 0)
                .shadow(color: colors.circle3Shadow, radius: 50, x: 0, y: 0)
                .pin(to: .leading)
                .padding(.top, -20)
                .padding(.leading, 30)
            Spacer()
        }.blur(radius: 5)
        .background(Color.sheetBackground.gradient).edgesIgnoringSafeArea(.all)
    }
}

struct CirclesView_Preview: PreviewProvider {
    static var previews: some View {
        CirclesView()
    }
}

struct CirclesColors {
    var circle1: LinearGradient {
        LinearGradient(colors: [circle1Shade, Color.basic], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var circle2: LinearGradient {
        LinearGradient(colors: [circle2Shade.opacity(1), Color.basic], startPoint: .bottomLeading, endPoint: .top)
    }
    var circle3: LinearGradient {
        LinearGradient(colors: [circle3Shade, Color.basic], startPoint: .bottomTrailing, endPoint: .topLeading)
    }
    var circle1Shade = Color(hex: "366DD3")
    var circle2Shade = Color(hex: "2280FC")
    var circle3Shade = Color(hex: "F093AE")
    var circle1Shadow = Color(hex: "7FDDF0")
    var circle2Shadow = Color(hex: "FF99AC")
    var circle3Shadow = Color(hex: "8BD0AD")
}
