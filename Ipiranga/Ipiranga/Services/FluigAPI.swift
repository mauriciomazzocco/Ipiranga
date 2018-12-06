//
//  OldFluigAPI.swift
//  approval
//
//  Created by Maurício Mazzocco on 04/10/17.
//  Copyright © 2017 Totvs. All rights reserved.
//

import Foundation
import fluigSDKCore


class FluigAPI {
/*

    func changeLanguage(){


        let languageAppFluig =   UserDefaults.standard.object(forKey: "languageFluigAPP") as? String
        var deviceLanguageCurrent: String = NSLocale.preferredLanguages[0]
        if (deviceLanguageCurrent.count ?? 0) > 2 {
            deviceLanguageCurrent = ((deviceLanguageCurrent as NSString).substring(to: 2))
        }
        if(deviceLanguageCurrent != languageAppFluig){
            guard let tokens = FluigSDK.getCurrentUserTokens() else { return }
            var url : String = App.getCurrentHost() + "/api/public/push/changeLanguage"
            url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!



            var urlComponents = NSURLComponents(string: url)!

            urlComponents.queryItems = [
                URLQueryItem(name: "language", value: deviceLanguageCurrent),
                URLQueryItem(name: "deviceToken", value: tokens.accessToken)
            ]


            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("iOS app", forHTTPHeaderField: "User-Agent")


            let parameterDictionary = ["language": deviceLanguageCurrent, "deviceToken": tokens.accessToken]

           guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
                return
            }
            request.httpBody = httpBody

            AuthenticationServices.signRequest(req: request){ (resp) in
                switch (resp){
                case .success(let request):
                    let session = URLSession.shared
                    session.dataTask(with: request) { (data, response, error) in
                        if let response = response {
                            print(response)
                        }
                        if let data = data {
                            do {
                                let str = String(data: data, encoding: String.Encoding.utf8) as String!
                                if(str!.lowercased().contains("ok")){
                                    UserDefaults.standard.setValue(deviceLanguageCurrent, forKey: "languageFluigAPP")
                                    UserDefaults.standard.synchronize()
                                }

                            }catch {
                                UserDefaults.standard.setValue(nil, forKey: "languageFluigAPP")
                                UserDefaults.standard.synchronize()
                                print(error)
                            }
                        }
                        }.resume()

                case .failure( _):
                    break;
                }
            }
        }
    }
 */
  /*  func registerPush(token: String, channelID: String, language: String){
        if token == "" && channelID == ""{
            return
        }
        var url : String = App.getCurrentHost() + "/api/public/push/register"
        url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("iOS app", forHTTPHeaderField: "User-Agent")
        guard let tokens = FluigSDK.getCurrentUserTokens() else { return }
        UserDefaults.standard.setValue(tokens.accessToken, forKey: "currentUserAcessToken")
        UserDefaults.standard.synchronize()
        let parameterDictionary = ["token" :token, "channel" : channelID,  "deviceToken": tokens.accessToken, "language": language, "imei" : UIDevice.current.identifierForVendor!.uuidString]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody

        AuthenticationServices.signRequest(req: request){ (resp) in
            switch (resp){
            case .success(let request):
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if let response = response {
                        print(response)
                    }
                    if let data = data {
                        do {
                            let str = String(data: data, encoding: String.Encoding.utf8) as String!
                            if(str!.lowercased().contains("ok")){
                                UserDefaults.standard.setValue(false, forKey: "updatedChanneID")
                                UserDefaults.standard.setValue(language, forKey: "languageAPP")
                                UserDefaults.standard.synchronize()
                            }

                        }catch {
                            UserDefaults.standard.setValue(true, forKey: "updatedChanneID")
                            UserDefaults.standard.synchronize()
                            print(error)
                        }
                    }
                    }.resume()

            case .failure(let _):
                break;
            }
        }
    }
     */

    func getAllItems(
        page: Int,
        delayed: Bool? = nil,
        searchText: String? = nil,
        processInstanceId : String? = nil,
        movementSequence : String? = nil,
        processId : String? = nil,
        status : String? = nil,
        completionHandler: @escaping (ApiCollectionResponse<ProcessTaskResponse>?, String?) -> Void) {

        let endPoint = BPMApi(domain: App.getCurrentHost())
        endPoint.getTasks(processInstanceId: processInstanceId, movementSequence: movementSequence, assignee: (FluigSDK.currentUser?.code)!, status:status, slaStatus: nil, processId: "22", appDecisionSearch: searchText, page: page, pageSize: 20, expand: ["appDecisionInfo"]) { (response) in
            switch response {
            case .success(let item):
                completionHandler(item, nil)
            case .failure(let error):
                completionHandler(nil,"Error")
            }
        }
    }
 /*
    func getHtmlForMobile(processId: String, processInstanceId: String, processVersion: String, movementSequence: String, readOnly: Bool,  completion: @escaping (_ result: String?) -> Void) {

        var url : String = App.getCurrentHost() + "/ecm/api/rest/ecm/mobileWorkflowRest/getHtmlForMobile?processId=" + processId + "&processInstanceId=" + processInstanceId + "&processVersion=" + processVersion + "&editable=" + (readOnly ? "false" : "true")
        url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = URLRequest(url: URL(string: url)!)

        AuthenticationServices.signRequest(req: request){ (resp) in
            switch (resp){
            case .success(let request):
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async{
                        if let data = data {
                            do {

                                let responseString = String(data: data, encoding: .utf8)
                                if(responseString!.contains("/streamcontrol/")) {
                                    let stringReplacing =  responseString?.replacingOccurrences(of: "\"", with: "")

                                    completion(stringReplacing)
                                }else{
                                    completion(nil)
                                }
                            }catch {
                                completion(nil)
                            }
                        }
                    }
                    }.resume()

            case .failure(let error):
                completion(nil)

            }
        }

    }
 */

}
