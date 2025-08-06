//
//  ActionBlockShape.swift
//  RedSquez_3rd_try
//
//  Created by cristina hou on 8/5/25.
//

import SwiftUI

import SwiftUI

// ✅ 统一凹槽 X 位置的共享常量
struct SharedSlot {
    static let tabWidth: CGFloat = 30
    static let tabHeight: CGFloat = 8
    static let slotStartRatio: CGFloat = 0.3
    static var slotX: CGFloat { 250 * slotStartRatio } // ✅ 所有模块统一使用
}

////// 拼图块外形：带顶部凹槽 + 底部凸槽，兼容 SharedSlot 系统

///
struct ActionBlockShape: Shape {
    // ✅ 使用 SharedSlot 统一槽位参数
    static var topSlotX: CGFloat { SharedSlot.slotX }
    static var bottomSlotSpacing: CGFloat { 50 - SharedSlot.tabHeight } // ActionBlock 高度 50

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let tabWidth = SharedSlot.tabWidth
        let tabHeight = SharedSlot.tabHeight
        let slotStartX = SharedSlot.slotX

        // ---------- 顶部 ----------
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: slotStartX, y: 0))
        path.addLine(to: CGPoint(x: slotStartX + 4, y: tabHeight))
        path.addLine(to: CGPoint(x: slotStartX + tabWidth - 4, y: tabHeight))
        path.addLine(to: CGPoint(x: slotStartX + tabWidth, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))

        // ---------- 右侧 ----------
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - tabHeight))

        // ---------- 底部 ----------
        path.addLine(to: CGPoint(x: slotStartX + tabWidth, y: rect.height - tabHeight))
        path.addLine(to: CGPoint(x: slotStartX + tabWidth - 4, y: rect.height))
        path.addLine(to: CGPoint(x: slotStartX + 4, y: rect.height))
        path.addLine(to: CGPoint(x: slotStartX, y: rect.height - tabHeight))

        // ---------- 左侧 ----------
        path.addLine(to: CGPoint(x: 0, y: rect.height - tabHeight))
        path.addLine(to: CGPoint(x: 0, y: 0))

        path.closeSubpath()
        return path
    }
}
