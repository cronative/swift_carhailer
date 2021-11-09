//
//  CategoriesModel.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 04/07/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import Foundation
import ObjectMapper

public final class ProductsResponse: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let ACTIVE_RECORDS = "ACTIVE_RECORDS"
        static let data = "DATA"
        static let message = "message"
        static let RESPONSE_CODE = "RESPONSE_CODE"
    }
    
    // MARK: Properties
    public var ACTIVE_RECORDS: String?
    public var data: [ProductsData]?
    public var message: String?
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
        message <- map[SerializationKeys.message]
        RESPONSE_CODE <- map[SerializationKeys.RESPONSE_CODE]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = ACTIVE_RECORDS { dictionary[SerializationKeys.ACTIVE_RECORDS] = value }
        if let value = data { dictionary[SerializationKeys.data] = value }
        if let value = message { dictionary[SerializationKeys.message] = value }
        if let value = RESPONSE_CODE { dictionary[SerializationKeys.RESPONSE_CODE] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.ACTIVE_RECORDS = aDecoder.decodeObject(forKey: SerializationKeys.ACTIVE_RECORDS) as? String
        self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [ProductsData]
        self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
        self.RESPONSE_CODE = aDecoder.decodeObject(forKey: SerializationKeys.RESPONSE_CODE) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ACTIVE_RECORDS, forKey: SerializationKeys.ACTIVE_RECORDS)
        aCoder.encode(data, forKey: SerializationKeys.data)
        aCoder.encode(message, forKey: SerializationKeys.message)
        aCoder.encode(RESPONSE_CODE, forKey: SerializationKeys.RESPONSE_CODE)
    }
    
}




