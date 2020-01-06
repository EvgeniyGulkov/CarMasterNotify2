//
//  DeepLinkOption.swift
//  CarMasterNotify
//
//  Created by Admin on 12/10/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

struct DeepLinkURLConstants {
    static let Onboarding = "onboarding"
    static let Items = "items"
    static let Item = "item"
    static let Settings = "settings"
    static let Auth = "auth"
    static let Terms = "terms"
    static let SignUp = "signUp"
}

enum DeepLinkOption {
    case onboarding
    case items
    case item(String?)
    case signUp
    case settings
    case terms
    case auth

static func build(with userActivity:NSUserActivity) -> DeepLinkOption? {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
    let url = userActivity.webpageURL,
        let _ = URLComponents(url: url, resolvingAgainstBaseURL: true) {
        //TODO
    }
    return nil
    }

static func build(with dict: [String : AnyObject]?) -> DeepLinkOption? {
    guard let id = dict?["launch_id"] as? String else { return nil}
    
    let itemID = dict?["item_id"] as? String
    
    switch id {
        case DeepLinkURLConstants.Onboarding: return self.onboarding
        case DeepLinkURLConstants.Item: return self.item(itemID)
        case DeepLinkURLConstants.Items: return self.items
        case DeepLinkURLConstants.Auth: return self.auth
        case DeepLinkURLConstants.SignUp: return self.signUp
        case DeepLinkURLConstants.Settings: return self.settings
        case DeepLinkURLConstants.Terms: return self.terms
        default:
            return nil
        }

    }
}
