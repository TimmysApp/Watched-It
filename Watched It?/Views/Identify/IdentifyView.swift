//
//  IdentifyView.swift
//  Watched It?
//
//  Created by Joe Maghzal on 09/01/2023.
//

import SwiftUI
import STools
import MediaUI

struct IdentifyView: View {
    @State var config = IdentifyViewConfig()
    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                MediaImage(mediable: $config.mediaItem)
                    .isResizable()
                    .frame(width: screenWidth/2, height: 300)
                    .picker(isPresented: $config.isPresented)
                    .disabledPicker(!config.mediaItem.isEmpty)
                    .placeHolder {
                        ZStack {
                            Image(systemName: "person")
                                .font(.system(size: 240))
                                .fontWeight(.thin)
                            Image(systemName: "viewfinder")
                                .font(.system(size: 270))
                                .fontWeight(.thin)
                            Text("Tap here to Start!")
                                .padding(.top, 15)
                        }.foregroundColor(Color.gray.opacity(0.6))
                    }.clipShape(RoundedRectangle(cornerRadius: config.mediaItem.isEmpty ? 0: 15, style: .continuous))
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 6)
                VStack(spacing: 15) {
                    NavigationLink(value: "Noah Jupe") {
                        HStack {
                            Text("Tom Cavanagh")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.title3.weight(.semibold))
                        }.center(.horizontal)
                            .foregroundColor(.tint)
                            .padding(10)
                            .frame(height: 50)
                            .background(Color.basic.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 17, style: .continuous))
                            .compositingGroup()
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, y: 8)
                            .padding(.horizontal)
                    }
                    HStack {
                        Text("Not what you're looking for?")
                            .font(.callout)
                            .fontWeight(.medium)
                        Button(action: {
                            
                        }) {
                            Text("Report")
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(7)
                                .frame(height: 35)
                                .background(Color.tint)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, y: 8)
                        }
                        Divider()
                            .frame(height: 35)
                        Button(action: {
                            config.togglePin()
                        }) {
                            Image(systemName: "pin")
                                .font(.body.weight(.medium))
                                .padding(7)
                                .frame(height: 35)
                                .background(Color.basic.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .compositingGroup()
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, y: 8)
                        }
                    }
                    Spacer()
                    Button(action: {
                        config.tryAgain()
                    }) {
                        Text("Try Again!")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .center(.horizontal)
                            .padding()
                            .frame(height: 45)
                            .background(Color.tint)
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, y: 8)
                            .padding(.horizontal, 40)
                    }
                }.padding(.vertical)
                .hidden(config.mediaItem.isEmpty)
            }.center(.vertical)
            .center(.horizontal)
            .background(Color.background.gradient)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Label("Suggestions", systemImage: "archivebox.fill") .fontWeight(.medium)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, y: 8)
                    }
                    Button(action: {
                        
                    }) {
                        Label("Report Center", systemImage: "doc.plaintext.fill") .fontWeight(.medium)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.05), radius: 6, y: 8)
                    }
                }
            }.navigationTitle(Text("Identify"))
            .navigationDestination(for: String.self) { name in
                PersonView(name: name)
            }.task(id: config.mediaItem, priority: .high) {
                await config.performIdentification()
            }
        }
    }
}

struct IdentifyView_Previews: PreviewProvider {
    static var previews: some View {
        IdentifyView()
    }
}
