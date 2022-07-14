//
//  ServiceManager.swift
//  Services
//
//  Created by Margo Naumenko on 14.07.2022.
//

import Foundation

protocol ServiceManagerDelegate {
    func didLoadServices(services: [Service])
    func didFailWithError(error: Error)
}

struct ServiceManager {
    
    var delegate: ServiceManagerDelegate?
    
    let servicesURL = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    
    func fetchServices(){
        if let url = URL(string: servicesURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let services = self.parseJSON(safeData){
                        self.delegate?.didLoadServices(services: services)
                    }
                }
            }
            //4 Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ servicesData: Data) -> [Service]?{
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(ServiceData.self, from: servicesData)
            let services = decoderData.body.services

            return services
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
