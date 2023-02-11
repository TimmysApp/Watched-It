//
//  AuthenticationRoute.swift
//  Watched It?
//
//  Created by Joe Maghzal on 05/02/2023.
//

import Foundation
import NetworkUI
import WatchedItModels

enum AuthenticationRoute: EndPoint {
    case check(email: String)
    case registration(UserCredentials)
    case sendVerification(email: String)
    case verify(OTPVerification)
    case signIn(UserCredentials)
    case refreshToken
    case signOut
    var baseURL: URL? {
        return URL(string: Scheme.current.url)
    }
    var route: URLRoute {
        return URLRoute(from: "authentication")
            .appending {
                switch self {
                    case .check:
                        return "checkEmail"
                    case .registration:
                        return "registration"
                    case .sendVerification:
                        return "sendVerification"
                    case .verify:
                        return "verify"
                    case .signIn:
                        return "signIn"
                    case .refreshToken:
                        return "refreshToken"
                    case .signOut:
                        return "signOut"
                }
            }
    }
    var method: RequestMethod {
        switch self {
            case .check, .registration, .sendVerification, .verify, .signIn, .refreshToken, .signOut:
                return .POST
        }
    }
    var body: JSON? {
        switch self {
            case .check(let email), .sendVerification(let email):
                let searchable = SearchableUser(email: email)
                return .codable(object: searchable)
            case .registration(let data), .signIn(let data):
                return .codable(object: data)
            case .verify(let data):
                return .codable(object: data)
            default:
                return nil
        }
    }
    var headers: [Header] {
        var toReturn = [Header]()
        if body != nil {
            toReturn.append(.content(type: .applicationJson))
        }
        switch self {
            case .refreshToken, .signOut:
                toReturn.append(.authorization(.bearer(token: WatchedIt.storage.authSession?.token ?? "")))
            default:
                break
        }
        return toReturn
    }
}
