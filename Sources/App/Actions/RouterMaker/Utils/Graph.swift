//
//  Graph.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//


class Graph {
    var edges: [Node: [Edge]] = [:]
    
    func addEdge(from: Node, to: Node, distance: Double) {
        let edge = Edge(from: from, to: to, distance: distance)
        edges[from, default: []].append(edge)
    }
    
    func shortestPath(from start: Node, to end: Node) -> [Node]? {
        var distances: [Node: Double] = [start: 0]
        var previousNodes: [Node: Node] = [:]
        var nodesToVisit: Set<Node> = Set(edges.keys)
        
        while !nodesToVisit.isEmpty {
            let closestNode = nodesToVisit.min { (node1, node2) -> Bool in
                (distances[node1] ?? Double.infinity) < (distances[node2] ?? Double.infinity)
            }
            
            guard let currentNode = closestNode else { break }
            
            if currentNode == end {
                var path: [Node] = []
                var currentNode = end
                
                while let previousNode = previousNodes[currentNode] {
                    path.insert(currentNode, at: 0)
                    currentNode = previousNode
                }
                path.insert(start, at: 0)
                return path
            }
            
            nodesToVisit.remove(currentNode)
            
            
            guard let edges = edges[currentNode] else { continue }
            
            for edge in edges {
                let newDistance = (distances[currentNode] ?? Double.infinity) + edge.distance
                
                if newDistance < (distances[edge.to] ?? Double.infinity) {
                    distances[edge.to] = newDistance
                    previousNodes[edge.to] = currentNode
                }
            }
        }
        return nil
    }
}
