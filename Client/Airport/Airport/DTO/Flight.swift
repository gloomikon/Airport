struct Flight {
    let id: Int
    let nameFrom: String
    let nameTo: String
    let dateFrom: String
    let dateTo: String
    let planeId: Int
}

extension Flight: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case nameFrom = "name_from"
        case nameTo = "name_to"
        case dateFrom = "date_from"
        case dateTo = "date_to"
        case planeId
    }
}
