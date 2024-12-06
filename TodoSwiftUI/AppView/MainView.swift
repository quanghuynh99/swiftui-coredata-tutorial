import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationStack {
                Menu().navigationTitle("Menu").navigationBarTitleDisplayMode(.inline)
            }.tabItem {
                Label("Menu", systemImage: "menucard")
            }

            NavigationView {
                Order().navigationTitle("Order").navigationBarTitleDisplayMode(.inline)
            }.tabItem {
                Label("Order", systemImage: "square.and.pencil")
            }
            
            NavigationView {
                TestLayout().navigationTitle("TestLayout").navigationBarTitleDisplayMode(.inline)
            }.tabItem {
                Label("TestLayout", systemImage: "circle.hexagongrid.fill")
            }
        }
        .toolbar(.hidden, for: .automatic)
    }
}

#Preview {
    MainView()
}
