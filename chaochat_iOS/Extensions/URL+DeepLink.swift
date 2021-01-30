//
//  URL+DeepLink.swift
//  chaochat_iOS
//
//  Created by 戸高新也 on 2021/01/26.
//

import Foundation

extension URL {
    enum DeepLink {
        case room(roomID: String)
    }
    
    func deeplink() -> DeepLink? {
        guard self.scheme == "chaochat", let host = self.host, let queryUrlComponents = URLComponents(string: self.absoluteString) else {
            return nil
        }
        switch host {
        case "room":
            if let roomID = queryUrlComponents.getParameterValue(for: "roomID") {
                return DeepLink.room(roomID: roomID)
            }
        default:
            return nil
        }
        return nil
    }
}

extension URLComponents {
    func getParameterValue(for parameter: String) -> String? {
        self.queryItems?.first(where: { $0.name == parameter })?.value
    }
}
