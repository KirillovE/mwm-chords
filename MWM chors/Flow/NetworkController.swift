//
//  NetworkController.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

import Foundation

struct NetworkController {
    
    typealias ChordsResponse = Result<AllChordsData, TextualError>
    
    func sendRequest(completion: @escaping (ChordsResponse) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard let URL = URL(string: "https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords") else { return }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, _, error: Error?) -> Void in
            if let responseData = data {
                let response = self.decodeData(responseData)
                completion(response)
            } else if let error = error {
                let error = TextualError(stringLiteral: error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func decodeData(_ data: Data) -> ChordsResponse {
        do {
            let allChords = try JSONDecoder().decode(AllChordsData.self, from: data)
            return .success(allChords)
        } catch {
            let error = TextualError(stringLiteral: error.localizedDescription)
            return .failure(error)
        }
    }
    
}
