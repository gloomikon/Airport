struct Company {
    let id: Int
    let name: String
    let description: String
}

extension Company: Decodable { }
