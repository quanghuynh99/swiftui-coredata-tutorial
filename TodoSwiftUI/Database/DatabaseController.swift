import Foundation
import CoreData

class DatabaseController: ObservableObject {
    let container = NSPersistentContainer(name: "Database")

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
    }
}
