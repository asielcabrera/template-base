//
//  KMeans.swift
//  template-base
//
//  Created by Asiel Cabrera Gonzalez on 9/20/24.
//
import Foundation
import CoreLocation

struct KMeans {
    let k: Int
        let maxIterations: Int

        func cluster(patients: [Patient]) -> [[Patient]] {
            guard !patients.isEmpty else { return [] }

            // Inicializar los centroides seleccionando los primeros k pacientes
            var centroids = patients.prefix(k).map { $0.coordinates }

            var clusters: [[Patient]] = Array(repeating: [], count: k)
            var iterations = 0
            var hasConverged = false

            while !hasConverged && iterations < maxIterations {
                // Asignar cada paciente al centroide más cercano
                clusters = Array(repeating: [], count: k)
                for patient in patients {
                    let distances = centroids.map { $0.distance(to: patient.coordinates) }
                    if let minDistance = distances.min(), let index = distances.firstIndex(of: minDistance) {
                        clusters[index].append(patient)
                    }
                }

                // Calcular nuevos centroides
                var newCentroids: [CLLocationCoordinate2D] = []
                for cluster in clusters {
                    if cluster.isEmpty {
                        // Si un cluster está vacío, mantener el centroide anterior
                        newCentroids.append(centroids[newCentroids.count])
                    } else {
                        let avgLat = cluster.map { $0.coordinates.latitude }.reduce(0, +) / Double(cluster.count)
                        let avgLon = cluster.map { $0.coordinates.longitude }.reduce(0, +) / Double(cluster.count)
                        newCentroids.append(CLLocationCoordinate2D(latitude: avgLat, longitude: avgLon))
                    }
                }

                // Verificar la convergencia
                hasConverged = zip(centroids, newCentroids).allSatisfy { (a, b) -> Bool in
                    a.distance(to: b) < 0.0001 // Umbral de convergencia
                }

                centroids = newCentroids
                iterations += 1
            }

            return clusters
        }
}
