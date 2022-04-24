//
//  AnimalDetailCard.swift
//  Petfinder
//
//  Created by Timur Cheberda on 23.04.2022.
//

import SwiftUI

struct AnimalDetailCard: View {
    
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
            Text(value)
                .font(.headline)
        }
        .padding(.vertical)
        .frame(width: 96)
        .background(color.opacity(0.2))
        .foregroundColor(color)
        .cornerRadius(8)
    }
    
}

struct AnimalDetailCard_Previews: PreviewProvider {
    
    static var previews: some View {
        HStack {
            AnimalDetailCard(
                title: "Age",
                value: "Adult",
                color: .green
            )
            AnimalDetailCard(
                title: "Age",
                value: "Baby",
                color: .blue
            )
        }
    }
    
}

extension Color {
    
    func darken(_ amount: Double) -> Color {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let darkenedUIColor =
        UIColor(
            red: min(red - amount / 100, 1.0),
            green: min(green - amount / 100, 1.0),
            blue: min(blue - amount / 100, 1.0),
            alpha: 1.0)
        return Color(darkenedUIColor)
    }
    
}
