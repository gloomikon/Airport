struct Place {
    let id: Int
    let name: String
    let planeId: Int
}

extension Place: Decodable { }
