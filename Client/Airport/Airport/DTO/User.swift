struct User: Decodable {
    let id: Int
    let name: String
    let surname: String
    let login: String
    let passportNumber: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case surname
        case login
        case passportNumber
        case password
    }
}
