//
//  FilterView.swift
//  Zomato
//
//  Created by Celestial on 21/01/25.
//

import SwiftUI

//MARK: Filter View

struct FilterView: View {
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:0){
                    Button{
                        //
                    }label: {
                        Image(systemName: "slider.horizontal.3")
                        Text("Sort")
//                            .font(.title3)
                            .fontWeight(.medium)
                        Image(systemName: "chevron.down")
                    }
                    .padding(5)
                    .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.divider, lineWidth: 1)
                        )
                    .frame(width: 110,height: 40)
                    .cornerRadius(10)
                    

                Button{
                    //
                }label: {
                    Text("Rating 4.0+")
                        .fontWeight(.medium)
                }
                .padding(5)
                .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.divider, lineWidth: 1)
                    )
                    .frame(width: 110,height: 40)
                    .cornerRadius(10)
                
                Button{
                    //
                }label: {
                    Text("Pure Veg")
                        .fontWeight(.medium)
                }
                .padding(5)
                .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.divider, lineWidth: 1)
                    )
                    .frame(width: 90,height: 40)
                    .cornerRadius(10)
                
                Button{
                    //
                }label: {
                    Text("Gourmet")
                        .fontWeight(.medium)
                }
                .padding(5)
                .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.divider, lineWidth: 1)
                    )
                    .frame(width: 90,height: 40)
                    .cornerRadius(10)
                
                Button{
                    //
                }label: {
                    Text("Cuisines")
                        .fontWeight(.medium)
                    Image(systemName: "chevron.down")
                }
                .padding(5)
                .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.divider, lineWidth: 1)
                    )
                    .frame(width: 110,height: 40)
                    .cornerRadius(10)
            }
            .tint(.black)
            .padding()

            
        }
    }
}

#Preview {
    FilterView()
}
