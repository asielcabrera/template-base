//
//  QueueContext+Services.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/10/24.
//

import Fluent
import Queues
import QueuesRedisDriver

extension QueueContext {
    var db: Database {
        application.databases
            .database(logger: self.logger, on: self.eventLoop)!
    }
    
//    func mailgun() -> MailgunProvider {
//        application.mailgun().delegating(to: self.eventLoop)
//    }
//    
//    func mailgun(_ domain: MailgunDomain? = nil) -> MailgunProvider {
//        application.mailgun(domain).delegating(to: self.eventLoop)
//    }
    
    var appConfig: AppConfig {
        application.config
    }
}
