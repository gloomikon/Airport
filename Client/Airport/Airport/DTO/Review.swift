struct Review {
    let id: Int
    let companyId: Int
    let text: String
    let rating: Int
    let userId: Int
}

extension Review: Decodable { }
