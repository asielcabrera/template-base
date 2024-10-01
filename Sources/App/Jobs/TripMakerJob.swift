//
//  TripMakerJob.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/25/24.
//

import Queues

final class TripMakerJob: AsyncScheduledJob {
    func run(context: Queues.QueueContext) async throws {
        print("schedule jobs runned")
    }
    

    
    typealias Payload = Trip
    
    func dequeue(_ context: Queues.QueueContext, _ payload: Trip) async throws {
        
    }
}


struct Trip: Codable {
    
}
