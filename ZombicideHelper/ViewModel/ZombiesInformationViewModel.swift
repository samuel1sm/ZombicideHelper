//
//  ZombiesBrain.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 26/11/21.
//

import Combine
import UIKit

class ZombiesInformationViewModel {
    private let zommbieFile = "ZombiesInfo"
    private let separator: String = ","
    private var zombiesList: [ZombieInformations]!
    var filteredList: [ZombieInformations]!
    private(set) var filterOptions: FilterOptions!

    init() {
        zombiesList = readCsv(inputFile: zommbieFile, separator: separator)
        filteredList = zombiesList

        filterOptions = createFilterOtions()
    }

    private func createFilterOtions() -> FilterOptions {
        var gamesInfos = [String: Bool]()
        var zombieTypeInfos = [String: Bool]()
        var minDamageDestroyInfos = [String: Bool]()
        var damageInflictedInfos = [String: Bool]()
        var actionsInfos = [String: Bool]()

        zombiesList.forEach { gamesInfos[$0.game] = false}
        zombiesList.forEach { zombieTypeInfos[$0.zombieType] = false}
        zombiesList.forEach { minDamageDestroyInfos[$0.status.minDamageDestroy] = false}
        zombiesList.forEach { damageInflictedInfos[$0.status.damageInflicted] = false}
        zombiesList.forEach { actionsInfos[$0.status.actions] = false}

        return FilterOptions(gamesInfos: gamesInfos, zombieType: zombieTypeInfos,
                             life: minDamageDestroyInfos, damage: damageInflictedInfos,
                             actions: actionsInfos)
    }

    func updateFilter(filter: String, key: String) -> Bool {
        var value: Bool!
        switch filter {
        case Constants.Filters.type:
            value = !filterOptions.zombieType[key]!
            filterOptions.zombieType[key] = value
        case Constants.Filters.damage:
            value = !filterOptions.damage[key]!
            filterOptions.damage[key] = value
        case Constants.Filters.actions:
            value = !filterOptions.actions[key]!
            filterOptions.actions[key] = value
        case Constants.Filters.expantions:
            value = !filterOptions.gamesInfos[key]!
            filterOptions.gamesInfos[key] = value
        case Constants.Filters.life:
            value = !filterOptions.life[key]!
            filterOptions.life[key] = value
        default:
            print("")
        }

        return value
    }

    func filterList (filter: String) {
        if filter != "" {
            filteredList = zombiesList.filter {$0.name.lowercased().contains(filter.lowercased())}
        } else {
            filteredList = zombiesList
        }
    }

    func getButtonState(filter: String, key: String) -> Bool {
        switch filter {
        case Constants.Filters.type:
            return filterOptions.zombieType[key]!
        case Constants.Filters.damage:
            return filterOptions.damage[key]!
        case Constants.Filters.actions:
            return filterOptions.actions[key]!
        case Constants.Filters.expantions:
            return filterOptions.gamesInfos[key]!
        case Constants.Filters.life:
            return filterOptions.life[key]!
        default:
            return false
        }
    }

    func getZombieInformation(zombie: Int) -> ZombieInformations {
        return filteredList[zombie]
    }

    private func readCsv(inputFile: String, separator: String) -> [ZombieInformations] {
        var result = [ZombieInformations]()
        guard let filePath = Bundle.main.path(forResource: inputFile, ofType: "csv") else {return []}
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error)
            return []
        }
        let splitedData = data.split(separator: "\n").dropFirst()

        for info in splitedData {
            let line = info.components(separatedBy: separator)
            let zombieStatus = ZombieStatus(targetPriority: Int(line[4])!, actions: String(line[5]),
                                            minDamageDestroy: String(line[6]), experienceProvided: Int(line[7])!,
                                            damageInflicted: String(line[8]))

            let zombie = ZombieInformations(name: String(line[0]), zombieArtUrl: String(line[1]),
                                            zombieModelUrl: String(line[2]), zombieText: String(line[3]),
                                            game: String(line[9]), zombieType: String(line[10]),
                                            description: String(line[11]), status: zombieStatus)

            result.append(zombie)
        }

        return result
    }
}

class FilterOptions {
    @Published var gamesInfos: [String: Bool]!
    @Published var zombieType: [String: Bool]!
    @Published var life: [String: Bool]!
    @Published var damage: [String: Bool]!
    @Published var actions: [String: Bool]!

    init(gamesInfos: [String: Bool]!, zombieType: [String: Bool]!,
         life: [String: Bool]!, damage: [String: Bool]!,
         actions: [String: Bool]!) {
        self.gamesInfos = gamesInfos
        self.actions = actions
        self.zombieType = zombieType
        self.damage = damage
        self.life = life
    }
}
