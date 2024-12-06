import SwiftUI

struct Setting: View {
    var body: some View {
        List {
            Section {
                HStack(spacing: 15) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Your Name")
                            .font(.headline)
                        Text("Apple ID, iCloud, Media & Purchases")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            Section(header: Text("GENERAL")) {
                NavigationLink(destination: Text("Wi-Fi Settings")) {
                    HStack {
                        Image(systemName: "wifi")
                            .foregroundColor(.blue)
                        Text("Wi-Fi")
                    }
                }
                NavigationLink(destination: Text("Bluetooth Settings")) {
                    HStack {
                        Image(systemName: "wave.3.left.circle.fill")
                            .foregroundColor(.blue)
                        Text("Bluetooth")
                    }
                }
            }
            Section(header: Text("NOTIFICATIONS")) {
                NavigationLink(destination: Text("Notification Settings")) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.red)
                        Text("Notifications")
                    }
                }
            }
            Section(header: Text("ACCOUNT & PRIVACY")) {
                NavigationLink(destination: Text("Privacy Settings")) {
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.gray)
                        Text("Privacy")
                    }
                }
            }

            Section {
                NavigationLink(destination: Text("About")) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.gray)
                        Text("About")
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .listStyle(InsetGroupedListStyle())
    }
}

#Preview {
    Setting()
}
