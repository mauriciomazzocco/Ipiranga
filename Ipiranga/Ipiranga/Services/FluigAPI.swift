//
//  OldFluigAPI.swift
//  approval
//
//  Created by Maurício Mazzocco on 04/10/17.
//  Copyright © 2017 Totvs. All rights reserved.
//

import Foundation
import fluigSDKCore
import Alamofire
import SBJson


class FluigAPI  {

    func uploadWithAlamofire(fileName: String ,dataToUpload: Data) {

        let url : String = App.getCurrentHost() + "/ecm/api/rest/ecm/mobileDocumentRest/upload?fileName="+fileName
        
        var request = URLRequest(url: URL(string: url)!)

        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.addValue(String(dataToUpload.count), forHTTPHeaderField: "Content-Length") // <-- here!

        var urlS = URLRequest(url: URL(string: url)!)
        FluigSDK.signRequest(req: &urlS)
        let allHtppUserFields =  urlS.allHTTPHeaderFields
        var auth = ""
        if let aut =  allHtppUserFields?["Authorization"] {
            auth = aut
        }

        request.addValue(auth, forHTTPHeaderField: "Autorization")
        request.httpMethod = "POST"

        request.httpBody = dataToUpload
        let session = URLSession.shared


        session.dataTask(with: request) { (data, response, error) in

            print(data)
            print("OKKKKKKKKKKKK")
            }.resume()

    }


    func vsendProcess(movimentSequence:String, processInstanceId: String, choosedState: String, attachments: [AttachmentProcessReturn], tipoCombustivel: String, quantidadeLitros: String, valorTotal: String, kmAtual: String, posto: String){


        for attachs in attachments{
            let attachemtObject = attachs.attachments.lastObject as! Attachment
            uploadWithAlamofire(fileName: attachemtObject.fileName, dataToUpload: attachs.archive)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
              print("Iniciou")
        var url : String = App.getCurrentHost() + "/ecm/api/rest/ecm/mobileWorkflowRest/saveAndSendTaskClassic"

        var urlS = URLRequest(url: URL(string: url)!)
        FluigSDK.signRequest(req: &urlS)
        let allHtppUserFields =  urlS.allHTTPHeaderFields
        var auth = ""
        if let aut =  allHtppUserFields?["Authorization"] {
            auth = aut
        }
        let headers : [String : String] = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": auth
        ]
        let attachString = SBJson5Writer.init().string(with: attachments)

        let jsonCardData = "[{\"key\":\"itemPosto___"+movimentSequence+"\",\"value\":\""+posto+"\"},{\"key\":\"itemQuantidade___"+movimentSequence+"\",\"value\":\""+quantidadeLitros+"\"},{\"key\":\"itemTipoCombustivel___"+movimentSequence+"\",\"value\":\""+tipoCombustivel+"\"},{\"key\":\"itemValorTotal___"+movimentSequence+"\",\"value\":\""+valorTotal+"\"},{\"key\":\"itemKmAtual___"+movimentSequence+"\",\"value\":\""+kmAtual+"\"},{\"key\":\"WKMobile\",\"value\":\"true\"},{\"key\":\"wdkcontrolmob\",\"value\":\"true\"}]"

          
        let parameterDictionary = ["processInstanceId" : processInstanceId,
                                   "threadSequence" : "0",
                                   "choosedState": choosedState,
                                   "cardData" : jsonCardData,
                                   "comments" : "",
                                   "completeTask" : "true",
                                   "appointment" : "",
                                   "managerMode" : "false",
                                   "attachments" : attachString!
            ] as [String : Any]


        Alamofire.request(URL(string: url)!, method: .post, parameters: parameterDictionary, encoding: URLEncoding.default, headers: headers)

            .responseJSON { response in
                print(response)
                print("JSON Response")

                NotificationCenter.default.post(name: Notification.Name("finishLoading"), object: nil)
                
            }
        })

    }

    func getAllItemsFromServer(completion: @escaping (_ result: [WorkflowProcessDto]?) -> Void) {
        let url : String = App.getCurrentHost() + "/ecm/api/rest/ecm/mobileCentralTaskRest/findWorkflowTasksOnDemand_v2"

        var urlS = URLRequest(url: URL(string: url)!)
        FluigSDK.signRequest(req: &urlS)
        let allHtppUserFields =  urlS.allHTTPHeaderFields
        var auth = ""
        if let aut =  allHtppUserFields?["Authorization"] {
            auth = aut
        }
        let headers : [String : String] = [
            "Content-Type": "application/json",
            "Authorization": auth
        ]


        let parameterDictionary = ["runEvent" : "true",
                                   "limit": "100",
                                   "lastRowId" : "0",
                                   "ascending" : "true"

            ]


        Alamofire.request(URL(string: url)!, method: .get, parameters: parameterDictionary, encoding: URLEncoding.default, headers: headers)

            .responseData { response in
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: response.data!, options:JSONSerialization.ReadingOptions(rawValue: 0))
                    guard let dictionary = jsonObject as? Dictionary<String, Any> else {

                        return
                    }

                    var content = dictionary["content"] as! [String: Any]

                    let wk = content["wkfProcess"]! as! [Any]
                    var arrayWorkflow = [WorkflowProcessDto]()
                    print(wk)
                    for arr in wk {
                        let workflowProcess = WorkflowProcessDto.init().dictToWorkflowProcessDto(withDict: arr as! Dictionary )
                        arrayWorkflow.append(workflowProcess!)
                        completion(arrayWorkflow)

                   }

                }
                catch let error as NSError {
                    print("Found an error - \(error)")
                }
        }

    }

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
        endPoint.getTasks(processInstanceId: processInstanceId, movementSequence: movementSequence, assignee: (FluigSDK.currentUser?.code)!, status:status, slaStatus: nil, processId: "postoIpiranga", appDecisionSearch: searchText, page: page, pageSize: 20, expand: ["appDecisionInfo"]) { (response) in
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
