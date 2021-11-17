//
//  RickAndMorty.swift
//  RickAndMorty
//
//  Created by Михаил Мезенцев on 15.11.2021.
//

struct RickAndMorty: Decodable {
    let info: Info?
    let results: [Character]?
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct Character: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Location?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    
    var description: String {
        """
        Status: \(status ?? "")
        Species: \(species ?? "")
        Gender: \(gender ?? "")
        Location: \(location?.name ?? "")
        """
    }
}

struct Location: Decodable {
    let name: String?
    let url: String?
}

enum URLQuery: String {
    case rickAndMortyAPI = "https://rickandmortyapi.com/api/character"
}
