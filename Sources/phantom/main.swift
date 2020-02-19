import Kitura
import Logging

let router = Router()

struct XPackBuild : Codable {
    let hash: String
    let date: String
}

struct XPackLicense : Codable {
    let uid: String
    let type: String
    let mode: String
    let status: String
    let expiry_date_in_millis: UInt64
}

struct XPackFeatureState : Codable {
    let available: Bool
    let enabled: Bool
}

struct XPackData : Codable {
    let build: XPackBuild
    let license: XPackLicense
    let features: [String:XPackFeatureState]
    let tagline: String
}

router.get("/_xpack") { request, response, next in
    let xpb = XPackBuild(hash: "foo", date: "today")
    let xpl = XPackLicense(uid: "893361dc-9749-4997-93cb-xxx", type: "trial", mode: "trial", status: "active", expiry_date_in_millis: 4102444800000)
    let features = [
        "ccr": XPackFeatureState(available: false, enabled: false),
        "analytics": XPackFeatureState(available: false, enabled: false),
        "enrich": XPackFeatureState(available: false, enabled: false),
        "flattened": XPackFeatureState(available: false, enabled: false),
        "frozen_indices": XPackFeatureState(available: false, enabled: false),
        "graph": XPackFeatureState(available: false, enabled: false),
        "ilm": XPackFeatureState(available: false, enabled: false),
        "logstash": XPackFeatureState(available: false, enabled: false),
        "ml": XPackFeatureState(available: false, enabled: false),
        "monitoring": XPackFeatureState(available: false, enabled: false),
        "rollup": XPackFeatureState(available: false, enabled: false),
        "security": XPackFeatureState(available: false, enabled: false),
        "slm": XPackFeatureState(available: false, enabled: false),
        "spatial": XPackFeatureState(available: false, enabled: false),
        "sql": XPackFeatureState(available: false, enabled: false),
        "transform": XPackFeatureState(available: false, enabled: false),
        "vectors": XPackFeatureState(available: false, enabled: false),
        "voting_only": XPackFeatureState(available: false, enabled: false),
        "watcher": XPackFeatureState(available: false, enabled: false),
    ]
    let defaultXPackResponse = XPackData(build: xpb, license: xpl, features: features, tagline: "fake :)")
    response.send(json: defaultXPackResponse)
}

struct ErrorCause : Codable {
    let root_cause: [[String:String]]
}

struct ResponseError : Codable {
    let error: ErrorCause
    let status: UInt
}

router.get("/.kibana_task_manager") {request, response, next in
    response.status(HTTPStatusCode.notFound)
    response.send(json: ResponseError(error: ErrorCause(root_cause: []), status: 404))
}

router.get("/.kibana") {request, response, next in
    response.status(HTTPStatusCode.notFound)
    response.send(json: ResponseError(error: ErrorCause(root_cause: []), status: 404))
}

router.get("/_cat/templates") { request, response, next in
    response.send(json: [])
}

router.put("/*") { request, response, next in
    print("\(request.method) - \(request.originalURL)")
    // store index thingy
}

router.get("/*") { request, response, next in
    print("\(request.method) - \(request.originalURL)")
    response.status(HTTPStatusCode.notFound)
    response.send(json: ResponseError(error: ErrorCause(root_cause: []), status: 404))
}

//var logger = Logger(label: "something")
//logger.logLevel = Logger.Level.trace
//
//Kitura.addHTTPServer(onPort: 9200, with: router)
//Kitura.logTo(logger)
//Kitura.run()

