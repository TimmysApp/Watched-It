//
//  Cropper.swift
//  Watched It?
//
//  Created by Joe Maghzal on 10/01/2023.
//

import SwiftUI
import Vision
import STools

public struct ImageDetect<T> {
    let detectable: T
    init(_ detectable: T) {
        self.detectable = detectable
    }
}

//MARK: - Public Functions
public extension ImageDetect where T: CGImage {
    func crop(type: DetectionType, completion: @escaping (ImageDetectResult<CGImage>) -> Void) {
        switch type {
            case .face:
                cropFace(completion)
            case .barcode:
                cropBarcode(completion)
            case .text:
                cropText(completion)
                break
        }
    }
    func crop(type: DetectionType) async -> ImageDetectResult<CGImage> {
        await withCheckedContinuation { continuation in
            crop(type: type) { result in
                continuation.resume(returning: result)
            }
        }
    }
}

public extension ImageDetect where T: UNImage {
    func crop(type: DetectionType, completion: @escaping (ImageDetectResult<UNImage>) -> Void) {
#if canImport(UIKit)
        detectable.cgImage?.detector.crop(type: type) { result in
            switch result {
                case .success(let cgImages):
                    let faces = cgImages.map { cgImage -> UNImage in
                        return UNImage(cgImage: cgImage)
                    }
                    completion(.success(faces))
                case .notFound:
                    completion(.notFound)
                case .failure(let error):
                    completion(.failure(error))
            }
        }
#elseif canImport(AppKit)
        var imageRect = CGRect(x: 0, y: 0, width: detectable.size.width, height: detectable.size.height)
        detectable.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)?.detector.crop(type: type) { result in
            switch result {
                case .success(let cgImages):
                    let faces = cgImages.map { cgImage -> UNImage in
                        return UNImage(cgImage: cgImage, size: NSSize.init(width: cgImage.width, height: cgImage.height))
                    }
                    completion(.success(faces))
                case .notFound:
                    completion(.notFound)
                case .failure(let error):
                    completion(.failure(error))
            }
        }
#endif
    }
    func crop(type: DetectionType) async -> ImageDetectResult<UNImage> {
        await withCheckedContinuation { continuation in
            crop(type: type) { result in
                continuation.resume(returning: result)
            }
        }
    }
}

//MARK: - Private Funcrions
private extension ImageDetect where T: CGImage {
    func cropFace(_ completion: @escaping (ImageDetectResult<CGImage>) -> Void) {
        let req = VNDetectFaceRectanglesRequest { request, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let faceImages = request.results?.map { result -> CGImage? in
                guard let face = result as? VNFaceObservation else { return nil }
                let faceImage = cropImage(object: face)
                return faceImage
            }.compactMap({$0})
            guard let faceImages, !faceImages.isEmpty else {
                completion(.notFound)
                return
            }
            completion(.success(faceImages))
        }
        do {
            try VNImageRequestHandler(cgImage: detectable, options: [:]).perform([req])
        }catch let error {
            completion(.failure(error))
        }
    }
    func cropBarcode(_ completion: @escaping (ImageDetectResult<CGImage>) -> Void) {
        let req = VNDetectBarcodesRequest { request, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let codeImages = request.results?.map { result -> CGImage? in
                guard let code = result as? VNBarcodeObservation else { return nil }
                let codeImage = cropImage(object: code)
                return codeImage
            }.compactMap({$0})
            guard let codeImages, !codeImages.isEmpty else {
                completion(.notFound)
                return
            }
            completion(.success(codeImages))
        }
        do {
            try VNImageRequestHandler(cgImage: detectable, options: [:]).perform([req])
        }catch let error {
            completion(.failure(error))
        }
    }
    func cropText(_ completion: @escaping (ImageDetectResult<CGImage>) -> Void) {
        let req = VNDetectTextRectanglesRequest { request, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            let textImages = request.results?.map { result -> CGImage? in
                let textImage = cropImage(object: result as? VNTextObservation)
                return textImage
            }.compactMap({$0})
            guard let textImages, !textImages.isEmpty else {
                completion(.notFound)
                return
            }
            completion(.success(textImages))
        }
        do {
            try VNImageRequestHandler(cgImage: detectable, options: [:]).perform([req])
        }catch let error {
            completion(.failure(error))
        }
    }
    func cropImage(object: VNDetectedObjectObservation?) -> CGImage? {
        guard let object else {return nil}
        let width = object.boundingBox.width * CGFloat(detectable.width)
        let height = object.boundingBox.height * CGFloat(detectable.height)
        let x = object.boundingBox.origin.x * CGFloat(detectable.width)
        let y = (1 - object.boundingBox.origin.y) * CGFloat(detectable.height) - height
        let croppingRect = CGRect(x: x, y: y, width: width, height: height)
        let image = detectable.cropping(to: croppingRect)
        return image
    }
}
