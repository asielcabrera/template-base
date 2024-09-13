//
//  Email.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//


protocol Email: Codable {
    var templateName: String { get }
    var templateData: [String: String] { get }
    var subject: String { get }
}