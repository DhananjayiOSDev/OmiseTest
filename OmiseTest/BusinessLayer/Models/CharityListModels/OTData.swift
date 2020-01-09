//
//  OTData.swift
//
//  Created by Dhananjay on 09/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class OTData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kOTDataInternalIdentifierKey: String = "id"
  private let kOTDataNameKey: String = "name"
  private let kOTDataLogoUrlKey: String = "logo_url"

  // MARK: Properties
  public var internalIdentifier: Int?
  public var name: String?
  public var logoUrl: String?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    internalIdentifier = json[kOTDataInternalIdentifierKey].int
    name = json[kOTDataNameKey].string
    logoUrl = json[kOTDataLogoUrlKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = internalIdentifier { dictionary[kOTDataInternalIdentifierKey] = value }
    if let value = name { dictionary[kOTDataNameKey] = value }
    if let value = logoUrl { dictionary[kOTDataLogoUrlKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.internalIdentifier = aDecoder.decodeObject(forKey: kOTDataInternalIdentifierKey) as? Int
    self.name = aDecoder.decodeObject(forKey: kOTDataNameKey) as? String
    self.logoUrl = aDecoder.decodeObject(forKey: kOTDataLogoUrlKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(internalIdentifier, forKey: kOTDataInternalIdentifierKey)
    aCoder.encode(name, forKey: kOTDataNameKey)
    aCoder.encode(logoUrl, forKey: kOTDataLogoUrlKey)
  }

}
