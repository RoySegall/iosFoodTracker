import SwiftUI

struct ContentView: View {
    @StateObject private var foodItemsStore = FoodItemsStore()
    @State private var showModal = false
    @State private var placeName = ""
    @State private var emoji = ""
    @State private var location = ""
    @State private var numberOfStars = 1

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
                                    ForEach(0 ..< item.stars) { index in
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
                    TextField("Location", text: $location)
                    Stepper(value: $numberOfStars, in: 0...5) {
                        HStack {
                            ForEach(0 ..< self.numberOfStars) { index in
                                Text("⭐️").font(.custom("rating", fixedSize: 13.0))
                            }
                        }
                        
//                        Text("Number of Stars: \(numberOfStars)")
                    }
        
                    Button(action: {
                        foodItemsStore.foodItems.append(
                            FoodItem(
                                emoji: self.emoji,
                                name: self.placeName,
                                stars: self.numberOfStars,
                                location: self.location
                            )
                        );
                        self.showModal = false
                    }) {
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
