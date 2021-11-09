//
//  CategoriesModel.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 04/07/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import Foundation
import ObjectMapper

public final class CategoriesResponse: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let ACTIVE_RECORDS = "ACTIVE_RECORDS"
        static let data = "DATA"
        static let message = "message"
        static let RESPONSE_CODE = "RESPONSE_CODE"
    }
    
    // MARK: Properties
    public var ACTIVE_RECORDS: String?
    public var data: [CategoriesData]?
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
        self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [CategoriesData]
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




public final class CategoriesData: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let uuid = "uuid"
        static let title = "title"
        static let file_url = "file_url"
        static let type = "type"
        static let created_at = "created_at"
        static let updated_at = "updated_at"
        static let status = "status"
        static let is_deleted = "is_deleted"
        static let parent_id = "parent_id"
        static let vendor_id = "vendor_id"
        static let title_hi = "title_hi"
        static let offer = "offer"
        static let meta_title = "meta_title"
        static let meta_desc = "meta_desc"
        static let meta_keys = "meta_keys"
        
     
    }
    
    // MARK: Properties
    public var id : String?
    public var uuid : String?
    public var title : String?
    public var file_url : String?
    public var type : String?
    public var created_at: String?
    public var updated_at : String?
    public var status  : String?
    public var is_deleted : String?
    public var parent_id : String?
      public var vendor_id : String?
      public var title_hi : String?
      public var offer: String?
      public var meta_title : String?
      public var meta_desc  : String?
      public var meta_keys : String?
    
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
        title <- map[SerializationKeys.title]
        file_url <- map[SerializationKeys.file_url]
        type <- map[SerializationKeys.type]
        created_at <- map[SerializationKeys.created_at]
        status <- map[SerializationKeys.status]
        is_deleted <- map[SerializationKeys.is_deleted]
        parent_id <- map[SerializationKeys.parent_id]
        title_hi <- map[SerializationKeys.title_hi]
        offer <- map[SerializationKeys.offer]
        meta_title <- map[SerializationKeys.meta_title]
        meta_desc <- map[SerializationKeys.meta_desc]
        meta_keys <- map[SerializationKeys.meta_keys]
        vendor_id <- map[SerializationKeys.vendor_id]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = uuid { dictionary[SerializationKeys.uuid] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = file_url { dictionary[SerializationKeys.file_url] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = created_at { dictionary[SerializationKeys.created_at] = value }
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = is_deleted { dictionary[SerializationKeys.is_deleted] = value }
        if let value = vendor_id { dictionary[SerializationKeys.vendor_id] = value }
        if let value = parent_id { dictionary[SerializationKeys.parent_id] = value }
        if let value = title_hi { dictionary[SerializationKeys.title_hi] = value }
        if let value = offer { dictionary[SerializationKeys.offer] = value }
        if let value = meta_title { dictionary[SerializationKeys.meta_title] = value }
        if let value = meta_desc { dictionary[SerializationKeys.meta_desc] = value }
        if let value = meta_keys { dictionary[SerializationKeys.meta_keys] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
        self.uuid = aDecoder.decodeObject(forKey: SerializationKeys.uuid) as? String
        self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
        self.file_url = aDecoder.decodeObject(forKey: SerializationKeys.file_url) as? String
        self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
        self.created_at = aDecoder.decodeObject(forKey: SerializationKeys.created_at) as? String
        self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
        self.is_deleted = aDecoder.decodeObject(forKey: SerializationKeys.is_deleted) as? String
        self.vendor_id = aDecoder.decodeObject(forKey: SerializationKeys.vendor_id) as? String
        self.parent_id = aDecoder.decodeObject(forKey: SerializationKeys.parent_id) as? String
        self.title_hi = aDecoder.decodeObject(forKey: SerializationKeys.title_hi) as? String
        self.offer = aDecoder.decodeObject(forKey: SerializationKeys.offer) as? String
        self.meta_title = aDecoder.decodeObject(forKey: SerializationKeys.meta_title) as? String
        self.meta_desc = aDecoder.decodeObject(forKey: SerializationKeys.meta_desc) as? String
        self.meta_keys = aDecoder.decodeObject(forKey: SerializationKeys.meta_keys) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(uuid, forKey: SerializationKeys.uuid)
        aCoder.encode(title, forKey: SerializationKeys.title)
        aCoder.encode(file_url, forKey: SerializationKeys.file_url)
        aCoder.encode(type, forKey: SerializationKeys.type)
        aCoder.encode(created_at, forKey: SerializationKeys.created_at)
        aCoder.encode(status, forKey: SerializationKeys.status)
        aCoder.encode(is_deleted, forKey: SerializationKeys.is_deleted)
        aCoder.encode(vendor_id, forKey: SerializationKeys.vendor_id)
        aCoder.encode(parent_id, forKey: SerializationKeys.parent_id)
        aCoder.encode(title_hi, forKey: SerializationKeys.title_hi)
        aCoder.encode(offer, forKey: SerializationKeys.offer)
        aCoder.encode(meta_title, forKey: SerializationKeys.meta_title)
        aCoder.encode(meta_desc, forKey: SerializationKeys.meta_desc)
        aCoder.encode(meta_keys, forKey: SerializationKeys.meta_keys)
    }
    
}
