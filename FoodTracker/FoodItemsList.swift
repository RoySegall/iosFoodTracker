import SwiftUI

struct ContentView: View {
    @State private var showModal = false
    @StateObject private var foodItemsStore = FoodItemsStore()
    
    @State private var error = ""
    @State private var placeName = ""
    @State private var emoji = ""
    @State private var location = ""
    @State private var numberOfStars = 0
    
    private func resetNewItemState() {
        self.error = ""
        self.emoji = "";
        self.placeName = ""
        self.numberOfStars = 0
        self.location = ""
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Food")) {
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
                    TextField("Place Name", text: $placeName)
                    TextField("Location", text: $location)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(emojis, id: \.self) { emoji in
                                Text(emoji).font(.custom("emoji", size: 51))
                                    .onTapGesture {
                                        self.emoji = emoji
                                    }
                                    .opacity(self.emoji == emoji ? 1.0 : 0.5)
                            }
                        }
                    }
                    Stepper(value: $numberOfStars, in: 0...5) {
                        Text("Number of Stars: \(numberOfStars)")
                    }
        
                    Button(action: {
                        if self.placeName.isEmpty {
                            return self.error = "Place name is required";
                        }
                        
                        if self.location.isEmpty {
                            return self.error = "Location is require"
                        }
                        
                        if self.emoji.isEmpty {
                            return self.error = "Emoji is required"
                        }
                        
                        if self.numberOfStars == 0 {
                            return self.error = "You need at least one star"
                        }
                        
                        foodItemsStore.foodItems.append(
                            FoodItem(
                                emoji: self.emoji,
                                name: self.placeName,
                                stars: self.numberOfStars,
                                location: self.location
                            )
                        );
                        
                        self.resetNewItemState()
                        self.showModal = false
                    }) {
                        if !self.error.isEmpty {
                            Text(self.error).foregroundStyle(.red)
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
