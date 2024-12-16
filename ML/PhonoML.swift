//
// Phono.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
class PhonoInput : MLFeatureProvider {

    /// audioSamples as 15600 element vector of floats
    var audioSamples: MLMultiArray

    var featureNames: Set<String> { ["audioSamples"] }

    func featureValue(for featureName: String) -> MLFeatureValue? {
        if featureName == "audioSamples" {
            return MLFeatureValue(multiArray: audioSamples)
        }
        return nil
    }

    init(audioSamples: MLMultiArray) {
        self.audioSamples = audioSamples
    }

    convenience init(audioSamples: MLShapedArray<Float>) {
        self.init(audioSamples: MLMultiArray(audioSamples))
    }

}


/// Model Prediction Output Type
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
class PhonoOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// target as string value
    var target: String {
        provider.featureValue(for: "target")!.stringValue
    }

    /// targetProbability as dictionary of strings to doubles
    var targetProbability: [String : Double] {
        provider.featureValue(for: "targetProbability")!.dictionaryValue as! [String : Double]
    }

    var featureNames: Set<String> {
        provider.featureNames
    }

    func featureValue(for featureName: String) -> MLFeatureValue? {
        provider.featureValue(for: featureName)
    }

    init(target: String, targetProbability: [String : Double]) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["target" : MLFeatureValue(string: target), "targetProbability" : MLFeatureValue(dictionary: targetProbability as [AnyHashable : NSNumber])])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
class Phono {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "Phono", withExtension:"mlmodelc")!
    }

    /**
        Construct Phono instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of Phono.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `Phono.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration = MLModelConfiguration()) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct Phono instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct Phono instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<Phono, Error>) -> Void) {
        load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct Phono instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> Phono {
        try await load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct Phono instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<Phono, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(Phono(model: model)))
            }
        }
    }

    /**
        Construct Phono instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> Phono {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return Phono(model: model)
    }

    /**
        Make a prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - input: the input to the prediction as PhonoInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as PhonoOutput
    */
    func prediction(input: PhonoInput) throws -> PhonoOutput {
        try prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - input: the input to the prediction as PhonoInput
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as PhonoOutput
    */
    func prediction(input: PhonoInput, options: MLPredictionOptions) throws -> PhonoOutput {
        let outFeatures = try model.prediction(from: input, options: options)
        return PhonoOutput(features: outFeatures)
    }

    /**
        Make an asynchronous prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - input: the input to the prediction as PhonoInput
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as PhonoOutput
    */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    func prediction(input: PhonoInput, options: MLPredictionOptions = MLPredictionOptions()) async throws -> PhonoOutput {
        let outFeatures = try await model.prediction(from: input, options: options)
        return PhonoOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        It uses the default function if the model has multiple functions.

        - parameters:
            - audioSamples: 15600 element vector of floats

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as PhonoOutput
    */
    func prediction(audioSamples: MLMultiArray) throws -> PhonoOutput {
        let input_ = PhonoInput(audioSamples: audioSamples)
        return try prediction(input: input_)
    }

    /**
        Make a prediction using the convenience interface

        It uses the default function if the model has multiple functions.

        - parameters:
            - audioSamples: 15600 element vector of floats

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as PhonoOutput
    */

    func prediction(audioSamples: MLShapedArray<Float>) throws -> PhonoOutput {
        let input_ = PhonoInput(audioSamples: audioSamples)
        return try prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - inputs: the inputs to the prediction as [PhonoInput]
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [PhonoOutput]
    */
    func predictions(inputs: [PhonoInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [PhonoOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [PhonoOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  PhonoOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
