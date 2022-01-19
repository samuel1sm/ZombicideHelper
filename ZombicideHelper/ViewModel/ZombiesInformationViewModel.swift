//
//  ZombiesBrain.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 26/11/21.
//

import Foundation
import Combine
import UIKit

class ZombiesInformationViewModel {
    private let zommbieFile = "ZombiesInfo"
    private let separator: String = ","
    private var zombiesList: [ZombieInformations]!
    var filteredList: [ZombieInformations]!
    @Published private(set) var filterOptions: FilterOptions!

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

        return FilterOptions(gamesInfos: gamesInfos, zombieTypeInfos: zombieTypeInfos,
                             minDamageDestroyInfos: minDamageDestroyInfos, damageInflictedInfos: damageInflictedInfos,
                             actionsInfos: actionsInfos)
    }

    func updateFilter(filter: String, key: String) {
        switch filter {
        case Constants.Filters.type:
            filterOptions.zombieTypeInfos[key] = !filterOptions.zombieTypeInfos[key]!
        case Constants.Filters.type:
            filterOptions.damageInflictedInfos[key] = !filterOptions.damageInflictedInfos[key]!
        default:
            print("")
        }
    }

    func filterList (filter: String) {
        if filter != "" {
            filteredList = zombiesList.filter {$0.name.lowercased().contains(filter.lowercased())}
        } else {
            filteredList = zombiesList
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

struct FilterOptions {
    var gamesInfos: [String: Bool]!
    var zombieTypeInfos: [String: Bool]!
    var minDamageDestroyInfos: [String: Bool]!
    var damageInflictedInfos: [String: Bool]!
    var actionsInfos: [String: Bool]!
}
