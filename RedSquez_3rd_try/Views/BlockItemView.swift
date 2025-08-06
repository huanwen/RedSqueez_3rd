import SwiftUI

/// 单个 block 的基础视图（暂时仅展示 ActionBlock）
struct BlockItemView: View {
    @Binding var block: BlockModel
    @Binding var allBlocks: [BlockModel]
    @Binding var selectedBlockID: UUID?

    @GestureState private var dragOffset: CGSize = .zero
    @State private var showDeleteButton: Bool = false

    var body: some View {
        let isSelected = selectedBlockID == block.id

        return Group {
            switch block.type {
            case .action:
                ZStack(alignment: .topTrailing) {
                    // ✅ Block 本体
                    ActionBlockView(
                        block: block,
                        isSelected: isSelected,
                        
                        showDeleteButton: showDeleteButton,
                        onDelete: {
                            if let index = allBlocks.firstIndex(where: { $0.id == block.id }) {
                                allBlocks.remove(at: index)
                                selectedBlockID = nil
                            }
                        },
                        pickerSelection: $block.selectedOption,
                        inputText: $block.inputValue
                    )
                    .offset(x: block.offset.width + dragOffset.width,
                            y: block.offset.height + dragOffset.height)
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation
                            }
                            .onEnded { value in
                                block.offset.width = max(0, block.offset.width + value.translation.width)
                                block.offset.height = max(0, block.offset.height + value.translation.height)
                            }
                    )
                    .onTapGesture {
                        selectedBlockID = block.id
                        showDeleteButton = false // 点击时关闭删除按钮
                    }
                    .simultaneousGesture(
                        LongPressGesture(minimumDuration: 0.8)
                            .onEnded { _ in
                                if isSelected {
                                    showDeleteButton = true
                                }
                            }
                    )
                }

            default:
                EmptyView()
            }
        }
    }
}
