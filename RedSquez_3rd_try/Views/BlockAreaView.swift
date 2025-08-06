//
//  BlockAreaView.swift
//  RedSquez_3rd_try
//
//  Created by cristina hou on 8/5/25.
//

import SwiftUI

struct BlockAreaView: View {
    @Binding var blocks: [BlockModel]
    @Binding var selectedBlockID: UUID?

    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach($blocks) { $block in
                BlockItemView(
                    block: $block,
                    allBlocks: $blocks,
                    selectedBlockID: $selectedBlockID
                )
            }
        }
    }
}

