//
//  AccountService.swift
//  AfricasTalkingPackageDescription
//
//  Created by Salama Balekage on 01/12/2017.
//
import Alamofire
import SwiftyJSON

public class AccountService: Service {
    
    internal override init() {
        super.init()
        baseUrl = "https://api.\(isSandbox ? Service.SANDBOX_DOMAIN : Service.PRODUCTION_DOMAIN)/version1"
    }
    
    public func getUserData(callback: @escaping AfricasTalking.Callback) {
        let url = "\(baseUrl!)/user"
        let params: Parameters = ["username": Service.USERNAME!]
        Alamofire.request(url, method: .get, parameters: params, headers: headers)
            .validate()
            .responseString { resp in
                switch(resp.result) {
                case .success:
                    let data = JSON(parseJSON: resp.result.value!)
                    callback(nil, data)
                case .failure:
                    var body: String? = nil
                    if (resp.data != nil) {
                        body = String(data: resp.data!, encoding: String.Encoding.utf8) as String?
                    }
                    let message =  body ?? resp.error?.localizedDescription ?? "Unexpected error"
                    callback(message, nil)
                }
        }
    }
}
