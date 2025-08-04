import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            // Сам прямоугольник
            Rectangle()
                .fill(Color(hex: "0000FF").opacity(0.75))
                .frame(maxWidth: .infinity, maxHeight: 128)
            
                // 1) Иконка в левом-верхнем углу
                .overlay(
                    Image("Left Corner Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128, height: 128),
                    alignment: .topLeading
                )
            
                // 2) Текст по центру сверху
                .overlay(
                    Text("URAL WINGS AIRLINES")
                        .font(.system(size: min(geometry.size.height * 0.9, 40)))
                        .font(.custom("Arial", size: min(geometry.size.height * 0.9, 40)))
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.center)
                        .padding(.top,  (128 - min(geometry.size.height * 0.9, 40)) / 2),
                    alignment: .top
                )
            
            Spacer()
        }
    }
}

// Ваша реализация Color из hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
