//
//  WhatAreYouLookingForView.swift
//  Zomato
//
//  Created by Celestial on 21/01/25.
//

import SwiftUI

struct WhatAreYouLookingForView: View {
    var array = [[
        "Cozy Winter Dates",
        "Breakfast",
        "Premium Dining"],
        ["Cafes",
        "Family Dining",
        "Buffet"]
    ]
    var body: some View {
        VStack{
            ForEach(0...1,id: \.self){ind in
                HStack{
                    ForEach(1...3,id:\.self){index in
                        VStack{
                            Image("img\(index)")
                                .resizable()
                                .frame(width: 120,height: 150)
                                .cornerRadius(20)
                            Text(array[ind][index-1])
                                .foregroundStyle(Color.white)
                                .padding(EdgeInsets(top: -60, leading: 10, bottom: 0, trailing: 0))
                        }
                    }
                }
            }
        }
      
        .padding(10)
    }
}

#Preview {
    WhatAreYouLookingForView()
}
