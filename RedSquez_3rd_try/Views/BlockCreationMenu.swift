//
//  BlockCreationMenu.swift
//  RedSquez_3rd_try
//
//  Created by mi mi on 8/5/25.
//

import SwiftUI

struct BlockCreationMenu: View {
    var onAddBlock: (BlockModel) -> Void

    var body: some View {
        HStack {
            Spacer()
            Menu("➕ 添加 Block") {
                Button("LED") {
                    let newBlock = BlockFactory.makeLEDAction()
                    onAddBlock(newBlock)
                }
                Button("Wait") {
                    let newBlock = BlockFactory.makeWaitAction()
                    onAddBlock(newBlock)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            Spacer()
        }
        .padding(.bottom, 12)
        .background(Color(UIColor.systemGray6))
    }
}
