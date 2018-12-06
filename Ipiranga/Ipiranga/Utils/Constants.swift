//
//  Constants.swift
//  BPM
//
//  Created by Mauricio Mazzocco on 07/06/17.
//  Copyright (c) 2017 TOTVS SA. All rights reserved.
//

import UIKit
import Foundation
import fluigSDKCore

struct App {

    static func isSafeArea() -> Bool{

        if #available(iOS 11.0, *) {
            if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(0.0)) {
                return true
            }
        }
        return false
    }
    static func getCurrentHost() -> String{
        let url =  FluigSDK.currentUser?.serverUrl != nil ? (FluigSDK.currentUser?.serverUrl)! : ""
        return url
    }
    

}
