import SwiftUI

struct BlockCreationMenu: View {
    var onAddBlock: (BlockModel) -> Void

    // 未来可扩展更多 block 类型
    private let blockTypes: [(title: String, factory: () -> BlockModel)] = [
        ("LED", BlockFactory.makeLEDAction),
        ("Wait", BlockFactory.makeWaitAction)
        // 可继续加更多类型
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(blockTypes, id: \.title) { item in
                    Button(action: {
                        onAddBlock(item.factory())
                    }) {
                        Text(item.title)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
        .background(Color(UIColor.systemGray6))
    }
}
