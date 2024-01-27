import Foundation

struct FoodItem: Identifiable {
    var id = UUID()
    var emoji: String;
    var name: String;
    var stars: Int;
    var location: String;
}

class FoodItemsStore: ObservableObject {
    @Published var foodItems: [FoodItem] = [
        FoodItem(emoji: "🍕", name: "pizza", stars: 5, location: "Litle tony's pizza shop"),
        FoodItem(emoji: "🍔", name: "Hamburger", stars: 10, location: "Big kahonna burger"),
    ]
}
