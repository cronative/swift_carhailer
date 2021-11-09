//
//  SliderModel.swift
//  CarHailer
//
//  Created by Munjiyasara Nikunj on 30/06/20.
//  Copyright © 2020 Nikunj Munjiyasara. All rights reserved.
//

import Foundation
import ObjectMapper

public final class WalletReponse: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let ACTIVE_RECORDS = "ACTIVE_RECORDS"
        static let data = "DATA"
        static let message = "message"
        static let RESPONSE_CODE = "RESPONSE_CODE"
    }
    
    // MARK: Properties
    public var ACTIVE_RECORDS: String?
    public var data: [WalletData]?
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
        self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [WalletData]
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




public final class WalletData: Mappable, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let uid = "uid"
        static let uuid = "uuid"
        static let first_name = "first_name"
        static let last_name = "last_name"
        static let email = "email"
        static let zip = "zip"
        static let mobile = "mobile"
        static let is_mobile_no_activated = "is_mobile_no_activated"
        static let is_email_activated = "is_email_activated"
        static let message = "message"
        static let myreferralcode = "myreferralcode"
        static let referral_bonus = "referral_bonus"
        static let created_at = "created_at"
        static let description = "DESCRIPTION"
        
    }
    
    // MARK: Properties
    public var uid : String?
    public var uuid : String?
    public var first_name : String?
    public var last_name : String?
    public var email : String?
    public var zip: String?
    public var mobile : String?
    public var is_mobile_no_activated  : String?
    public var is_email_activated : String?
    public var message : String?
    public var myreferralcode : String?
    public var referral_bonus : String?
    public var created_at : String?
    public var description : String?
    
    
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
        first_name <- map[SerializationKeys.first_name]
        last_name <- map[SerializationKeys.last_name]
        email <- map[SerializationKeys.email]
        zip <- map[SerializationKeys.zip]
        mobile <- map[SerializationKeys.mobile]
        is_mobile_no_activated <- map[SerializationKeys.is_mobile_no_activated]
        is_email_activated <- map[SerializationKeys.is_email_activated]
        message <- map[SerializationKeys.message]
        myreferralcode <- map[SerializationKeys.myreferralcode]
        referral_bonus <- map[SerializationKeys.referral_bonus]
        created_at <- map[SerializationKeys.created_at]
               description <- map[SerializationKeys.description]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = uid { dictionary[SerializationKeys.uid] = value }
        if let value = uuid { dictionary[SerializationKeys.uuid] = value }
        if let value = first_name { dictionary[SerializationKeys.first_name] = value }
        if let value = last_name { dictionary[SerializationKeys.last_name] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = zip { dictionary[SerializationKeys.zip] = value }
        if let value = mobile { dictionary[SerializationKeys.mobile] = value }
        if let value = is_mobile_no_activated { dictionary[SerializationKeys.is_mobile_no_activated] = value }
        if let value = is_email_activated { dictionary[SerializationKeys.is_email_activated] = value }
        if let value = message { dictionary[SerializationKeys.message] = value }
        if let value = myreferralcode { dictionary[SerializationKeys.myreferralcode] = value }
        if let value = referral_bonus { dictionary[SerializationKeys.referral_bonus] = value }
        if let value = created_at { dictionary[SerializationKeys.created_at] = value }
        if let value = description { dictionary[SerializationKeys.description] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.uid = aDecoder.decodeObject(forKey: SerializationKeys.uid) as? String
        self.uuid = aDecoder.decodeObject(forKey: SerializationKeys.uuid) as? String
        self.first_name = aDecoder.decodeObject(forKey: SerializationKeys.first_name) as? String
        self.last_name = aDecoder.decodeObject(forKey: SerializationKeys.last_name) as? String
        self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
        self.zip = aDecoder.decodeObject(forKey: SerializationKeys.zip) as? String
        self.mobile = aDecoder.decodeObject(forKey: SerializationKeys.mobile) as? String
        self.is_mobile_no_activated = aDecoder.decodeObject(forKey: SerializationKeys.is_mobile_no_activated) as? String
        self.is_email_activated = aDecoder.decodeObject(forKey: SerializationKeys.is_email_activated) as? String
        self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
        self.myreferralcode = aDecoder.decodeObject(forKey: SerializationKeys.myreferralcode) as? String
        self.referral_bonus = aDecoder.decodeObject(forKey: SerializationKeys.referral_bonus) as? String
        self.created_at = aDecoder.decodeObject(forKey: SerializationKeys.created_at) as? String
               self.description = aDecoder.decodeObject(forKey: SerializationKeys.description) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: SerializationKeys.uid)
        aCoder.encode(uuid, forKey: SerializationKeys.uuid)
        aCoder.encode(first_name, forKey: SerializationKeys.first_name)
        aCoder.encode(last_name, forKey: SerializationKeys.last_name)
        aCoder.encode(email, forKey: SerializationKeys.email)
        aCoder.encode(zip, forKey: SerializationKeys.zip)
        aCoder.encode(mobile, forKey: SerializationKeys.mobile)
        aCoder.encode(is_mobile_no_activated, forKey: SerializationKeys.is_mobile_no_activated)
        aCoder.encode(is_email_activated, forKey: SerializationKeys.is_email_activated)
        aCoder.encode(message, forKey: SerializationKeys.message)
        aCoder.encode(myreferralcode, forKey: SerializationKeys.myreferralcode)
        aCoder.encode(referral_bonus, forKey: SerializationKeys.referral_bonus)
        aCoder.encode(created_at, forKey: SerializationKeys.created_at)
               aCoder.encode(description, forKey: SerializationKeys.description)
    }
    
}
