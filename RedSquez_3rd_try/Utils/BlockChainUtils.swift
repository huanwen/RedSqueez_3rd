//  BlockChainUtils.swift
//  RedSquez_3rd_try
//
//  Created by mimi on 8/6/25.

import Foundation

/// ✅ 工具函数：处理 block 链表结构（基于 nextID 实现）
struct BlockChainUtils {
    
    /// 🔗 从一个 block 开始收集完整链
    static func collectChain(from startBlock: BlockModel, in blocks: [BlockModel]) -> [BlockModel] {
        var chain: [BlockModel] = [startBlock]
        var current = startBlock
        
        while let nextID = current.nextID,
              let nextBlock = blocks.first(where: { $0.id == nextID }) {
            chain.append(nextBlock)
            current = nextBlock
        }
        return chain
    }
    
    /// 🔗 插入一个 block 到某个 block 之后（更新 nextID）
    static func insertBlock(_ newBlock: BlockModel, after target: BlockModel, in blocks: inout [BlockModel]) {
        var newBlock = newBlock // ⬅️ 这里加上 var 关键字
        
        guard let index = blocks.firstIndex(where: { $0.id == target.id }) else { return }
        
        // ✅ 更新链关系
        newBlock.nextID = target.nextID
        blocks.append(newBlock) // 添加新 block
        
        blocks[index].nextID = newBlock.id
    }
    
    /// ✂️ 移除从某个 block 开始的整个链条
    /// 清除链条的连接关系，但保留 block 本身（不会从数组中移除）
    static func deleteChain(startingFrom startBlock: BlockModel, in blocks: inout [BlockModel]) -> [BlockModel] {
        /*       let chain = collectChain(from: startBlock, in: blocks)
         let chainIDs = Set(chain.map { $0.id })
         
         for i in 0..<blocks.count {
         if chainIDs.contains(blocks[i].id) {
         blocks[i].nextID = nil
         blocks[i].parentID = nil
         }
         }
         
         // 清除其他 block 指向链起点的引用（即断开前驱）
         for i in 0..<blocks.count {
         if blocks[i].nextID == startBlock.id {
         blocks[i].nextID = nil
         }
         }
         
         return chain */
        
        let fullChain = collectChain(from: startBlock, in: blocks)
        let idsToRemove = Set(fullChain.map { $0.id })
        
        // 删除 blocks 中的所有链元素
        blocks.removeAll { idsToRemove.contains($0.id) }
        
        return fullChain
        
        
    }
    
    
    // 🔚 找到链条的尾部 block
    static func tail(of block: BlockModel, in blocks: [BlockModel]) -> BlockModel {
        print("🔍 [tail] 开始寻找链尾: \(block.name ?? "") (\(block.id))")
        var current = block

        while let nextID = current.nextID {
            if let next = blocks.first(where: { $0.id == nextID }) {
                print("   ⬇️ 当前: \(current.name ?? "") (\(current.id)), nextID: \(nextID.uuidString)")
                current = next
            } else {
                print("   ❌ 未找到 nextID \(nextID.uuidString)，停止")
                break
            }
        }

        print("✅ 链尾是: \(current.name ?? "") (\(current.id))")
        return current
    }

    // 🔍 找到链的头部 block（基于 parentID 向上找）
    static func head(of block: BlockModel, in blocks: [BlockModel]) -> BlockModel {
        print("🔍 [head] 开始寻找链头: \(block.name ?? "") (\(block.id))")
        var current = block

        while let parentID = current.parentID {
            print("   ⬆️ 当前: \(current.name ?? "") (\(current.id)), parentID: \(parentID.uuidString)")
            if let parent = blocks.first(where: { $0.id == parentID }) {
                print("   🔗 找到父节点: \(parent.name ?? "") (\(parent.id))")
                current = parent
            } else {
                print("   ❌ 未找到父节点 \(parentID.uuidString)，停止")
                break
            }
        }

        print("✅ 链头是: \(current.name ?? "") (\(current.id))")
        return current
    }

    
    
}
