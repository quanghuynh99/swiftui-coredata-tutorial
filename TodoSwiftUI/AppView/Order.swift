import SwiftUI

struct Order: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .padding(.init(top: 0, leading: 0, bottom: 50, trailing: 0))
            Text("Hello, world!")
            Text("asdfasdf asdf asd fasd fasd fasd fasd fasd fasd fas dfasd fasd fasd fasd fasd fasd fasd f")
                .bold().foregroundColor(Color(.systemBlue))
                .padding(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
            
        }
        .padding()
    }
}

#Preview {
    Order()
}
