

import Foundation

struct PopularAPI: Decodable {
    let status: Int
    let response: ResponsePopular?
}

struct ResponsePopular: Decodable {
    let events: [EventsPopular]?
    let user_events: [UserEvents]?
}

struct EventsPopular: Decodable {
    let id: Int
    let status: Int
    let photo: String?
    let name: String?
    let description_raw: String?
    let description_html: String?
    let schedule_start_date: String?
    let schedule_start_time: String?
    let schedule_end_date: String?
    let schedule_end_time: String?
    let going_count: Int
    let went_count: Int
    let venue: VenuePopular?
}

struct VenuePopular: Decodable {
    let id: Int
    let name: String?
    let type: Int
    let description: String?
}

struct UserEvents: Decodable {
    let id: Int
    let event_id: Int
    let user_id: Int
    let status: Int
}
