//
//  ZombiesBrain.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 26/11/21.
//

import Foundation

struct ZombiesInformationViewModel {
    private let zommbieFile = "ZombiesInfo"
    private let separator: String = ","
    private var zombiesList: [ZombieInformations]!
    var filteredList: [ZombieInformations]!

    init() {
        zombiesList = readCsv(inputFile: zommbieFile, separator: separator)
        filteredList = zombiesList
    }

    mutating func filterList (filter: String) {
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
