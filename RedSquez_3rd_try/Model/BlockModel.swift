//
//  BlockModel.swift
//  RedSquez_3rd_try
//
//  Created by mimi on 8/5/25.
//

import SwiftUI

/// Block 数据模型
struct BlockModel: Identifiable {
    let id: UUID = UUID()
    var type: BlockType
    var name: String?
    var offset: CGSize = .zero   // 拖动偏移，用于渲染位置

    var nextID: UUID?
    var parentID: UUID?

    
    var substackID: UUID?
    var elseSubstackID: UUID?
    var conditionBlockID: UUID?
    
    // ✅ 新增：用于支持 ActionBlockView 的可选控件
        var dropdownOptions: [String]? = nil
        var selectedOption: String? = nil
        var hasInputField: Bool = false
        var inputValue: String? = nil
}

