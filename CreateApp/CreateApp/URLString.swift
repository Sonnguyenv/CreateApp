//
//  URLString.swift
//  CreateApp
//
//  Created by Sonnv on 2/12/19.
//  Copyright © 2019 Sonnv. All rights reserved.
//

import Foundation
var ID = 0
struct URlString {
    static let urlBase = "http://172.16.18.91/18175d1_mobile_100_fresher/public/api/v0/"
    static let urlNews = urlBase + "listNews"
    static let urlPopular = urlBase + "listPopularEvents"
    static let urlGetDetailEvent = urlBase + "getDetailEvent"
    static let urlDoFollowVenue = urlBase + "doFollowVenue"
    static let urlDoUpdateEvent = urlBase + "doUpdateEvent"
    static let urlListNearlyEvents = urlBase + "listNearlyEvents"
    static let urlListCategories = urlBase + "listCategories"
    static let urlListEventsByCategory = urlBase + "listEventsByCategory"
    static let urlSearch = urlBase + "search"
    static let urlListMyEvents = urlBase + "listMyEvents"
    static let urlListVenueFollowed = urlBase + "listVenueFollowed"
    static let urlLogin = urlBase + "login"
    static let urlRegister = urlBase + "register"
    static let urlResetPassword = urlBase + "resetPassword"
}

