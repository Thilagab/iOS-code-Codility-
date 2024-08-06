//
//  APIService.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation


//CBAService 
    
func sendAsync<Service: APIServiceProtocol>(apiService: Service, forTransaction: String?) async throws   -> Service.Response {
    
    let  response =  try await apiService.service(forTransaction)
    return response
}
    






