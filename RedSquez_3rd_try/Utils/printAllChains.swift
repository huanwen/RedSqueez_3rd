// PrintAllChains.swift
// RedSquez_3rd_try
//
// Created by mimi on 8/6/25.

import Foundation

/// 🔧 打印当前 blocks 中所有元素和链表结构
func printAllChains(from blocks: [BlockModel]) {
    print("🧩 当前 Blocks 列表：")
    for block in blocks {
        print("- \(block.name ?? "Unnamed") (id: \(block.id), nextID: \(block.nextID?.uuidString ?? "nil"))")
    }

    var visited = Set<UUID>()
    var chainCount = 0

    for block in blocks {
        // 跳过已属于其他链的 block
        if visited.contains(block.id) { continue }

        // 收集并打印链
        let chain = BlockChainUtils.collectChain(from: block, in: blocks)
        visited.formUnion(chain.map { $0.id })

        chainCount += 1
        let names = chain.compactMap { $0.name }.joined(separator: " → ")
        print("🔗 链 #\(chainCount): \(names)")
    }
}
