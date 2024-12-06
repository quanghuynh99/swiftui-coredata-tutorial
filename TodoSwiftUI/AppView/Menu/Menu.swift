import CoreData
import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var foods: FetchedResults<Food>
    @State private var isPresentingAddFood = false
    @State private var selectedFood: Food?
    @State private var isPresentingEditFood = false

    var body: some View {
        VStack {
            List(foods) { food in
                NavigationLink(value: food) {
                    HStack(spacing: 10) {
                        if let imageData = food.imageData, let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading) {
                            Text(food.name ?? "Unknown")
                                .font(.headline)
                            Text(food.foodDescription ?? "No Description")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                }.swipeActions {
                    Button(role: .destructive) {
                        deleteFood(food)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                    Button {
                        selectedFood = food
                        isPresentingEditFood = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
        }
        .background(.clear)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingAddFood = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingAddFood) {
            AddFood()
        }
        .sheet(isPresented: $isPresentingEditFood) {
            EditFoodView(food: selectedFood, isPresented: $isPresentingEditFood)
        }
        .navigationDestination(for: Food.self) { food in
            FoodDetailView(food: food)
        }
    }

    private func deleteFood(_ food: Food) {
        moc.delete(food)
        do {
            try moc.save()
        } catch {
            print("Error deleting food: \(error)")
        }
    }
}

#Preview {
    Menu()
}
