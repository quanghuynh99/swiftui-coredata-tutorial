import SwiftUI

struct FoodDetailView: View {
    @Environment(\.dismiss) var dismiss
    var food: Food?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let food = food {
                    if let imageData = food.imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(12)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    }
                    
                    Text(food.name ?? "Unknown")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    ScrollView {
                        Text(food.foodDescription ?? "No Description")
                            .font(.body)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity)

                    Spacer()
                } else {
                    Text("No Food Selected")
                        .font(.headline)
                }
            }
            .padding()
            .navigationTitle(food?.name ?? "Food Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxHeight: .infinity)
        
    }
}