public final class ProductsData: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let uuid = "uuid"
        static let vendor_id = "vendor_id"
        static let title = "title"
        static let title_hi = "title_hi"
        static let custom_url = "custom_url"
        static let description = "description"
        static let description_hi = "description_hi"
        static let meta_title = "meta_title"
        static let meta_desc = "meta_desc"
        static let meta_keys = "meta_keys"
        static let created_at = "created_at"
        static let updated_at = "updated_at"
        static let status = "status"
        static let is_deleted = "is_deleted"
        static let category = "category"
        static let file_url = "file_url"
        static let features = "features"
    }
    
    // MARK: Properties
   
    
    
    public var id : String?
    public var uuid : String?
    public var vendor_id : String?
    public var title : String?
    public var title_hi : String?
    public var custom_url : String?
    public var description : String?
    public var description_hi : String?
    public var meta_title : String?
    public var meta_desc : String?
    public var meta_keys : String?
    public var created_at : String?
    public var updated_at : String?
    public var status : String?
    public var is_deleted : String?
    public var category : String?
    public var file_url : String?
    public var features : [Features]?

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
        id <- map[SerializationKeys.id]
        uuid <- map[SerializationKeys.uuid]
        vendor_id <- map[SerializationKeys.vendor_id]
        title <- map[SerializationKeys.title]
        title_hi <- map[SerializationKeys.title_hi]
        custom_url <- map[SerializationKeys.custom_url]
        description <- map[SerializationKeys.description]
        description_hi <- map[SerializationKeys.description_hi]
        meta_title <- map[SerializationKeys.meta_title]
        meta_desc <- map[SerializationKeys.meta_desc]
        meta_keys <- map[SerializationKeys.meta_keys]
        created_at <- map[SerializationKeys.created_at]
        updated_at <- map[SerializationKeys.updated_at]
        status <- map[SerializationKeys.status]
        is_deleted <- map[SerializationKeys.is_deleted]
        category <- map[SerializationKeys.category]
        file_url <- map[SerializationKeys.file_url]
        features <- map[SerializationKeys.features]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = uuid { dictionary[SerializationKeys.uuid] = value }
        if let value = vendor_id { dictionary[SerializationKeys.vendor_id] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = title_hi { dictionary[SerializationKeys.title_hi] = value }
        if let value = custom_url { dictionary[SerializationKeys.custom_url] = value }
        if let value = description { dictionary[SerializationKeys.description] = value }
        if let value = description_hi { dictionary[SerializationKeys.description_hi] = value }
        if let value = meta_title { dictionary[SerializationKeys.meta_title] = value }
        if let value = meta_desc { dictionary[SerializationKeys.meta_desc] = value }
        if let value = meta_keys { dictionary[SerializationKeys.meta_keys] = value }
        if let value = created_at { dictionary[SerializationKeys.created_at] = value }
        if let value = updated_at { dictionary[SerializationKeys.updated_at] = value }
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = is_deleted { dictionary[SerializationKeys.is_deleted] = value }
        if let value = category { dictionary[SerializationKeys.category] = value }
        if let value = file_url { dictionary[SerializationKeys.file_url] = value }
        if let value = features { dictionary[SerializationKeys.features] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
        self.uuid = aDecoder.decodeObject(forKey: SerializationKeys.uuid) as? String
        self.vendor_id = aDecoder.decodeObject(forKey: SerializationKeys.vendor_id) as? String
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
        self.title_hi = aDecoder.decodeObject(forKey: SerializationKeys.title_hi) as? String
        self.custom_url = aDecoder.decodeObject(forKey: SerializationKeys.custom_url) as? String
        self.description_hi = aDecoder.decodeObject(forKey: SerializationKeys.description_hi) as? String
        self.description = aDecoder.decodeObject(forKey: SerializationKeys.description) as? String
        self.meta_title = aDecoder.decodeObject(forKey: SerializationKeys.meta_title) as? String
        self.meta_desc = aDecoder.decodeObject(forKey: SerializationKeys.meta_desc) as? String
        self.meta_keys = aDecoder.decodeObject(forKey: SerializationKeys.meta_keys) as? String
        self.created_at = aDecoder.decodeObject(forKey: SerializationKeys.created_at) as? String
        self.updated_at = aDecoder.decodeObject(forKey: SerializationKeys.updated_at) as? String
        self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
        self.is_deleted = aDecoder.decodeObject(forKey: SerializationKeys.is_deleted) as? String
        self.category = aDecoder.decodeObject(forKey: SerializationKeys.category) as? String
        self.file_url = aDecoder.decodeObject(forKey: SerializationKeys.file_url) as? String
        self.features = aDecoder.decodeObject(forKey: SerializationKeys.features) as? [Features]
     }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(uuid, forKey: SerializationKeys.uuid)
        aCoder.encode(vendor_id, forKey: SerializationKeys.vendor_id)
        aCoder.encode(title, forKey: SerializationKeys.title)
        aCoder.encode(title_hi, forKey: SerializationKeys.title_hi)
        aCoder.encode(custom_url, forKey: SerializationKeys.custom_url)
        aCoder.encode(description_hi, forKey: SerializationKeys.description_hi)
        aCoder.encode(description, forKey: SerializationKeys.description)
        aCoder.encode(meta_title, forKey: SerializationKeys.meta_title)
        aCoder.encode(meta_desc, forKey: SerializationKeys.meta_desc)
        aCoder.encode(meta_keys, forKey: SerializationKeys.meta_keys)
        aCoder.encode(created_at, forKey: SerializationKeys.created_at)
        aCoder.encode(updated_at, forKey: SerializationKeys.updated_at)
        aCoder.encode(status, forKey: SerializationKeys.status)
        aCoder.encode(is_deleted, forKey: SerializationKeys.is_deleted)
        aCoder.encode(category, forKey: SerializationKeys.category)
        aCoder.encode(file_url, forKey: SerializationKeys.file_url)
        aCoder.encode(features, forKey: SerializationKeys.features)
    }
}





