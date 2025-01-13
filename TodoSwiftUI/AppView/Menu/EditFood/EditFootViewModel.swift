import CoreData
import Foundation

public class EditFootViewModel: ObservableObject {
    private var moc: NSManagedObjectContext?
    private var food: Food?
    @Published var name: String = ""
    @Published var foodDescription: String = ""

    public init() {}

    func setup(moc: NSManagedObjectContext, food: Food?) {
        self.moc = moc
        self.food = food
        name = food?.name ?? ""
        foodDescription = food?.foodDescription ?? ""
    }

    func saveFood() {
        if let food = food {
            food.name = name
            food.foodDescription = foodDescription
            do {
                try moc?.save()
            } catch {
                print("Failed to save changes: \(error)")
            }
        }
    }
}
