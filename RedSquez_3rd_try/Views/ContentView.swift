//
//  ContentView.swift
//  RedSquez_3rd_try
//
//  Created by mimi on 8/5/25.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
#endif


struct ContentView: View {
    @State private var blocks: [BlockModel] = []
    @State private var selectedBlockID: UUID? = nil

    var body: some View {
        VStack(spacing: 0) {
            // ✅ 可滚动区域（整块红色画布 + blocks）
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                ZStack(alignment: .topLeading) {
                    // ✅ 红色背景 + 自动拉伸尺寸
                    Color.white
                        .frame(
                            width: canvasSize.width,
                            height: canvasSize.height
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideKeyboard()
                            selectedBlockID = nil
                        }

                    // ✅ blocks 区域
                    BlockAreaView(
                        blocks: $blocks,
                        selectedBlockID: $selectedBlockID
                    )
                }
                .padding()
            }

            // ✅ 固定底部菜单
            BlockCreationMenu { newBlock in
                var block = newBlock
                block.offset = CGSize(width: 20, height: 100)
                blocks.append(block)
            }
            .background(Color.white.shadow(radius: 4))
        }
    }

    // ✅ 自动根据 block 位置延伸 canvas 尺寸
    var canvasSize: CGSize {
        let padding: CGFloat = 100
        let maxX = blocks.map { $0.offset.width }.max() ?? 0
        let maxY = blocks.map { $0.offset.height }.max() ?? 0
        return CGSize(
            width: max(maxX + padding, 2000),
            height: max(maxY + padding, 2000)
        )
    }
}
