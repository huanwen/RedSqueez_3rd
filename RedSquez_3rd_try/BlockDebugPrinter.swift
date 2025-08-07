//
//  CreateSampleBlocks.swift
//  RedSquez_3rd_try
//
//  Created by mimi  on 8/5/25.
//

import Foundation

func printChain(_ chain: [BlockModel]) {
    let names = chain.map { $0.name ?? "Unnamed" }
    print("🔗 Block Chain: \(names.joined(separator: " → "))")
}

func printBlocks(_ blocks: [BlockModel]) {
    print("🧩 All Blocks:")
    for block in blocks {
        print("- \(block.name ?? "Unnamed") (id: \(block.id), nextID: \(block.nextID?.uuidString ?? "nil"))")
    }
}
