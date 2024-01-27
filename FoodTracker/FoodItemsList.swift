import SwiftUI

struct ContentView: View {
    @StateObject private var foodItemsStore = FoodItemsStore()
    @State private var isSheetPresented = false
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Fruits")) {
                    ForEach(self.foodItemsStore.foodItems) { item in
                            HStack {
                                Text(item.emoji).font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .textCase(.uppercase)
                                    Text(item.location).font(.subheadline)
                                }
                                Spacer()
                                Text("⭐️")
                            }
                        
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                        }) {
                            Text("➕ Add more items")
                                .font(.title3)
                                .foregroundStyle(Color.blue)
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
