//
//  ExploreView.swift
//  Zomato
//
//  Created by Celestial on 20/01/25.
//

import SwiftUI

//MARK: Explore View

struct ExploreView: View {
    var array = [
        "Everyday",
        "Healthy",
        "Plan a party",
        "Gourmet",
        "Gift cards"
    ]
    var body: some View {
        VStack(alignment:.leading){
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing: 5) {
                    ForEach(0...4,id: \.self){index in
                        //                    Rectangle()
                        //                        .frame(width: 90,height: 90)
                        //                        .cornerRadius(10)
                        VStack{
                            Image("\(array[index])")
                                .resizable()
                                .frame(width: 60,height: 50)
                            Text(array[index])
                                .font(.caption)
                        }
                        .frame(width: 90,height: 90)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color(.systemGray4))
                        )
                        
                        
                    }.padding(.leading)
                        
                        
                }
            }
            Spacer()

        }
    }
}

#Preview {
    ExploreView()
}
