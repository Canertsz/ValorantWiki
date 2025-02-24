import Foundation

// MARK: - Main Object
struct AgentResponse: Codable {
    var status: Int32?
    var data: [Agent]?
}

// MARK: - Data Object
struct Agent: Codable, Equatable {
    static func == (lhs: Agent, rhs: Agent) -> Bool {
        return lhs.displayName == rhs.displayName
    }
    
    var uuid: String?
    var displayName: String?
    var description: String?
    var developerName: String?
    var characterTags: [String]?
    var displayIcon: String?
    var displayIconSmall: String?
    var bustPortrait: String?
    var fullPortrait: String?
    var fullPortraitV2: String?
    var killfeedPortrait: String?
    var background: String?
    var backgroundGradientColors: [String]?
    var assetPath: String?
    var isFullPortraitRightFacing: Bool?
    var isPlayableCharacter: Bool?
    var isAvailableForTest: Bool?
    var isBaseContent: Bool?
    var role: Role?
    var recruitmentData: RecruitmentData?
    var abilities: [Ability]?
    var voiceLine: VoiceLine?
}

// MARK: - Role
struct Role: Codable {
    var uuid: String?
    var displayName: String?
    var description: String?
    var displayIcon: String?
    var assetPath: String?
}

// MARK: - Recruitment Data
struct RecruitmentData: Codable {
    var counterId: String?
    var milestoneId: String?
    var milestoneThreshold: Int32?
    var useLevelVpCostOverride: Bool?
    var levelVpCostOverride: Int32?
    var startDate: String?
    var endDate: String?
}

// MARK: - Ability
struct Ability: Codable {
    var slot: String?
    var displayName: String?
    var description: String?
    var displayIcon: String?
    var voiceLine: VoiceLine?
    var minDuration: Float?
    var maxDuration: Float?
    var mediaList: [Media]?
}

// MARK: - Voice Line
struct VoiceLine: Codable {
    var minDuration: Float?
    var maxDuration: Float?
    var mediaList: [Media]?
}

// MARK: - Media
struct Media: Codable {
    var id: Int32?
    var wwise: String?
    var wave: String?
}
