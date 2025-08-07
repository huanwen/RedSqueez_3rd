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
        .onAppear {
            checkForDuplicateIDs()
        }
        .onChange(of: blocks) { _ in
            checkForDuplicateIDs()
        }
    }

    private func checkForDuplicateIDs() {
        print("🧩 BlockAreaView 渲染前 block 列表：")
        let ids = blocks.map { $0.id }
        let idSet = Set(ids)
        if ids.count != idSet.count {
            let duplicates = Dictionary(grouping: ids, by: { $0 }).filter { $1.count > 1 }
            print("⚠️ 重复 ID 警告：有 \(ids.count - idSet.count) 个重复 ID")
            print("🔁 重复 ID 列表：")
            for (id, group) in duplicates {
                print("- \(id) 出现了 \(group.count) 次")
            }
        }
    }
}
