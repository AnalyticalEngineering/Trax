//
//  Color.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI
import SwiftData



var appTint: Color {
    return Constants.shared.tintColor
}
///DATE FORMATTER
func format(date: Date, format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: date)
}
func currencyString(_ value: Double, allowedDigits: Int = 2) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = allowedDigits
    
    return formatter.string(from: .init(value: value)) ?? ""
}

var currencySymbol: String {
    let locale = Locale.current
    
    return locale.currencySymbol ?? ""
}

func total(_ transactions: [Transaction], transactionType: TransactionType) -> Double {
    return transactions.lazy.filter({ $0.transactionType == transactionType.rawValue }).lazy.reduce(Double.zero) { partialResult, transaction in
        return partialResult + transaction.amount
    }
}
/// Custom Tint Colors For Transaction Row
struct TintColor: Identifiable {
    let id: UUID = .init()
    var color: String
    var value: Color
}
var tints: [TintColor] = [
    .init(color: "Red", value: .red),
    .init(color: "Blue", value: .blue),
    .init(color: "Pink", value: .pink),
    .init(color: "Purple", value: .purple),
    .init(color: "Brown", value: .brown),
    .init(color: "Orange", value: .orange),
]
struct ColorTheme {
    
    let colorAccent = Color("AccentColor")
    let colorSecondaryText = Color("SecondaryTextColor")
    let colorGreen = Color("ColorGreen")
    let colorRed = Color("ColorRed")
    let colorOrange = Color("ColorOrange")
    let colorBlue = Color("ColorBlue")
    let colorGrey = Color("ColorGrey")
    let colorGray = Color("ColorGray")
    let colorBlack = Color("ColorBlack")
    let colorBackground = Color("ColorBackground")
    
}
