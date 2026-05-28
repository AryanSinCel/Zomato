//
//  FilterModel.swift
//  Zomato
//
//  Created by Aryan Singh on 12/05/26.
//

import Foundation

//MARK: Filter Model for Reusablity
struct FilterItem: Identifiable{
    let id = UUID()
    let title: String
    let systemImage: String?
    let assetImage: String?
    var showsChevron: Bool = false
    let action: () -> Void
    
    init(
        title: String,
        systemImage: String? = nil,
        assetImage: String? = nil,
        showsChevron: Bool = false,
        action: @escaping () -> Void = {}
    ){
        self.title = title
        self.systemImage = systemImage
        self.showsChevron = showsChevron
        self.action = action
        self.assetImage = assetImage
    }
}
