struct Ticket {
    let id: Int
    let userId: Int
    let placeId: Int
    let flightId: Int
}

extension Ticket: Decodable { }
