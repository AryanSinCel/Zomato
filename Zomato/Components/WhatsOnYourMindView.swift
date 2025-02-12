//
//  WhatsOnYourMindView.swift
//  Zomato
//
//  Created by Celestial on 20/01/25.
//

import SwiftUI

struct WhatsOnYourMindView: View {
    var array1 = [
        "Cold Drink",
        "Burger",
        "Smoothie",
        "Hot Dog",
        "Chicken Wings",
        "Popcorn",
        "Ice Cream",
    ]
    var array2 = [
        "Pizza",
        "French Fries",
        "Pasta",
        "Paratha",
        "Soda",
        "Fries",
        "Sandwitch",
    ]
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            VStack{
                HStack{
                    ForEach(0..<array1.count,id: \.self){index in
    //                    Rectangle()
    //                        .frame(width: 90,height: 90)
    //                        .cornerRadius(10)
                        VStack{
                            Image(array1[index])
                                .resizable()
                                .frame(width: 60,height: 50)
                            Text(array1[index])
                                .font(.caption)
                        }
                        .frame(width: 90,height: 90)

                    }.padding(.leading)
                }
                HStack{
                    ForEach(0..<array2.count,id: \.self){index in
    //                    Rectangle()
    //                        .frame(width: 90,height: 90)
    //                        .cornerRadius(10)
                        VStack{
                            Image(array2[index])
                                .resizable()
                                .frame(width: 60,height: 50)
                            Text(array2[index])
                                .font(.caption)
                        }
                        .frame(width: 90,height: 90)

                    }.padding(.leading)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    WhatsOnYourMindView()
}
