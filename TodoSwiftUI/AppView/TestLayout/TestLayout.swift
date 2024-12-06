import Foundation
import SwiftUI

struct RandomItem: Identifiable, Equatable {
    let id = UUID()
    let imageUrl: URL
    let text: String
}

struct TestLayout: View {
    @StateObject private var viewModel = TestLayoutViewModel()

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.items) { item in
                    RandomRow(item: item)
                        .onAppear {
                            if item == viewModel.items.last {
                                viewModel.loadMoreItems()
                            }
                        }
                }
                if viewModel.items.isEmpty {
                    ProgressView("Loading...")
                }
            }
        }
        .padding()
    }
}

struct RandomRow: View {
    let item: RandomItem
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: item.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            Text(item.text)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

#Preview {
    TestLayout()
}
