import CoreData
import SwiftUI

struct EditFoodView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var isPresented: Bool
    @StateObject private var viewModel: EditFootViewModel
    private var food: Food?

    init(food: Food?, isPresented: Binding<Bool>) {
        self.food = food
        _viewModel = .init(wrappedValue: EditFootViewModel())
        _isPresented = isPresented
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Food Details")) {
                    TextField("Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.foodDescription)
                }

                Section {
                    Button("Save") {
                        viewModel.saveFood()
                        isPresented = false
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.foodDescription.isEmpty)

                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Edit Food")
            .navigationBarItems(trailing: Button("Done") {
                viewModel.saveFood()
                isPresented = false
            })
        }
        .onAppear {
            viewModel.setup(moc: moc, food: food)
        }
    }

}
