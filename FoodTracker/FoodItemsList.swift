import SwiftUI

struct ContentView: View {
    @StateObject private var foodItemsStore = FoodItemsStore()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Fruits")) {
                    ForEach(self.foodItemsStore.foodItems) { item in
                        HStack {
                            Text(item.emoji).font(.custom("emoji", fixedSize: 50.0))
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.name).font(.headline).textCase(.uppercase)
                                    Spacer()
                                    ForEach(0 ..< 5) { index in
                                        Text("⭐️").font(.custom("rating", fixedSize: 15.0))
                                    }
                                }
                                
                                Text(item.location).font(.subheadline).padding(.top, 1)
                            }
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Text("➕ Add more items").font(.title3).foregroundStyle(Color.blue)
                        } 
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
