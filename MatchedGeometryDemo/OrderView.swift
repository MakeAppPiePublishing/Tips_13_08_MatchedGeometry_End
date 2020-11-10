//
//  OrderView.swift
//  MatchedGeometryDemo
//
//  Created by Steven Lipton on 11/8/20.
//
// An exercise file for iOS Development Tips Weekly
// A weekly course on LinkedIn Learning for iOS developers
//  Season 13 (Q01 2021) video 08
//  by Steven Lipton (C)2020, All rights reserved
// Learn more at https://linkedin-learning.pxf.io/YxZgj
//This Week:  Use the `.matchedGeometryEffect`  for move animations betwen views
//  For more code, go to http://bit.ly/AppPieGithub

import SwiftUI

struct OrderView: View {
    let columns = Array(repeating:GridItem(spacing:1),count:3)
    let menu = Menu.fullMenu
    @State private var selectedIDs: Set<Menu.ID> = []
    @State private var switched: Bool = true
    @Namespace private var nspace
//MARK:- Main Body
    //Uses computed variables for the views.
    var body: some View {
        VStack {
            titleView
            gridView
            Divider()
            Spacer()
            selectedView
        }
    }
 //MARK:- Actions
    func selectedItem(id:Int){
        selectedIDs.insert(id)
    }
    func deselectedItem(id:Int){
        selectedIDs.remove(id)
    }
    
//MARK: - Subviews
    var titleView: some View{
        HStack{
            if switched{
                Text("Pizza Order").font(.title)
                    .matchedGeometryEffect(id:"title", in: nspace)
                RoundedRectangle(cornerRadius:15).frame(height:60)
                    .foregroundColor(.green)
                    .matchedGeometryEffect(id:"shape", in: nspace)
            } else {
                RoundedRectangle(cornerRadius:15).frame(height:100)
                    .foregroundColor(.blue)
                    .matchedGeometryEffect(id:"shape", in: nspace)
                Text("Pizza Order").font(.title)
                    .matchedGeometryEffect(id:"title", in: nspace)
            }
        }.onTapGesture{
            withAnimation{
                switched.toggle()
            }
        }
    }
    
    
    var gridView: some View{
        LazyVGrid(columns:columns){
            ForEach( Menu.fullMenu.filter { !selectedIDs.contains($0.id) }){ item in
                Button(action:{
                    withAnimation(.easeIn(duration: 1)){
                            selectedItem(id: item.id)
                    }
                })
                {
                    PizzaView(menuItem: item)
                }
                .matchedGeometryEffect(id: item.id, in:nspace)
            }
        }
    }
    
    var selectedView: some View{
        ScrollView(.horizontal){
            HStack{
                ForEach( Menu.fullMenu.filter { selectedIDs.contains($0.id) }){ item in
                    Button(action:{
                        withAnimation(.easeIn(duration: 0.5)){
                            deselectedItem(id: item.id)
                        }
                    })
                    {
                        PizzaView(menuItem: item)
                    }
                    .matchedGeometryEffect(id: item.id, in:nspace)
                }
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
