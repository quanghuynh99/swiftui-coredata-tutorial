import Combine
import SwiftUI

class TestLayoutViewModel: ObservableObject {
    @Published var items: [RandomItem] = []
    private var isLoading = false
    private var nextIndex = 1

    init() {
        loadMoreItems()
    }

    func loadMoreItems() {
        guard !isLoading else { return }
        isLoading = true

        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let newItems = (0 ..< 10).map { index in
                RandomItem(
                    imageUrl: URL(string: "https://picsum.photos/id/\(self.nextIndex + index)/200/300")!,
                    text: "Random Text \(self.nextIndex + index)"
                )
            }
            DispatchQueue.main.async {
                self.items.append(contentsOf: newItems)
                self.nextIndex += 10
                self.isLoading = false
            }
        }
    }
}
