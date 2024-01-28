import SwiftUI

struct ContentView: View {
    @StateObject private var foodItemsStore = FoodItemsStore()
    @State private var showModal = false
    @State private var formError = ""
    
    private func resetNewItemState() {
        self.formError = ""
        self.foodItemsStore.createdOrEditedFoodItem = FoodItem(emoji: "", name: "", stars: 0, location: "")
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Foods you liked")) {
                    ForEach(self.foodItemsStore.foodItems) { item in
                        HStack {
                            Text(item.emoji).font(.custom("emoji", fixedSize: 50.0))
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.name).font(.headline).textCase(.uppercase)
                                    Spacer()
                                    ForEach(0 ..< Int(item.stars)) { index in
                                        Text("⭐️").font(.custom("rating", fixedSize: 13.0))
                                    }
                                }
                                
                                Text(item.location).font(.subheadline).padding(.top, 1)
                            }
                            Spacer()
                        }.swipeActions {
                            Button(action: {
                                self.foodItemsStore.foodItems = self.foodItemsStore.foodItems.filter {
                                    $0.id != item.id
                                }
                            }) {
                                Text("🗑️ Delete")
                            }
                            .tint(.red)
                            
                            Button(action: {
                                let editItemIndex = self.foodItemsStore.foodItems.firstIndex {
                                    $0.id == item.id
                                }
                                
                                self.foodItemsStore.editedFoodItemIndex = editItemIndex;
                                self.foodItemsStore.createdOrEditedFoodItem = self.foodItemsStore.foodItems[editItemIndex!]
                                self.showModal = true
                            }) {
                                Text("✏️ Edit")
                            }
                            .tint(.gray)
                        }
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            self.resetNewItemState()
                            showModal = true
                        }) {
                            Text("➕ Add more items").font(.title3).foregroundStyle(Color.blue)
                        } 
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }.padding()
                }
            }
            .sheet(isPresented: $showModal) {
                Form {
                    TextField("Place Name", text: $foodItemsStore.createdOrEditedFoodItem.name)
                    TextField("Location", text: $foodItemsStore.createdOrEditedFoodItem.location)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(emojis, id: \.self) { emoji in
                                Text(emoji).font(.custom("emoji", size: 51))
                                    .onTapGesture {
                                        self.foodItemsStore.createdOrEditedFoodItem.emoji = emoji
                                    }
                                    .opacity(self.foodItemsStore.createdOrEditedFoodItem.emoji == emoji ? 1.0 : 0.5)
                            }
                        }
                    }
                    Stepper(value: $foodItemsStore.createdOrEditedFoodItem.stars, in: 0...5) {
                        Text("Number of Stars: \(self.foodItemsStore.createdOrEditedFoodItem.stars)")
                    }
        
                    Button(action: {
                        let fooditem = self.foodItemsStore.createdOrEditedFoodItem;
                        
                        if fooditem.name.isEmpty {
                            return self.formError = "Place name is required";
                        }
                        
                        if fooditem.location.isEmpty {
                            return self.formError = "Location is require"
                        }
                        
                        if fooditem.emoji.isEmpty {
                            return self.formError = "Emoji is required"
                        }
                        
                        if fooditem.stars == 0 {
                            return self.formError = "You need at least one star"
                        }
                        
                        if self.foodItemsStore.editedFoodItemIndex != nil {
                            foodItemsStore.foodItems[self.foodItemsStore.editedFoodItemIndex!] = fooditem
                        } else {
                            foodItemsStore.foodItems.append(fooditem);
                        }
                        
                        self.resetNewItemState()
                        self.showModal = false
                    }) {
                        if !self.formError.isEmpty {
                            Text(self.formError).foregroundStyle(.red)
                        }
                        
                        Text("Submit")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
