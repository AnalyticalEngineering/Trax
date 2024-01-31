//
//  ContentView.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI
import SwiftData

struct TransactionListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort:\Transaction.title)private var transactions: [Transaction]
    @State private var addTransaction: Bool = false
    @State private var showSideMenu: Bool = false
    @State private var selectedTransactionType: TransactionType = .expense
    
    var body: some View {
        NavigationStack {
            Group {
                if transactions.isEmpty {
                    ContentUnavailableView("Enter transaction.", systemImage: "cloud.sun.bolt")
                } else {
                    List {
                        ForEach(transactions.filter({ $0.transactionType == selectedTransactionType.rawValue })){ transaction in
                            NavigationLink (value: transaction){
                                ///Receipt Card View
                               TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let transaction = transactions[index]
                                context.delete(transaction)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Fiscavis Tracker")
            .toolbar{
                //Side Menu Button
                ToolbarItem(placement: .topBarLeading, content: {
                    ///Button
                    Button(action: {
                        showSideMenu = true
                        HapticManager.notification(type: .success)
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(appTint.gradient, in: .circle)
                            .contentShape(.circle)
                    })
                    
                })
                ///Plus Button
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        addTransaction = true
                        HapticManager.notification(type: .success)
                    }, label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                            .background(appTint.gradient, in: .circle)
                            .contentShape(.circle)
                    })
                    .sheet(isPresented: $addTransaction, content: {
                        AddTransaction()
                            .presentationDetents([.large])
                    })
                })
            }
        }
    }
}
#Preview {
    TransactionListView()
        .modelContainer(for: Transaction.self,  inMemory: true)
}
