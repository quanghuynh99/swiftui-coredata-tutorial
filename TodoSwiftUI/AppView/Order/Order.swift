import SwiftUI

struct Order: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
            Text("Hello, world!")
            Text("To be continue...")
                .bold().foregroundColor(Color(.systemBlue))
                .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
        }
        .padding()
    }
}

#Preview {
    Order()
}
