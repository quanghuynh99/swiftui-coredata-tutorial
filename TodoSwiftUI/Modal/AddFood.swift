import Foundation
import PhotosUI
import SwiftUI

struct AddFood: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc

    @State private var foodImage: UIImage? = nil
    @State private var foodName: String = ""
    @State private var foodDescription: String = ""
    @State private var isPickerPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Food image
                ZStack {
                    if let image = foodImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 4)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 200, height: 200)
                            .overlay(
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                    Text("Tap to select image")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            )
                    }
                }
                .onTapGesture {
                    isPickerPresented = true
                }

                // Food name
                VStack(alignment: .leading, spacing: 8) {
                    Text("Food name").font(.headline)
                    TextField("Enter food name", text: $foodName)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8.0)
                }
                .padding(.horizontal)

                // Food description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description").font(.headline)
                    TextField("Enter description", text: $foodDescription)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                // Add button
                Button(action: {
                    addFood()
                }) {
                    Text("Add food")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(foodName.isEmpty ? Color.gray : Color(uiColor: .systemBlue))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(foodName.isEmpty)
            }
            .padding()
            .navigationTitle("Add Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(image: $foodImage)
        }
    }

    private func addFood() {
        let newFood = Food(context: moc)
        newFood.id = UUID()
        newFood.name = foodName
        newFood.foodDescription = foodDescription
        newFood.imageData = foodImage?.jpegData(compressionQuality: 1.0)

        do {
            try moc.save()
            dismiss()
        } catch {
            print("Error saving food: \(error.localizedDescription)")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }

            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
}

#Preview {
    AddFood()
}
