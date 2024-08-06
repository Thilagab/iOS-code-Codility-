//
//  APIService.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//


import Foundation
import CodeChallengeAPI

// API service
protocol APIServiceProtocol {
    
    var api: CodeChallengeAPI { get }
    
    associatedtype Response
    func service(_ request: String?)  async throws -> Response
    
    
}

