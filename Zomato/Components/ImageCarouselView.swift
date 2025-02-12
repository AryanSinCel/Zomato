//
//  ListingImageCarouselView.swift
//  AirBNB
//
//  Created by Celestial on 15/01/25.
//

import SwiftUI

//MARK: Image Carousel 
struct ImageCarouselView: View {
    
    var body: some View {
        TabView{
            ForEach(1...4,id: \.self){image in
                Image("img\(image)")
                    .resizable()
//                    .frame(width: 370,height: 250)
                    .scaledToFill()
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    ImageCarouselView()
}
