//
//  CreateSampleBlocks.swift
//  RedSquez_3rd_try
//
//  Created by cristina hou on 8/5/25.
//

import SwiftUI

func createSampleBlocks() -> [BlockModel] {
    return [
        BlockModel(
                    type: .action,
                    name: "LED",
                    dropdownOptions: ["on", "off"],
                    selectedOption: "on"
                ),
        BlockModel(
                    type: .action,
                    name: "Wait",
                    dropdownOptions: ["yes", "no"],
                    hasInputField: true,
                    inputValue: "1.0"
                )
    ]
}

