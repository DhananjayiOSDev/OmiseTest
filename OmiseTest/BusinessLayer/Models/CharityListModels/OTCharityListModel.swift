//
//  OTCharityListModel.swift
//
//  Created by Dhananjay on 09/01/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class OTCharityListModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kOTCharityListModelTotalKey: String = "total"
  private let kOTCharityListModelDataKey: String = "data"

  // MARK: Properties
  public var total: Int?
  public var data: [OTData]?

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
    total = json[kOTCharityListModelTotalKey].int
    if let items = json[kOTCharityListModelDataKey].array { data = items.map { OTData(json: $0) } }
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = total { dictionary[kOTCharityListModelTotalKey] = value }
    if let value = data { dictionary[kOTCharityListModelDataKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.total = aDecoder.decodeObject(forKey: kOTCharityListModelTotalKey) as? Int
    self.data = aDecoder.decodeObject(forKey: kOTCharityListModelDataKey) as? [OTData]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(total, forKey: kOTCharityListModelTotalKey)
    aCoder.encode(data, forKey: kOTCharityListModelDataKey)
  }

}
