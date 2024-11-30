import SwiftUI

@main
struct TodoSwiftUIApp: App {
    @StateObject private var dataController = DatabaseController()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
