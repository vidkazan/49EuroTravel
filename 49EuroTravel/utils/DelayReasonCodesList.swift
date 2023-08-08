//
//  Stations.swift
//  49EuroTravel
//
//  Created by Dmitrii Grigorev on 06.05.23.
//

import Foundation

let DelayReasonCodes : [Int: String] =
[
	0: "keine Verspätungsbegründung",
	2: "Polizeiliche Ermittlung",
	3: "Feuerwehreinsatz an der Strecke",
	4: "kurzfristiger Personalausfall",
	5: "ärztliche Versorgung eines Fahrgastes",
	6: "Betätigen der Notbremse",
	7: "Personen im Gleis",
	8: "Notarzteinsatz am Gleis",
	9: "Streikauswirkungen",
	10: "Tiere im Gleis",
	11: "Unwetter",
	12: "Warten auf ein verspätetes Schiff",
	13: "Pass- und Zollkontrolle",
	14: "Technische Störung am Bahnhof",
	15: "Beeinträchtigung durch Vandalismus",
	16: "Entschärfung einer Fliegerbombe",
	17: "Beschädigung einer Brücke",
	18: "umgestürzter Baum im Gleis",
	19: "Unfall an einem Bahnübergang",
	20: "Tiere im Gleis",
	21: "Warten auf Fahrgäste aus einem anderen Zug",
	22: "Witterungsbedingte Störung",
	23: "Feuerwehreinsatz auf Bahngelände",
	24: "Verspätung im Ausland",
	25: "Warten auf weitere Wagen",
	28: "Gegenstände im Gleis",
	29: "Ersatzverkehr mit Bus ist eingerichtet",
	31: "Bauarbeiten",
	32: "Verzögerung beim Ein-/Ausstieg",
	33: "Oberleitungsstörung",
	34: "Signalstörung",
	35: "Streckensperrung",
	36: "technische Störung am Zug",
	38: "technische Störung an der Strecke",
	39: "Anhängen von zusätzlichen Wagen",
	40: "Stellwerksstörung /-ausfall",
	41: "Störung an einem Bahnübergang",
	42: "außerplanmäßige Geschwindigkeitsbeschränkung",
	43: "Verspätung eines vorausfahrenden Zuges",
	44: "Warten auf einen entgegenkommenden Zug",
	45: "Überholung",
	46: "Warten auf freie Einfahrt",
	47: "verspätete Bereitstellung des Zuges",
	48: "Verspätung aus vorheriger Fahrt",
	55: "technische Störung an einem anderen Zug",
	56: "Warten auf Fahrgäste aus einem Bus",
	57: "Zusätzlicher Halt zum Ein-/Ausstieg für Reisende",
	58: "Umleitung des Zuges",
	59: "Schnee und Eis",
	60: "Reduzierte Geschwindigkeit wegen Sturm",
	61: "Türstörung",
	62: "behobene technische Störung am Zug",
	63: "technische Untersuchung am Zug",
	64: "Weichenstörung",
	65: "Erdrutsch",
	66: "Hochwasser",
	70: "WLAN im gesamten Zug nicht verfügbar",
	71: "WLAN in einem/mehreren Wagen nicht verfügbar",
	72: "Info-/Entertainment nicht verfügbar",
	73: "Heute: Mehrzweckabteil vorne",
	74: "Heute: Mehrzweckabteil hinten",
	75: "Heute: 1. Klasse vorne",
	76: "Heute: 1. Klasse hinten",
	77: "ohne 1. Klasse",
	79: "ohne Mehrzweckabteil",
	80: "andere Reihenfolge der Wagen",
	82: "mehrere Wagen fehlen",
	83: "Störung fahrzeuggebundene Einstiegshilfe",
	84: "Zug verkehrt richtig gereiht",
	85: "ein Wagen fehlt",
	86: "gesamter Zug ohne Reservierung",
	87: "einzelne Wagen ohne Reservierung",
	88: "keine Qualitätsmängel",
	89: "Reservierungen sind wieder vorhanden",
	90: "kein gastronomisches Angebot",
	91: "fehlende Fahrradbeförderung",
	92: "Eingeschränkte Fahrradbeförderung",
	93: "keine behindertengerechte Einrichtung",
	94: "Ersatzbewirtschaftung",
	95: "Ohne behindertengerechtes WC",
	96: "Überbesetzung mit Kulanzleistungen",
	97: "Überbesetzung ohne Kulanzleistungen",
	98: "sonstige Qualitätsmängel",
	99: "Verzögerungen im Betriebsablauf"
]