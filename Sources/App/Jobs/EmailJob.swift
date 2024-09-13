//
//  EmailJob.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/12/24.
//

import Vapor
import Queues
import Resend

final class EmailJob: AsyncJob {
    
    typealias Payload = EmailPayload
    
    func dequeue(_ context: Queues.QueueContext, _ payload: EmailPayload) async throws {

        var template = ResendEmail(from: context.appConfig.noReplyEmail, to: [payload.recipient], subject: payload.email.subject)
        
        template.text = payload.email.templateData.description
        
            print(payload.email.templateData)
        print("runing email jobs")
        
        let response = try await context.application.resend.client.email.send(email: template)
        
        print("respose email: \(response)")
        }
        
        func error(_ context: QueueContext, _ error: Error, _ payload: EmailPayload) async throws {
            print("error: \(error)")
        }
}










