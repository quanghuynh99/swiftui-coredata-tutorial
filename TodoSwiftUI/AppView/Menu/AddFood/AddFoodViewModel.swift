import Combine
import CoreData
import Foundation
import SwiftUI

class AddFoodViewModel: ObservableObject {
    private var moc: NSManagedObjectContext?

    @Published var foodImage: UIImage? = nil
    @Published var foodName: String = ""
    @Published var foodDescription: String = ""
    @Published var isPickerPresented: Bool = false

    @Published var isAddButtonDisabled: Bool = true

    private var cancellables = Set<AnyCancellable>()

    init() {
        $foodName
            .map { $0.isEmpty }
            .assign(to: \.isAddButtonDisabled, on: self)
            .store(in: &cancellables)
    }

    func setup(moc: NSManagedObjectContext) {
        self.moc = moc
    }

    func addFood(completion: @escaping (Bool) -> Void) {
        guard let moc else {
            completion(false)
            return
        }
        let newFood = Food(context: moc)
        newFood.id = UUID()
        newFood.name = foodName
        newFood.foodDescription = foodDescription
        newFood.imageData = foodImage?.jpegData(compressionQuality: 1.0)

        do {
            try moc.save()
            completion(true)
        } catch {
            print("Error saving food: \(error.localizedDescription)")
            completion(false)
        }
    }
}
