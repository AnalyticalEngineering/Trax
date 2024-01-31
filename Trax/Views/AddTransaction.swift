//
//  AddTransaction.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI
import WidgetKit
import SwiftData

struct AddTransaction: View {
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransaction: Transaction?
    /// Notification Properties
   
    /// View Properties
    @State private var budgetName: String = ""
    @State private var budgetLimit: Double = .zero
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var transactionType: TransactionType = .expense
    /// Random Tint
   
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                  
                
                /// Preview Transaction Card View
                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    amount: amount,
                    dateAdded: dateAdded,
                    transactionType: transactionType.rawValue

                    
                ))
                
                CustomSection("Title", "Magic Keyboard", value: $title)
                
                CustomSection("Remarks", "Apple Product!", value: $remarks)
                
                /// Amount & Category Check Box
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & TransactionType")
                        .font(.caption)
                        .foregroundStyle(.gray)
                      
                    
                    HStack(spacing: 15) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        
                        /// Custom Check Box
                        CategoryCheckBox()
                    }
                })
                
                /// Date Picker
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                      
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            }
            .padding(15)
        }
        .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save", action: save)
            }
        })
        .onAppear(perform: {
            if let editTransaction {
                /// Load All Existing Data from the Transaction
                title = editTransaction.title
                remarks = editTransaction.remarks
                dateAdded = editTransaction.dateAdded
                if let transactionType = editTransaction.rawTransactionType {
                    self.transactionType = transactionType
                }
                amount = editTransaction.amount
               
            }
        })
    }
    
    /// Saving Data
    func save() {
        /// Saving Item to SwiftData
        if editTransaction != nil {
           
            editTransaction?.title = title
            editTransaction?.remarks = remarks
            editTransaction?.amount = amount
            editTransaction?.transactionType = transactionType.rawValue
            editTransaction?.dateAdded = dateAdded
        } else {
            let transaction = Transaction(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, transactionType: transactionType.rawValue)
            context.insert(transaction)
        }
        
        /// Dismissing View
        dismiss()
        ///Update
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
             
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
    
    /// Custom CheckBox
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(TransactionType.allCases, id: \.rawValue) { transactionType in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.transactionType == transactionType {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    
                    Text(transactionType.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.transactionType = transactionType
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
    
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    /// Number Formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

