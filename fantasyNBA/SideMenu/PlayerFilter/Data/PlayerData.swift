//
//    RootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PlayerData : Codable {
    
    let assists : Float?
    let blockedShots : Float?
    let defensiveRebounds : Float?
    let doubleDoubles : Float?
    let fantasyPoints : Float?
    let fantasyPointsDraftKings : String?
    let fantasyPointsFanDuel : Float?
    let fieldGoalsAttempted : Float?
    let fieldGoalsMade : Float?
    let fieldGoalsPercentage : Float?
    let freeThrowsAttempted : Float?
    let freeThrowsMade : Float?
    let freeThrowsPercentage : Float?
    let games : Int?
    let minutes : Int?
    let name : String?
    let offensiveRebounds : Float?
    let personalFouls : Float?
    let playerID : Int?
    let plusMinus : Float?
    let points : Float?
    let position : String?
    let rebounds : Float?
    let season : Int?
    let seasonType : Int?
    let seconds : Int?
    let started : Int?
    let statID : Int?
    let steals : Float?
    let team : String?
    let teamID : Int?
    let threePointersAttempted : Float?
    let threePointersMade : Float?
    let threePointersPercentage : Float?
    let tripleDoubles : Float?
    let turnovers : Float?
    let twoPointersAttempted : Float?
    let twoPointersMade : Float?
    let twoPointersPercentage : Float?
    
    
    enum CodingKeys: String, CodingKey {
        case assists = "Assists"
        case blockedShots = "BlockedShots"
        case defensiveRebounds = "DefensiveRebounds"
        case doubleDoubles = "DoubleDoubles"
        case fantasyPoints = "FantasyPoints"
        case fantasyPointsDraftKings = "FantasyPointsDraftKings"
        case fantasyPointsFanDuel = "FantasyPointsFanDuel"
        case fieldGoalsAttempted = "FieldGoalsAttempted"
        case fieldGoalsMade = "FieldGoalsMade"
        case fieldGoalsPercentage = "FieldGoalsPercentage"
        case freeThrowsAttempted = "FreeThrowsAttempted"
        case freeThrowsMade = "FreeThrowsMade"
        case freeThrowsPercentage = "FreeThrowsPercentage"
        case games = "Games"
        case minutes = "Minutes"
        case name = "Name"
        case offensiveRebounds = "OffensiveRebounds"
        case personalFouls = "PersonalFouls"
        case playerID = "PlayerID"
        case plusMinus = "PlusMinus"
        case points = "Points"
        case position = "Position"
        case rebounds = "Rebounds"
        case season = "Season"
        case seasonType = "SeasonType"
        case seconds = "Seconds"
        case started = "Started"
        case statID = "StatID"
        case steals = "Steals"
        case team = "Team"
        case teamID = "TeamID"
        case threePointersAttempted = "ThreePointersAttempted"
        case threePointersMade = "ThreePointersMade"
        case threePointersPercentage = "ThreePointersPercentage"
        case tripleDoubles = "TripleDoubles"
        case turnovers = "Turnovers"
        case twoPointersAttempted = "TwoPointersAttempted"
        case twoPointersMade = "TwoPointersMade"
        case twoPointersPercentage = "TwoPointersPercentage"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        assists = try values.decodeIfPresent(Float.self, forKey: .assists)
        blockedShots = try values.decodeIfPresent(Float.self, forKey: .blockedShots)
        defensiveRebounds = try values.decodeIfPresent(Float.self, forKey: .defensiveRebounds)
        doubleDoubles = try values.decodeIfPresent(Float.self, forKey: .doubleDoubles)
        fantasyPoints = try values.decodeIfPresent(Float.self, forKey: .fantasyPoints)
        fantasyPointsDraftKings = try values.decodeIfPresent(String.self, forKey: .fantasyPointsDraftKings)
        fantasyPointsFanDuel = try values.decodeIfPresent(Float.self, forKey: .fantasyPointsFanDuel)
        fieldGoalsAttempted = try values.decodeIfPresent(Float.self, forKey: .fieldGoalsAttempted)
        fieldGoalsMade = try values.decodeIfPresent(Float.self, forKey: .fieldGoalsMade)
        fieldGoalsPercentage = try values.decodeIfPresent(Float.self, forKey: .fieldGoalsPercentage)
        freeThrowsAttempted = try values.decodeIfPresent(Float.self, forKey: .freeThrowsAttempted)
        freeThrowsMade = try values.decodeIfPresent(Float.self, forKey: .freeThrowsMade)
        freeThrowsPercentage = try values.decodeIfPresent(Float.self, forKey: .freeThrowsPercentage)
        games = try values.decodeIfPresent(Int.self, forKey: .games)
        minutes = try values.decodeIfPresent(Int.self, forKey: .minutes)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        offensiveRebounds = try values.decodeIfPresent(Float.self, forKey: .offensiveRebounds)
        personalFouls = try values.decodeIfPresent(Float.self, forKey: .personalFouls)
        playerID = try values.decodeIfPresent(Int.self, forKey: .playerID)
        plusMinus = try values.decodeIfPresent(Float.self, forKey: .plusMinus)
        points = try values.decodeIfPresent(Float.self, forKey: .points)
        position = try values.decodeIfPresent(String.self, forKey: .position)
        rebounds = try values.decodeIfPresent(Float.self, forKey: .rebounds)
        season = try values.decodeIfPresent(Int.self, forKey: .season)
        seasonType = try values.decodeIfPresent(Int.self, forKey: .seasonType)
        seconds = try values.decodeIfPresent(Int.self, forKey: .seconds)
        started = try values.decodeIfPresent(Int.self, forKey: .started)
        statID = try values.decodeIfPresent(Int.self, forKey: .statID)
        steals = try values.decodeIfPresent(Float.self, forKey: .steals)
        team = try values.decodeIfPresent(String.self, forKey: .team)
        teamID = try values.decodeIfPresent(Int.self, forKey: .teamID)
        threePointersAttempted = try values.decodeIfPresent(Float.self, forKey: .threePointersAttempted)
        threePointersMade = try values.decodeIfPresent(Float.self, forKey: .threePointersMade)
        threePointersPercentage = try values.decodeIfPresent(Float.self, forKey: .threePointersPercentage)
        tripleDoubles = try values.decodeIfPresent(Float.self, forKey: .tripleDoubles)
        turnovers = try values.decodeIfPresent(Float.self, forKey: .turnovers)
        twoPointersAttempted = try values.decodeIfPresent(Float.self, forKey: .twoPointersAttempted)
        twoPointersMade = try values.decodeIfPresent(Float.self, forKey: .twoPointersMade)
        twoPointersPercentage = try values.decodeIfPresent(Float.self, forKey: .twoPointersPercentage)
    }
    
    
}
