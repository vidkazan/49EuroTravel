//
//  Model.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 05.05.23.
//

import Foundation

// /journeys

struct Journeys : Decodable {
	
}

// /locations
struct Stops : Decodable {
	let stops : [Stop]
}

struct Stop : Decodable {
	let type	: String?
	let id		: String?
	let name	: String?
	let location : Location
	let products : Products
}


// /departures
struct Departures : Decodable {
	let departures : [Departure]
}

struct Departure : Decodable {
	let tripId				: String?
	let stop				: Destination
	let when				: String?
	let plannedWhen			: String?
	let prognosedWhen		: String?
	let delay				: Int?
	let platform			: String?
	let plannedPlatform		: String?
	let prognosedPlatform	: String?
	let prognosisType		: String?
	let direction			: String?
	let provenance			: String?
	let line				: Line
	let remarks				: [Remark]
	let origin				: String?
	let destination			: Destination
	let cancelled			: Bool?
}

// MARK: - Destination
class Destination : Decodable {
	let type		: String?
	let id			: String?
	let name		: String?
	let location	: Location
	let products	: Products
}

// MARK: - Location
struct Location : Decodable {
	let type		: String?
	let id			: String?
	let latitude	: Double?
	let longitude	: Double?
}

// MARK: - Products
struct Products : Decodable {
	let nationalExpress		: Bool?
	let national			: Bool?
	let regionalExpress		: Bool?
	let regional			: Bool?
	let suburban			: Bool?
	let bus					: Bool?
	let ferry				: Bool?
	let subway				: Bool?
	let tram				: Bool?
	let taxi				: Bool?
}

// MARK: - Line
struct Line : Decodable {
	let type			: String?
	let id				: String?
	let fahrtNr			: String?
	let name			: String?
	let linePublic		: Bool?
	let adminCode		: String?
	let productName		: String?
	let mode			: String?
	let product			: String?
}

// MARK: - Remark
struct Remark : Decodable {
	let type	: String?
	let code	: String?
	let text	: String?
}

struct Station : Decodable {
	let EVA_NR			: Int?
	let DS100			: String?
	let IFOPT			: String?
	let NAME			: String?
	let Verkehr			: String?
	let Laenge			: Double?
	let Breite			: Double?
	let Betreiber_Nr	: Int?
	let Status			: String?
}