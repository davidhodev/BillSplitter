//
//  receiptModel.swift
//  BillSplitter
//
//  Created by David Ho on 4/2/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
class receiptModel {
    var itemsList: [itemModel]
    var membersList: [memberModel]
    
    init() {
        self.itemsList = []
        self.membersList = [memberModel(name: "Me", price: 0)]
    }
    
    func getItems() -> [itemModel] {
        return itemsList
    }
    
    func addItem(name: String, price: Double) {
        itemsList.append(itemModel(name: name, price: price))
    }
    
    func deleteItem(index: Int) {
        itemsList.remove(at: index)
    }
    
    func getMembers() -> [memberModel] {
        return membersList
    }
    
    func addMember(name: String) {
        membersList.append(memberModel(name: name, price: 0))
    }
    
    func deleteMember(index: Int) {
        membersList.remove(at: index)
    }
    
    func recalculateMembersCost() {
        for _ in itemsList {
                    for member in membersList {
                        if member.items.count > 0 {
                            for memberItemindex in 0...member.items.count - 1 {
                                member.items[memberItemindex].numberOfPeopleOwned = 0
                            }
                        }
                    }
                }
        
        
        for item in itemsList {
            for member in membersList {
                if member.items.count > 0 {
                    for memberItemindex in 0...member.items.count - 1 {
                        if member.items[memberItemindex] == item {
                            member.items[memberItemindex].numberOfPeopleOwned += 1
                        }
                    }
                }
            }
        }
    }
    
    func calculateAmountOwed() {
        for member in membersList {
            var amount: Double = 0

            for item in member.items {
                if item.numberOfPeopleOwned != 0 {
                    amount +=  item.price/Double(integerLiteral: Int64(item.numberOfPeopleOwned))
                }
                else {
                    amount += item.price
                }
            }
            member.amountOwed = amount
        }
    }
}
