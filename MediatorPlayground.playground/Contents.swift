import Foundation

//typealias JSON = [String: Any]
//
struct JSONCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
//
//extension KeyedDecodingContainer {
//
//    private
//    func decode(_ type: [Any].Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [Any] {
//        var values = try nestedUnkeyedContainer(forKey: key)
//        return try values.decode(type)
//    }
//
//    private
//    func decode(_ type: JSON.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [String: Any] {
//        try nestedContainer(keyedBy: JSONCodingKey.self, forKey: key).decode(type)
//    }
//
//    func decode(_ type: JSON.Type) throws -> JSON {
//        var dictionary: JSON = [:]
//        try allKeys.forEach { key in
//            if try decodeNil(forKey: key) {
//                dictionary[key.stringValue] = nil
//            } else if let bool = try? decode(Bool.self, forKey: key) {
//                dictionary[key.stringValue] = bool
//            } else if let string = try? decode(String.self, forKey: key) {
//                dictionary[key.stringValue] = string
//            } else if let int = try? decode(Int.self, forKey: key) {
//                dictionary[key.stringValue] = int
//            } else if let double = try? decode(Double.self, forKey: key) {
//                dictionary[key.stringValue] = double
//            } else if let dict = try? decode([String: Any].self, forKey: key) {
//                dictionary[key.stringValue] = dict
//            } else if let array = try? decode([Any].self, forKey: key) {
//                dictionary[key.stringValue] = array
//            }
//        }
//        return dictionary
//    }
//}
//
//extension UnkeyedDecodingContainer {
//    mutating func decode(_ type: [Any].Type) throws -> [Any] {
//        var elements: [Any] = []
//        while !isAtEnd {
//            if try decodeNil() {
//                elements.append(NSNull())
//            } else if let int = try? decode(Int.self) {
//                elements.append(int)
//            } else if let bool = try? decode(Bool.self) {
//                elements.append(bool)
//            } else if let double = try? decode(Double.self) {
//                elements.append(double)
//            } else if let string = try? decode(String.self) {
//                elements.append(string)
//            } else if let values = try? nestedContainer(keyedBy: JSONCodingKey.self),
//                let element = try? values.decode([String: Any].self) {
//                elements.append(element)
//            } else if var values = try? nestedUnkeyedContainer(),
//                let element = try? values.decode([Any].self) {
//                elements.append(element)
//            }
//        }
//        return elements
//    }
//}
//
//struct FilterJSON: Decodable {
//
//    let json: JSON?
//    init(from decoder: Decoder) throws {
//        json = try? decoder.container(keyedBy: JSONCodingKey.self).decode(JSON.self)
//    }
//}

enum JSON: Decodable {
    case bool(Bool)
    case double(Double)
    case string(String)
    case int(Int)
    case date(Date)
    indirect case array([JSON])
    indirect case dictionary([String: JSON])

    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self = JSON(from: container)
        } else if let container = try? decoder.unkeyedContainer() {
            self = JSON(from: container)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
    }

    private init(from container: KeyedDecodingContainer<JSONCodingKey>) {
        let container = container
        var dict: [String: JSON] = [:]
        for key in container.allKeys {
            if let value = try? container.decode(Bool.self, forKey: key) {
                dict[key.stringValue] = .bool(value)
            } else if let value = try? container.decode(Int.self, forKey: key) {
                dict[key.stringValue] = .int(value)
            } else if let value = try? container.decode(Double.self, forKey: key) {
                dict[key.stringValue] = .double(value)
            } else if let value = try? container.decode(Date.self, forKey: key) {
                dict[key.stringValue] = .date(value)
            } else if let value = try? container.decode(String.self, forKey: key) {
                dict[key.stringValue] = .string(value)
            } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                dict[key.stringValue] = JSON(from: value)
            } else if let value = try? container.nestedUnkeyedContainer(forKey: key) {
                dict[key.stringValue] = JSON(from: value)
            }
        }
        self = .dictionary(dict)
    }

    private init(from container: UnkeyedDecodingContainer) {
        var container = container
        var arr: [JSON] = []
        while !container.isAtEnd {
            if let value = try? container.decode(Bool.self) {
                arr.append(.bool(value))
            } else if let value = try? container.decode(Int.self) {
                arr.append(.int(value))
            } else if let value = try? container.decode(Double.self) {
                arr.append(.double(value))
            } else if let value = try? container.decode(String.self) {
                arr.append(.string(value))
            } else if let value = try? container.decode(Date.self) {
                arr.append(.date(value))
            } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                arr.append(JSON(from: value))
            } else if let value = try? container.nestedUnkeyedContainer() {
                arr.append(JSON(from: value))
            }
        }
        self = .array(arr)
    }
}


struct KeyListQueryResponse: Decodable {
    let filter: JSON
}

extension KeyListQueryResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(KeyListQueryResponse.self, from: data)
    }
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
            guard let data = json.data(using: encoding) else {
                throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
            }
            try self.init(data: data)
        }
}

let json = """
{
  "filter": {
    "key1": {"key5": "bla"},
    "key2": {"key6": [1,2.2,3]},
	"key3": {"key7": "<10"}
  }
}
"""

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

let response = try KeyListQueryResponse.init(json)

func evaluate(_ key: String? = nil, _ expression: JSON) {
    switch expression {
    case let .dictionary(value):
        value.keys.forEach { key in
            evaluate(key, value[key]!)
        }
        break
    case let .string(value):
        print("Key: \(String(describing: key)) String: \(value)")
    case let .array(values):
        values.forEach { value in
            evaluate(key, value)
        }
    case let .double(value):
        print("Double: \(value)")
    case let .int(value):
        print("Int: \(value)")
    default:
        break
    }
}

evaluate("filter", response.filter)
