//
//  SignUpAddingPostInApi.swift
//  Merita
//
//  Created by mohamed ibrahim on 13/07/2022.
//
import UIKit
func AddingEmailInApi (name:String,email:String,password:String,uidFirebase:String){
    
    var request = URLRequest(url: URL(string: "https://7d67dd63dc90e18fce08d1f7746e9f41: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@ios-q3-mansoura.myshopify.com/admin/api/2022-01/customers.json")!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpShouldHandleCookies = false
            let body : [String:Any] = [
                "customer" : [
                "first_name" : name,
                "email" : email,
                "last_name" :uidFirebase,
                "tags" : password,
                    ]
            ]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            
            }catch let error {
                print(error)
            }
     URLSession.shared.dataTask(with: request) { data, response, error in
        print(response!)
        if let data = data {
            do {
                if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any] {
                    print(json)
                }
                
            } catch let error  {
                print(error)
            }
        }
        if let error = error {
            print(String(describing: error))
        }
     }.resume()
}
