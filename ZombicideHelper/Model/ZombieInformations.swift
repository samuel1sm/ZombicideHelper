//
//  ZombieInformations.swift
//  ZombicideHelper
//
//  Created by FRANCISCO SAMUEL DA SILVA MARTINS on 20/11/21.
//

import Foundation

struct ZombieInformations {
    let name: String
    let zombieArtUrl: String
    let zombieModelUrl: String
    let zombieText: String
    let game: String
    let zombieType: String
    let description: String
    let status: ZombieStatus
}

struct ZombieStatus {
    let targetPriority: Int
    let actions: String
    let minDamageDestroy: Int
    let experienceProvided: Int
    let damageInflicted: String
}
