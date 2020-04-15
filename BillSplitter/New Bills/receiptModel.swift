//
//  receiptModel.swift
//  BillSplitter
//
//  Created by David Ho on 4/2/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
class receiptModel: Codable {
    var itemsList: [itemModel]
    var membersList: [memberModel]
    var restaurantName: String?
    
    init() {
        self.itemsList = []
        self.membersList = [memberModel(name: "Me", price: 0)]
    }
    
    init(coder aDecoder: NSCoder!) {
        self.itemsList = aDecoder.decodeObject(forKey: "itemsList") as! [itemModel]
        self.membersList = aDecoder.decodeObject(forKey: "membersList") as! [memberModel]
    }
    
    func initWithCoder(aDecoder: NSCoder) -> receiptModel {
        self.itemsList = aDecoder.decodeObject(forKey: "itemsList") as! [itemModel]
        self.membersList = aDecoder.decodeObject(forKey: "membersList") as! [memberModel]
        if var resName = self.restaurantName {
            resName = aDecoder.decodeObject(forKey: "restaurant") as! String
        }
        
        return self
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encode(self.itemsList, forKey: "itemsList")
        aCoder.encode(self.membersList, forKey: "membersList")
        
        if let resName = self.restaurantName {
            aCoder.encode(resName, forKey: "restaurant")
        }
        
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
    
    func addRestaurant(restaurant: String) {
        self.restaurantName = restaurant
    }
}
