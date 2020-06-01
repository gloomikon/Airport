struct User {
    let id: Int
    let name: String
    let surname: String
    let login: String
    let passport: String
    let password: String
}

extension User: Decodable { }

var user: User!
