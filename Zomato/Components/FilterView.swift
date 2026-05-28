//
//  FilterView.swift
//  Zomato
//
//  Created by Celestial on 21/01/25.
//

import SwiftUI

//MARK: Filter View

struct FilterView: View {
    let filters: [FilterItem]
    
    var body: some View {
           ScrollView(.horizontal, showsIndicators: false) {
               HStack(spacing: 8) {
                   ForEach(filters) { filter in
                       Button(action: filter.action) {
                           HStack(spacing: 4) {
                               if let systemImage = filter.systemImage {
                                   Image(systemName: systemImage)
                               }
                               
                               if let assetImage = filter.assetImage {
                                   Image(assetImage)
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 20, height: 20)
                               }

                               Text(filter.title)
                                   .fontWeight(.medium)

                               if filter.showsChevron {
                                   Image(systemName: "chevron.down")
                                       .font(.caption)
                               }
                           }
                           .padding(.horizontal, 12)
                           .frame(height: 40)
                           .overlay(
                               RoundedRectangle(cornerRadius: 8)
                                   .stroke(.divider, lineWidth: 1)
                           )
                       }
                       .tint(.black)
                   }
               }
               .padding(.horizontal)
               .padding(.vertical, 8)
           }
    }
}

#Preview {
    FilterView(filters: [FilterItem(title: "Sort",
                                   systemImage: "slider.horizontal.3",
                                   showsChevron: true),
                        FilterItem(title: "Rating 4.0+"),
                        FilterItem(title: "Pure Veg"),
                        FilterItem(title: "Gourmet"),
                         FilterItem(title: "Gold offers", assetImage: "goldIcon")
    ])
}
