import SwiftUI

/// ActionBlock 视图：可包含文本、下拉菜单、输入框
struct ActionBlockView: View {
    var block: BlockModel
    var isSelected: Bool
    var showDeleteButton: Bool
    var onDelete: () -> Void

    @Binding var pickerSelection: String?
    @Binding var inputText: String?

    var body: some View {
        ZStack() {
            // ✅ 背景形状 + 高亮边框
            ActionBlockShape()
                .fill(Color.blue)
                .overlay(
                    ActionBlockShape()
                        .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 3)
                )

            // ✅ Block 内容
            HStack(spacing: 8) {
                Text(block.name ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .fontWeight(.bold)

                if block.dropdownOptions != nil {
                    Picker("", selection: Binding<String>(
                        get: { pickerSelection ?? "" },
                        set: { pickerSelection = $0 }
                    )) {
                        ForEach(block.dropdownOptions!, id: \.self) { option in
                            Text(option).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80, height: 25)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }

                if block.hasInputField {
                    TextField("seconds", text: Binding<String>(
                        get: { inputText ?? "" },
                        set: { inputText = $0 }
                    ))
                    .keyboardType(.decimalPad)
                    .frame(width: 60, height: 25)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.white)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }

                Spacer()
            }
            .padding(.horizontal, 12)

            // ✅ 删除按钮
            if isSelected && showDeleteButton {
                Button(action: {
                    onDelete()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                .offset(x: 10, y: -10)
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .frame(minWidth: 200, maxWidth: 400, minHeight: 50, maxHeight: 50, alignment: .leading)
    }
}
