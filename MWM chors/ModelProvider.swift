//
//  ModelProvider.swift
//  MWM chors
//
//  Created by Евгений Кириллов on 13.12.2020.
//

struct ModelProvider {
    private let networkController = NetworkController()
    private let alertHandler = AlertErrorHandler()
    
    func provideData(completion: @escaping (PickerChords) -> Void) {
        networkController.sendRequest { response in
            switch response {
            case .success(let allChords):
                let model = PickerChords(withAllData: allChords)
                completion(model)
            case .failure(let error):
                self.alertHandler.handle(error)
            }
        }
    }
}
