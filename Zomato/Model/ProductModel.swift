//
//  ProductModel.swift
//  Zomato
//
//  Created by Celestial on 09/02/25.
//

//MARK: - Product Model
import Foundation
import SwiftUI

//MARK: Dish Model

struct Dish:Identifiable{
    let id = UUID()
    let name:String
    let image:String
    let price:Int
    let rating: Float
    let review: Int
    let description : String
    let mode: String
}


//MARK: Resturant Model
struct Restaurant: Identifiable{
    let id = UUID()
    let name: String
    let rating: String
    let duration: String
    let distance: String
    let foodType: String
    let foodBelong: String
    let priceForOne: String
    let discount: String
    let location : String
    let dishes: [Dish] //one to many relation
}


//MARK: Sample Products

var dishes = [
    Dish(name: "Grilled Chicken", image: "https://b.zmtcdn.com/data/pictures/chains/1/18733781/61344e6a488d7d5b0ff5aef471420b2e.jpg", price: 350, rating: 4.2, review: 180, description: "Jucy grilled chicken served with vegetables and sauce.", mode: "non-veg"),
    Dish(name: "Veg Burrito", image: "https://b.zmtcdn.com/data/dish_photos/7a8/ab8b449fc8a4a52d33d73a7baeb917a8.jpg", price: 250, rating: 4.5, review: 80, description: "A healty Mexican burrito filled with rice, beans and veggies.", mode: "veg"),
    Dish(name: "Pad Thai", image: "https://www.recipetineats.com/tachyon/2018/05/Chicken-Pad-Thai_9.jpg", price: 350, rating: 4.3, review: 200, description: "Authentic Thai stir-fried noodles with peanuts and lime.", mode: "veg"),
    Dish(name: "Spring Rolls", image: "https://mymorningmocha.com/wp-content/uploads/2023/11/vegetable-spring-rolls-recipe.jpg", price: 180, rating: 3.7, review: 90, description: "Crispy rolls filled with vegetables and served with dipping sauce.", mode: "veg"),
    Dish(name: "Margerita Pizza", image: "https://cookieandkate.com/images/2021/07/classic-margherita-pizza.jpg", price: 300, rating: 3.9, review: 150, description: "Classic Margherita pizza with mozzarella and basil.", mode: "veg"),
    Dish(name: "Penne Arrabbiata", image: "https://www.kitchensanctuary.com/wp-content/uploads/2023/07/Penne-alarrabiata-square-FS.jpg", price: 280, rating: 4.7, review: 78, description: "Spicy pasta with tomato sauce and chili flakes.", mode: "veg"),
    Dish(name: "Butter Chicken", image: "https://masalaandchai.com/wp-content/uploads/2022/03/Butter-Chicken.jpg", price: 250, rating: 4.6, review: 120, description: "Delicious creamy butter chicken served with naan.", mode: "non-veg"),
    Dish(name: "Veg Pakora", image: "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/vegetable-pakora-recipe.jpg", price: 150, rating: 4.1, review: 90, description: "Crispy fried vegetable fritters.", mode: "veg")
]

//MARK: Dishes Data
struct StaticData {
    static let restaurants: [Restaurant] = [
        Restaurant(name: "The Postman Kitchen", rating: "4.6", duration: "12", distance: "5", foodType: "North Indian", foodBelong: "Chinese", priceForOne: "300", discount: "30", location: "Sector 12, New Delhi", dishes: [dishes[0],dishes[1]]),
        Restaurant(name: "Bistro 24", rating: "4.2", duration: "15", distance: "6", foodType: "Italian", foodBelong: "Mediterranean", priceForOne: "350", discount: "20",location: "Connaught Place, New Delhi", dishes: [dishes[2],dishes[3]]),
        Restaurant(name: "Spicy Haven", rating: "4.7", duration: "18", distance: "8", foodType: "Indian", foodBelong: "Thai", priceForOne: "450", discount: "25",location: "Khan Market, New Delhi", dishes: [dishes[4],dishes[5]]),
        Restaurant(name: "Urban Grill", rating: "4.2", duration: "10", distance: "4", foodType: "Continental", foodBelong: "Mexican", priceForOne: "280", discount: "15",location: "Saket, New Delhi", dishes: [dishes[6],dishes[7]])
        
    ]
    
    
}
