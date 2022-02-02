//
//  ZombiesBrain.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 26/11/21.
//

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

    func updateFilter(filter: String, rule: String) -> Bool {
            var value: Bool!
            switch filter {
            case Constants.Filters.type:
                value = !filterOptions.zombieType[rule]!
                filterOptions.zombieType[rule] = value
            case Constants.Filters.damage:
                value = !filterOptions.damage[rule]!
                filterOptions.damage[rule] = value
            case Constants.Filters.actions:
                value = !filterOptions.actions[rule]!
                filterOptions.actions[rule] = value
            case Constants.Filters.expantions:
                value = !filterOptions.gamesInfos[rule]!
                filterOptions.gamesInfos[rule] = value
            case Constants.Filters.life:
                value = !filterOptions.life[rule]!
                filterOptions.life[rule] = value
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

    func clearFilters() {
        filterOptions.zombieType.keys.forEach { filterOptions.zombieType[$0] = false}
        filterOptions.damage.keys.forEach { filterOptions.damage[$0] = false}
        filterOptions.actions.keys.forEach { filterOptions.actions[$0] = false}
        filterOptions.gamesInfos.keys.forEach { filterOptions.gamesInfos[$0] = false}
        filterOptions.life.keys.forEach { filterOptions.life[$0] = false}
    }

    func getButtonState(filter: String, rule: String) -> Bool {
        switch filter {
        case Constants.Filters.type:
            return filterOptions.zombieType[rule]!
        case Constants.Filters.damage:
            return filterOptions.damage[rule]!
        case Constants.Filters.actions:
            return filterOptions.actions[rule]!
        case Constants.Filters.expantions:
            return filterOptions.gamesInfos[rule]!
        case Constants.Filters.life:
            return filterOptions.life[rule]!
        default:
            return false
        }
    }

    func loadFilters() {
        filteredList = zombiesList
        var activeFilters = getActiveFilters(filter: Constants.Filters.actions)

        if !activeFilters.isEmpty {
            filteredList = filteredList.filter { activeFilters.contains($0.status.actions) }
        }

        activeFilters = getActiveFilters(filter: Constants.Filters.life)

        if !activeFilters.isEmpty {
            filteredList = filteredList.filter { activeFilters.contains($0.status.minDamageDestroy) }
        }

        activeFilters = getActiveFilters(filter: Constants.Filters.damage)

        if !activeFilters.isEmpty {
            filteredList = filteredList.filter { activeFilters.contains($0.status.damageInflicted) }
        }

        activeFilters = getActiveFilters(filter: Constants.Filters.type)

        if !activeFilters.isEmpty {
            filteredList = filteredList.filter { activeFilters.contains($0.zombieType) }
        }

        activeFilters = getActiveFilters(filter: Constants.Filters.expantions)

        if !activeFilters.isEmpty {
            filteredList = filteredList.filter { activeFilters.contains($0.game) }
        }

    }

    private func getActiveFilters(filter: String) -> [String] {
        switch filter {
        case Constants.Filters.type:
            return filterOptions.zombieType.filter { $0.value }.map {$0.key}
        case Constants.Filters.damage:
            return filterOptions.damage.filter { $0.value }.map {$0.key}
        case Constants.Filters.actions:
            return filterOptions.actions.filter { $0.value }.map {$0.key}
        case Constants.Filters.expantions:
            return filterOptions.gamesInfos.filter { $0.value }.map {$0.key}
        case Constants.Filters.life:
            return filterOptions.life.filter { $0.value }.map {$0.key}
        default:
            return []
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
    var gamesInfos: [String: Bool]!
    var zombieType: [String: Bool]!
    var life: [String: Bool]!
    var damage: [String: Bool]!
    var actions: [String: Bool]!

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
