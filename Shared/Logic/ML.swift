//
//  ML.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import SwiftUI
import Vision
import CoreML

struct ML {
//MARK: - Properties
    private static let shared = ML()
    public var modelURL: URL? {
        let fileManager = FileManager.default
        guard let appSupportURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.knowEm.data") else {
            return nil
        }
        let compiledModelURL = try? fileManager.contentsOfDirectory(at: appSupportURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).first(where: {$0.path.contains(".mlmodelc")})
        return compiledModelURL
    }
//MARK: - Functions
    public static func identify(using mediaItem: MediaItem) async -> IdentifiedItem? {
        await withCheckedContinuation { continuation in
            shared.identify(using: mediaItem) { item in
                continuation.resume(returning: item)
            }
        }
    }
    private func identify(using mediaItem: MediaItem, completion: @escaping (IdentifiedItem?) -> Void) {
        do {
            guard let modelURL else {
                completion(nil)
                return
            }
            guard let image = mediaItem.data.unImage?.cgImage else {
                completion(nil)
                return
            }
            let mlModel = try MLModel(contentsOf: modelURL)
            let vnModel = try VNCoreMLModel(for: mlModel)
            let request = VNCoreMLRequest(model: vnModel) { request, error in
                completion(process(request, error: error, mediaItem: mediaItem))
            }
            DispatchQueue.global(qos: .userInitiated).async {
                let handler = VNImageRequestHandler(cgImage: image, orientation: .up)
                do {
                    try handler.perform([request])
                }catch {
                    print(error)
                    completion(nil)
                }
            }
        }catch {
            print(error)
            completion(nil)
        }
    }
    private func process(_ request: VNRequest, error: Error?, mediaItem: MediaItem) -> IdentifiedItem? {
        guard let results = request.results else {
            if let error {
                print(error)
            }else {
                
            }
            return nil
        }
        guard let classifications = results as? [VNClassificationObservation], let bestClassification = classifications.sorted(by: {$0.confidence > $1.confidence}).first else {
            return nil
        }
        let identifiedItem = IdentifiedItem(isReported: false, isPinned: false, timestamp: Date(), confidence: Double(bestClassification.confidence.magnitude), identifier: bestClassification.identifier, mediaItem: mediaItem)
        identifiedItem.save()
        return identifiedItem
    }
}
