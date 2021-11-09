//
//  SliderModel.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 30/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import Foundation
import ObjectMapper

public final class OrdersReponse: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let ACTIVE_RECORDS = "ACTIVE_RECORDS"
        static let data = "DATA"
        static let order_notes = "order_notes"
        static let RESPONSE_CODE = "RESPONSE_CODE"
    }
    
    // MARK: Properties
    public var ACTIVE_RECORDS: String?
    public var data: [OrdersData]?
    public var order_notes: String?
    public var RESPONSE_CODE: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        ACTIVE_RECORDS <- map[SerializationKeys.ACTIVE_RECORDS]
        data <- map[SerializationKeys.data]
        order_notes <- map[SerializationKeys.order_notes]
        RESPONSE_CODE <- map[SerializationKeys.RESPONSE_CODE]
    }
    
    /// Generates updated_at of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = ACTIVE_RECORDS { dictionary[SerializationKeys.ACTIVE_RECORDS] = value }
        if let value = data { dictionary[SerializationKeys.data] = value }
        if let value = order_notes { dictionary[SerializationKeys.order_notes] = value }
        if let value = RESPONSE_CODE { dictionary[SerializationKeys.RESPONSE_CODE] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.ACTIVE_RECORDS = aDecoder.decodeObject(forKey: SerializationKeys.ACTIVE_RECORDS) as? String
        self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [OrdersData]
        self.order_notes = aDecoder.decodeObject(forKey: SerializationKeys.order_notes) as? String
        self.RESPONSE_CODE = aDecoder.decodeObject(forKey: SerializationKeys.RESPONSE_CODE) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ACTIVE_RECORDS, forKey: SerializationKeys.ACTIVE_RECORDS)
        aCoder.encode(data, forKey: SerializationKeys.data)
        aCoder.encode(order_notes, forKey: SerializationKeys.order_notes)
        aCoder.encode(RESPONSE_CODE, forKey: SerializationKeys.RESPONSE_CODE)
    }
    
}




public final class OrdersData: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let uid = "uid"
        static let uuid = "uuid"
        static let order_csv = "order_csv"
        static let address_id = "address_id"
        static let transaction_id = "transaction_id"
        static let payment_method = "payment_method"
        static let order_type = "order_type"
        static let order_status = "order_status"
        static let order_notes = "order_notes"
        static let txn_amount = "txn_amount"
        static let wallet_pay = "wallet_pay"
        static let created_at = "created_at"
        static let updated_at = "updated_at"
        
        
    }
    
    // MARK: Properties
    public var uid : String?
    public var uuid : String?
    public var order_csv : String?
    public var address_id : String?
    public var transaction_id : String?
    public var id: String?
    public var payment_method : String?
    public var order_type  : String?
    public var order_status : String?
    public var order_notes : String?
    public var txn_amount : String?
    public var wallet_pay : String?
    public var created_at : String?
    public var updated_at : String?
    
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        uid <- map[SerializationKeys.uid]
        uuid <- map[SerializationKeys.uuid]
        order_csv <- map[SerializationKeys.order_csv]
        address_id <- map[SerializationKeys.address_id]
        transaction_id <- map[SerializationKeys.transaction_id]
        id <- map[SerializationKeys.id]
        payment_method <- map[SerializationKeys.payment_method]
        order_type <- map[SerializationKeys.order_type]
        order_status <- map[SerializationKeys.order_status]
        order_notes <- map[SerializationKeys.order_notes]
        txn_amount <- map[SerializationKeys.txn_amount]
        wallet_pay <- map[SerializationKeys.wallet_pay]
        created_at <- map[SerializationKeys.created_at]
               updated_at <- map[SerializationKeys.updated_at]
    }
    
    /// Generates updated_at of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = uid { dictionary[SerializationKeys.uid] = value }
        if let value = uuid { dictionary[SerializationKeys.uuid] = value }
        if let value = order_csv { dictionary[SerializationKeys.order_csv] = value }
        if let value = address_id { dictionary[SerializationKeys.address_id] = value }
        if let value = transaction_id { dictionary[SerializationKeys.transaction_id] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = payment_method { dictionary[SerializationKeys.payment_method] = value }
        if let value = order_type { dictionary[SerializationKeys.order_type] = value }
        if let value = order_status { dictionary[SerializationKeys.order_status] = value }
        if let value = order_notes { dictionary[SerializationKeys.order_notes] = value }
        if let value = txn_amount { dictionary[SerializationKeys.txn_amount] = value }
        if let value = wallet_pay { dictionary[SerializationKeys.wallet_pay] = value }
        if let value = created_at { dictionary[SerializationKeys.created_at] = value }
        if let value = updated_at { dictionary[SerializationKeys.updated_at] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.uid = aDecoder.decodeObject(forKey: SerializationKeys.uid) as? String
        self.uuid = aDecoder.decodeObject(forKey: SerializationKeys.uuid) as? String
        self.order_csv = aDecoder.decodeObject(forKey: SerializationKeys.order_csv) as? String
        self.address_id = aDecoder.decodeObject(forKey: SerializationKeys.address_id) as? String
        self.transaction_id = aDecoder.decodeObject(forKey: SerializationKeys.transaction_id) as? String
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
        self.payment_method = aDecoder.decodeObject(forKey: SerializationKeys.payment_method) as? String
        self.order_type = aDecoder.decodeObject(forKey: SerializationKeys.order_type) as? String
        self.order_status = aDecoder.decodeObject(forKey: SerializationKeys.order_status) as? String
        self.order_notes = aDecoder.decodeObject(forKey: SerializationKeys.order_notes) as? String
        self.txn_amount = aDecoder.decodeObject(forKey: SerializationKeys.txn_amount) as? String
        self.wallet_pay = aDecoder.decodeObject(forKey: SerializationKeys.wallet_pay) as? String
        self.created_at = aDecoder.decodeObject(forKey: SerializationKeys.created_at) as? String
               self.updated_at = aDecoder.decodeObject(forKey: SerializationKeys.updated_at) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: SerializationKeys.uid)
        aCoder.encode(uuid, forKey: SerializationKeys.uuid)
        aCoder.encode(order_csv, forKey: SerializationKeys.order_csv)
        aCoder.encode(address_id, forKey: SerializationKeys.address_id)
        aCoder.encode(transaction_id, forKey: SerializationKeys.transaction_id)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(payment_method, forKey: SerializationKeys.payment_method)
        aCoder.encode(order_type, forKey: SerializationKeys.order_type)
        aCoder.encode(order_status, forKey: SerializationKeys.order_status)
        aCoder.encode(order_notes, forKey: SerializationKeys.order_notes)
        aCoder.encode(txn_amount, forKey: SerializationKeys.txn_amount)
        aCoder.encode(wallet_pay, forKey: SerializationKeys.wallet_pay)
        aCoder.encode(created_at, forKey: SerializationKeys.created_at)
               aCoder.encode(updated_at, forKey: SerializationKeys.updated_at)
    }
    
}
