//
//  DetectDevice.swift
//  TeeTimes
//
//  Created by PRANAY DALAL on 02/03/18.
//  Copyright © 2018 TeeTimes. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    public static var iPhoneX: Bool {
        return iPhone && (UIScreen.main.nativeBounds.height >= ScreenType.iPhoneX.height || UIScreen.main.nativeBounds.height == ScreenType.iPhoneXR.height)
    }
    private static var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    public enum ScreenType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus, iPhone 8 Plus"
        case iPhoneXR = "iPhoneXR"
        case iPhoneX = "iPhone X"
        case unknown
        
        var height: CGFloat {
            switch self {
                case .iPhone4_4S:
                    return 960.0
                case .iPhones_5_5s_5c_SE:
                    return 1136.0
                case .iPhones_6_6s_7_8:
                    return 1334.0
                case .iPhones_6Plus_6sPlus_7Plus_8Plus:
                    return 2208.0
                case .iPhoneXR:
                    return 1792.0
                case .iPhoneX:
                    return 2436.0
                case .unknown:
                    return 0.0
            }
        }
        
    }
    public static var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 1792:
            return .iPhoneXR
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}