public final class Features: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let product_id = "product_id"
        static let variant_name = "variant_name"
        static let variant_value = "variant_value"
        static let sku = "sku"
        static let stock_total = "stock_total"
        static let wholesale_price = "wholesale_price"
        static let buy_price = "buy_price"
        static let on_sale = "on_sale"
        static let on_sale_price = "on_sale_price"
        static let status = "status"
        static let is_deleted = "is_deleted"
        static let created_at = "created_at"
        static let updated_at = "updated_at"
        static let cart_qty = "cart_qty"
    }
    
    // MARK: Properties
       public var id : String?
       public var product_id : String?
       public var variant_name : String?
       public var variant_value : String?
       public var sku : String?
       public var stock_total : String?
       public var wholesale_price : String?
       public var buy_price : String?
       public var on_sale : String?
       public var on_sale_price : String?
       public var status : String?
       public var is_deleted : String?
       public var created_at : String?
       public var updated_at : String?
       public var cart_qty : String?
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
        id <- map[SerializationKeys.id]
        product_id <- map[SerializationKeys.product_id]
        variant_name <- map[SerializationKeys.variant_name]
        variant_value <- map[SerializationKeys.variant_value]
        sku <- map[SerializationKeys.sku]
        stock_total <- map[SerializationKeys.stock_total]
        wholesale_price <- map[SerializationKeys.wholesale_price]
        buy_price <- map[SerializationKeys.buy_price]
        on_sale <- map[SerializationKeys.on_sale]
        on_sale_price <- map[SerializationKeys.on_sale_price]
        status <- map[SerializationKeys.status]
        is_deleted <- map[SerializationKeys.is_deleted]
        created_at <- map[SerializationKeys.created_at]
        updated_at <- map[SerializationKeys.updated_at]
        cart_qty <- map[SerializationKeys.cart_qty]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = product_id { dictionary[SerializationKeys.product_id] = value }
        if let value = variant_name { dictionary[SerializationKeys.variant_name] = value }
        if let value = variant_value { dictionary[SerializationKeys.variant_value] = value }
        if let value = sku { dictionary[SerializationKeys.sku] = value }
        if let value = stock_total { dictionary[SerializationKeys.stock_total] = value }
        if let value = wholesale_price { dictionary[SerializationKeys.wholesale_price] = value }
        if let value = buy_price { dictionary[SerializationKeys.buy_price] = value }
        if let value = on_sale { dictionary[SerializationKeys.on_sale] = value }
        if let value = on_sale_price { dictionary[SerializationKeys.on_sale_price] = value }
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = is_deleted { dictionary[SerializationKeys.is_deleted] = value }
        if let value = created_at { dictionary[SerializationKeys.created_at] = value }
        if let value = updated_at { dictionary[SerializationKeys.updated_at] = value }
        if let value = cart_qty { dictionary[SerializationKeys.cart_qty] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
        self.product_id = aDecoder.decodeObject(forKey: SerializationKeys.product_id) as? String
        self.variant_name = aDecoder.decodeObject(forKey: SerializationKeys.variant_name) as? String
        self.variant_value = aDecoder.decodeObject(forKey: SerializationKeys.variant_value) as? String
        self.sku = aDecoder.decodeObject(forKey: SerializationKeys.sku) as? String
        self.stock_total = aDecoder.decodeObject(forKey: SerializationKeys.stock_total) as? String
        self.wholesale_price = aDecoder.decodeObject(forKey: SerializationKeys.wholesale_price) as? String
        self.buy_price = aDecoder.decodeObject(forKey: SerializationKeys.buy_price) as? String
        self.on_sale = aDecoder.decodeObject(forKey: SerializationKeys.on_sale) as? String
        self.on_sale_price = aDecoder.decodeObject(forKey: SerializationKeys.on_sale_price) as? String
        self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
        self.is_deleted = aDecoder.decodeObject(forKey: SerializationKeys.is_deleted) as? String
        self.created_at = aDecoder.decodeObject(forKey: SerializationKeys.created_at) as? String
        self.updated_at = aDecoder.decodeObject(forKey: SerializationKeys.updated_at) as? String
        self.cart_qty = aDecoder.decodeObject(forKey: SerializationKeys.cart_qty) as? String
     }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(product_id, forKey: SerializationKeys.product_id)
        aCoder.encode(variant_name, forKey: SerializationKeys.variant_name)
        aCoder.encode(variant_value, forKey: SerializationKeys.variant_value)
        aCoder.encode(sku, forKey: SerializationKeys.sku)
        aCoder.encode(stock_total, forKey: SerializationKeys.stock_total)
        aCoder.encode(wholesale_price, forKey: SerializationKeys.wholesale_price)
        aCoder.encode(buy_price, forKey: SerializationKeys.buy_price)
        aCoder.encode(on_sale, forKey: SerializationKeys.on_sale)
        aCoder.encode(on_sale_price, forKey: SerializationKeys.on_sale_price)
        aCoder.encode(status, forKey: SerializationKeys.status)
        aCoder.encode(is_deleted, forKey: SerializationKeys.is_deleted)
        aCoder.encode(created_at, forKey: SerializationKeys.created_at)
        aCoder.encode(updated_at, forKey: SerializationKeys.updated_at)
        aCoder.encode(cart_qty, forKey: SerializationKeys.cart_qty)
    }
}
