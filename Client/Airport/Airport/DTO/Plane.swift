struct Plane {
    let id: Int
    let name: String
    let companyId: Int
    let capacity: Int
}

extension Plane: Decodable { }
