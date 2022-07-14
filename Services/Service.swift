//
//  ServicePreview.swift
//  Services
//
//  Created by Margo Naumenko on 13.07.2022.
//

import UIKit


struct ServiceData: Decodable{
    let body: Body
}

struct Body: Decodable {
    let services: [Service]
}

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}
