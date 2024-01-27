import Foundation

var emojis = ["🍕", "🍔", "🍟", "🥪", "🥙", "🍝", "🍜", "🍛", "🍣", "🍫", "🍺", "🥡"]

struct FoodItem: Identifiable {
    var id = UUID()
    var emoji: String;
    var name: String;
    var stars: Int;
    var location: String;
}

class FoodItemsStore: ObservableObject {
    @Published var foodItems: [FoodItem] = []
}
