import CoreData
import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isPresented: Bool
    var food: Food?

    @State private var name: String
    @State private var foodDescription: String

    init(food: Food?, isPresented: Binding<Bool>) {
        self.food = food
        _isPresented = isPresented
        _name = State(initialValue: food?.name ?? "")
        _foodDescription = State(initialValue: food?.foodDescription ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Name", text: $name)
                    TextField("Description", text: $foodDescription)
                }
                
                Section {
                    Button("Save") {
                        saveFood()
                    }
                    .disabled(name.isEmpty || foodDescription.isEmpty)
                    
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Food")
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
    
    private func saveFood() {
        if let food = food {
            food.name = name
            food.foodDescription = foodDescription
            do {
                try moc.save()
                isPresented = false
            } catch {
                print("Failed to save changes: \(error)")
            }
        }
    }
}
