//
//  EmailJob.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Queues

final class EmailJob: AsyncJob {
    
    typealias Payload = EmailPayload
    
    func dequeue(_ context: Queues.QueueContext, _ payload: EmailPayload) async throws {

//            let mailgunMessage = MailgunTemplateMessage(
//                from: context.appConfig.noReplyEmail,
//                to: payload.recipient,
//                subject: payload.email.subject,
//                template: payload.email.templateName,
//                templateData: payload.email.templateData
//            )
//            print(payload.email.templateData)
//            let _ = context.mailgun().send(mailgunMessage)
        }
        
        func error(_ context: QueueContext, _ error: Error, _ payload: EmailPayload) async throws {
            print("error: \(error)")
        }
}

struct EmailPayload: Codable {
    let email: AnyEmail
    let recipient: String
    
    init<E: Email>(_ email: E, to recipient: String) {
        self.email = AnyEmail(email)
        self.recipient = recipient
    }
}

protocol Email: Codable {
    var templateName: String { get }
    var templateData: [String: String] { get }
    var subject: String { get }
}

struct AnyEmail: Email {
    let templateName: String
    let templateData: [String: String]
    let subject: String
    
    init<E>(_ email: E) where E: Email {
        self.templateData = email.templateData
        self.templateName = email.templateName
        self.subject = email.subject
    }
}

struct ResetPasswordEmail: Email {
    var templateName: String
    var templateData: [String : String] {
        ["reset_url": resetURL]
    }
    var subject: String {
        "Reset your password"
    }
    
    let resetURL: String
    
    init(resetURL: String) {
        self.resetURL = resetURL
        self.templateName = "reset_password"
    }
}

struct VerificationEmail: Email {
    var templateName: String
    let verifyUrl: String
    
    var subject: String {
        "Please verify your email"
    }
    
    var templateData: [String : String]
    
    init(verifyUrl: String) {
        self.verifyUrl = verifyUrl
        self.templateName = "email_verification"
        self.templateData = ["verify_url": verifyUrl]
    }
    
    
    mutating func append(key: String, value: String) {
        self.templateData.updateValue(value, forKey: key)
    }
}
