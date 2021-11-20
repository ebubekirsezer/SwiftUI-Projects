//: ## Episode
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: [VideoURL ->](@next)

/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
//: [VideoURL ->](@next)
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


let baseUrlString = "https://api.raywenderlich.com/api/"
var urlComponents = URLComponents(string: baseUrlString + "contents/")!

var baseParams = [
    "filter[subscription_types][]": "free",
    "filter[content_types][]": "episode",
    "sort": "-popularity",
    "page[size]": "20",
    "filter[q]": ""
]

urlComponents.setQueryItems(with: baseParams)

//urlComponents.queryItems = [
//    URLQueryItem(name: "filter[subscription_types][]", value: "free"),
//    URLQueryItem(name: "filter[content_types][]", value: "episode")
//]

//urlComponents.url
//urlComponents.url?.absoluteString

urlComponents.queryItems! += [URLQueryItem(name: "filter[domain_ids][]", value: "1")]

let contentsURL = urlComponents.url!

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(.apiDateFormatter)

URLSession.shared.dataTask(with: contentsURL) { data, response, error in
    
    defer { PlaygroundPage.current.finishExecution() }
    if let data = data,
       let response = response as? HTTPURLResponse {
        print(response.statusCode)
        
        if let decodedResponse = try? decoder.decode(EpisodeStore.self, from: data) {
            let date = decodedResponse.episodes[0].attributes.released_at
            DateFormatter.episodeDateFormatter.string(from: date)
        }
        return
    }
    
    print("Contents fetch failed: " + "\(error?.localizedDescription ?? "Unknown Error")")
}
.resume()


struct EpisodeStore: Decodable {
    var episodes: [Episode] = []
    
    enum CodingKeys: String, CodingKey {
        case episodes = "data"
    }
}

struct Episode: Decodable, Identifiable {
    let id: String
    //let attributes: Attributes
    let uri: String
    let name: String
    let released: String
    let difficult: String?
    let description: String

    var domain = ""

    var videoURL: VideoURL?

    var linkURLString: String {
        "https://www.raywenderlich.com/redirect?uri=" + uri
    }
    
    static let domainDictionary: [String: String] = [
        "1": "iOS & Swift",
        "2": "Android & Kotlin",
        "3": "Unity",
        "5": "macOS",
        "8": "Server-Side Swift",
        "9": "Flutter"
    ]
    
    enum DataKeys: String, CodingKey {
        case id
        case attributes
        case relationships
    }
    
    enum AttrsKeys: String, CodingKey {
        case uri, name, difficulty
        case releasedAt = "released_at"
        case description = "description_plain_text"
        case videoIdentifier = "video_identifier"
    }
    
    struct Domains: Codable {
        let data: [String: String]
    }
    
    enum RelKeys: String, CodingKey {
        case domains
    }
}

extension Episode {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let attrs = try container.nestedContainer(keyedBy: AttrsKeys.self, forKey: .attributes)
        let uri = try attrs.decode(String.self, forKey: .uri)
        let name = try attrs.decode(String.self, forKey: .name)
        let releasedAt = try attrs.decode(String.self, forKey: .releasedAt)
        let releaseDate = Formatter.iso8601.date(from: releasedAt)
        let difficulty = try attrs.decode(String?.self, forKey: .difficulty)
        let description = try attrs.decode(String.self, forKey: .description)
        let videoIdentifier = try attrs.decode(Int?.self, forKey: .videoIdentifier)
        
        let rels = try container.nestedContainer(keyedBy: RelKeys.self, forKey: .relationships)
        let domains = try rels.decode(Domains.self, forKey: .domains)
        if let domainId = domains.data.first?["id"] {
            self.domain = Episode.domainDictionary[domainId] ?? ""
        }
    }
}


//struct Attributes: Decodable {
//
//    let uri: String
//    let name: String
//    let released: String
//    let difficult: String?
//    let description: String
//
//    var domain = ""
//
//    var videoURL: VideoURL?
//
//    var linkURLString: String {
//        "https://www.raywenderlich.com/redirect?uri=" + uri
//    }
//
//}
