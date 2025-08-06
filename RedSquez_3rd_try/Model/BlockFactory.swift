//
//  BlockFactory.swift
//  RedSquez_3rd_try
//
//  Created by mimi on 8/5/25.
//

// 快速生成各种 block 的工厂方法（带默认值、嵌套结构等）

import Foundation

struct BlockFactory {
    static func makeLEDAction() -> BlockModel {
        BlockModel(
            type: .action,
            name: "LED",
            dropdownOptions: ["on", "off"],
            selectedOption: "on",
            hasInputField: false,
            inputValue: nil
        )
    }

    static func makeWaitAction() -> BlockModel {
        BlockModel(
            type: .action,
            name: "Wait",
            dropdownOptions: nil,
            selectedOption: nil,
            hasInputField: true,
            inputValue: "1.0"
        )
    }
}

