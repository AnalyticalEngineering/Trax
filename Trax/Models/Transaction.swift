//
//  Transaction.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI
import SwiftData

@Model
class Transaction: Codable {
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date = Date.now
    var transactionType: String
  
    
    init(
        title: String,
        remarks: String,
        amount: Double,
        dateAdded: Date = Date.now,
        transactionType: String
       
    ) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.transactionType = transactionType
       
    }
     
    /// Conforming Codable Protocol
    enum CodingKeys: CodingKey {
        
        case title
        case remarks
        case amount
        case dateAdded
        case transactionType
        case tintColor
    }

required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decode(String.self, forKey: .title)
    remarks = try container.decode(String.self, forKey: .remarks)
    amount = try container.decode(Double.self, forKey: .amount)
    dateAdded = try container.decode(Date.self, forKey: .dateAdded)
    transactionType = try container.decode(String.self, forKey: .transactionType)
  
}

func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(title, forKey: .title)
    try container.encode(remarks, forKey: .remarks)
    try container.encode(amount, forKey: .amount)
    try container.encode(dateAdded, forKey: .dateAdded)
    try container.encode(transactionType, forKey: .transactionType)

}

/// Extracting Color Value from tintColor String

@Transient
var rawTransactionType: TransactionType? {
    return TransactionType.allCases.first(where: { transactionType == $0.rawValue })
}
}

