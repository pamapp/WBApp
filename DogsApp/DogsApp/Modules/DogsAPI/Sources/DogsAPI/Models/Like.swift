//
// Like.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct Like: Codable, JSONEncodable, Hashable {

    public var id: Int
    public var imageId: String
    public var subId: String

    public init(id: Int, imageId: String, subId: String) {
        self.id = id
        self.imageId = imageId
        self.subId = subId
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case imageId = "image_id"
        case subId = "sub_id"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(imageId, forKey: .imageId)
        try container.encode(subId, forKey: .subId)
    }
}

