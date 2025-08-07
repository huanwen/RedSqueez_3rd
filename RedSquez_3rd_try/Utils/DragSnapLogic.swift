//
//  DragSnapLogic.swift
//  RedSquez_3rd_try
//
//  Created by mi mi on 8/6/25.
//


import Foundation
import CoreGraphics

/// ✅ 处理拖拽吸附逻辑（链式结构吸附）
struct DragSnapLogic {

    /// 判断是否可以将 draggedBlock 吸附到某个 block 的尾部（返回目标 block）
    /// 判断是否可以将 draggedBlock 吸附到某个 block 的尾部（返回目标 block）
    static func findSnapTarget(
        for draggedBlock: BlockModel,
        among blocks: [BlockModel],
        threshold: CGFloat = 20
    ) -> BlockModel? {
        let blockHeight: CGFloat = 50

        let draggedTop = CGPoint(
            x: draggedBlock.offset.width,
            y: draggedBlock.offset.height
        )
        let draggedBottom = CGPoint(
            x: draggedBlock.offset.width,
            y: draggedBlock.offset.height + blockHeight
        )

        for other in blocks {
            guard other.id != draggedBlock.id else { continue } // 不和自己比
            guard other.nextID == nil else { continue } // 只能吸附到链尾

            let otherTop = CGPoint(
                x: other.offset.width,
                y: other.offset.height
            )
            let otherBottom = CGPoint(
                x: other.offset.width,
                y: other.offset.height + blockHeight
            )

            // ✅ 方向 1：拖动的顶部对齐目标的底部
            let dx1 = abs(draggedTop.x - otherBottom.x)
            let dy1 = abs(draggedTop.y - otherBottom.y)
            if dx1 < threshold && dy1 < threshold {
                return other
            }

            // ✅ 方向 2：拖动的底部对齐目标的顶部
            let dx2 = abs(draggedBottom.x - otherTop.x)
            let dy2 = abs(draggedBottom.y - otherTop.y)
            if dx2 < threshold && dy2 < threshold {
                return other
            }
        }

        return nil
    }


    /// 将 draggedBlock 链插入到 targetBlock 后面（修改 blocks）
    static func snap(_ draggedBlock: BlockModel, to targetBlock: BlockModel, in blocks: inout [BlockModel]) {
        let draggedY = draggedBlock.offset.height
        let targetY = targetBlock.offset.height
        
        print("🔄 开始吸附逻辑判断...")
            print("📍 draggedBlock: \(draggedBlock.name ?? "Unnamed") (\(draggedBlock.id))")
            print("📍 targetBlock: \(targetBlock.name ?? "Unnamed") (\(targetBlock.id))")
            print("🧭 draggedY: \(draggedY), targetY: \(targetY)")

        if draggedY > targetY {
            print("➡️ 正向吸附：将 draggedChain 接到 targetChain 后")
            let draggedChain = BlockChainUtils.deleteChain(startingFrom: draggedBlock, in: &blocks)
            print("🧹 删除 draggedChain：[\(draggedChain.map { $0.name ?? "Unnamed" }.joined(separator: " → "))]")

             let tail = BlockChainUtils.tail(of: targetBlock, in: blocks)
                for b in draggedChain {
                    BlockChainUtils.insertBlock(b, after: tail, in: &blocks)

                    print("✅ 插入到 target 的尾部后：\(tail.name ?? "Unnamed") (\(tail.id))")

                }
            
        } else {
            // ✅ 反向吸附：将 targetChain 插入 draggedBlock 的尾部
            print("⬅️ 反向吸附：将 targetChain 接到 draggedChain 后")

            let targetChain = BlockChainUtils.deleteChain(startingFrom: targetBlock, in: &blocks)
            print("🧹 删除 targetChain：[\(targetChain.map { $0.name ?? "Unnamed" }.joined(separator: " → "))]")

            let tail = BlockChainUtils.tail(of: draggedBlock, in: blocks)
                for b in targetChain {
                    BlockChainUtils.insertBlock(b, after: tail, in: &blocks)
                    print("✅ 插入到 dragged 的尾部后：\(tail.name ?? "Unnamed")(\(tail.id))")

                }
            
        }

        print("✅ 吸附成功：\(draggedBlock.name ?? "") → \(targetBlock.name ?? "")")
        printAllChains(from: blocks)
    }

}

