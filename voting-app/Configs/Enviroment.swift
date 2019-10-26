//
//  Enviroment.swift
//  voting-app
//
//  Created by Kamaal Farah on 26/10/2019.
//  Copyright © 2019 Kamaal. All rights reserved.
//


import Foundation


public enum Environment {
    // MARK: - Keys
    enum Keys {
      enum Plist {
        static let apiUrl = "API_URL"
        static let webUrl = "WEB_URL"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
        fatalError("Plist file not found")
        }

        return dict
    }()

    // MARK: - Plist values
    static let apiUrl: String = {
        guard let apiUrlString = Environment.infoDictionary[Keys.Plist.apiUrl] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }

        return apiUrlString
    }()
    
    static let webUrl: String = {
        guard let webUrlString = Environment.infoDictionary[Keys.Plist.webUrl] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }

        return webUrlString
    }()
}

