//
//  InfinityScrollView.swift
//  WBApp
//
//  Created by Alina Potapova on 27.06.2024.
//

import SwiftUI

struct Emoji {
    static var all: [String] = {
        var emojis: [String] = []
        let emojiRanges: [ClosedRange<Int>] = [
            0x1F300...0x1F5FF,
            0x1F600...0x1F64F,
            0x1F680...0x1F6FF,
            0x1F700...0x1F77F,
            0x1F780...0x1F7FF,
            0x1F800...0x1F8FF,
            0x1F900...0x1F9FF,
            0x1FA00...0x1FA6F,
            0x1FA70...0x1FAFF,
            0x2600...0x26FF,
            0x2700...0x27BF
        ]
        
        for range in emojiRanges {
            for i in range {
                if let scalar = UnicodeScalar(i), scalar.properties.isEmoji {
                    emojis.append(String(scalar))
                }
            }
        }
        
        return Array(repeating: emojis, count: 100).flatMap { $0 }
    }()
}

struct LayoutMetrics {
    let columns: Int

    var fontSize: CGFloat {
        switch columns {
        case 1: return 250
        case 2: return 100
        case 3: return 50
        case 4: return 30
        default: return 20
        }
    }

    var padding: CGFloat {
        interpolatedSize(min: 10, max: 40)
    }

    var spacing: CGFloat {
        interpolatedSize(min: 10, max: 40)
    }

    var cornerRadius: CGFloat {
        interpolatedSize(min: 5, max: 20)
    }

    var strokeWidth: CGFloat {
        interpolatedSize(min: 3, max: 8)
    }

    var dashPattern: [CGFloat] {
        [
            interpolatedSize(min: 3, max: 10),
            interpolatedSize(min: 1, max: 7),
            interpolatedSize(min: 7, max: 18)
        ]
    }

    private func interpolatedSize(min: CGFloat, max: CGFloat) -> CGFloat {
        let maxColumns = 4
        let fraction = CGFloat(columns - 1) / CGFloat(maxColumns - 1)
        return max - fraction * (max - min)
    }
}

enum CellLayout: CaseIterable {
    case left, right, top, bottom

    static var randomLayout: CellLayout {
        return CellLayout.allCases.randomElement()!
    }
}

struct EmojiCell: View {
    let emoji: String
    let layout: CellLayout
    let metrics: LayoutMetrics

    var body: some View {
        ZStack {
            switch layout {
            case .left: left
            case .right: right
            case .top: top
            case .bottom: bottom
            }

            Text(emoji)
                .font(.system(size: metrics.fontSize))
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .padding(metrics.padding)
                .background(Color.red)
    }

    private var left: some View {
        HStack(spacing: metrics.spacing) {
            randomRectangle
            VStack(spacing: metrics.spacing) {
                randomRectangle
                randomRectangle
            }
        }
    }

    private var right: some View {
        HStack(spacing: metrics.spacing) {
            VStack(spacing: metrics.spacing) {
                randomRectangle
                randomRectangle
            }
            randomRectangle
        }
    }
    
    private var bottom: some View {
        VStack(spacing: metrics.spacing) {
            HStack(spacing: metrics.spacing) {
                randomRectangle
                randomRectangle
            }
            randomRectangle
        }
    }

    private var top: some View {
        VStack(spacing: metrics.spacing) {
            randomRectangle
            HStack(spacing: metrics.spacing) {
                randomRectangle
                randomRectangle
            }
        }
    }

    private var randomRectangle: some View {
        RoundedRectangle(cornerRadius: metrics.cornerRadius)
            .stroke(style: StrokeStyle(lineWidth: metrics.strokeWidth, dash: metrics.dashPattern))
            .foregroundColor(.theme.randomColor)
            .frame(maxWidth: .infinity)
    }
}

struct InfinityScrollView: View {
    @State private var columnsNumber = 1
    private var listVariants = [1, 2, 3, 4]

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: columnsNumber), spacing: LayoutMetrics(columns: columnsNumber).spacing) {
                    ForEach(Array(Emoji.all.enumerated().shuffled()), id: \.offset) { index, emoji in
                        EmojiCell(emoji: emoji, layout: .randomLayout, metrics: LayoutMetrics(columns: columnsNumber))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            
            Picker("Options", selection: $columnsNumber) {
                ForEach(0..<listVariants.count, id: \.self) { i in
                    Text("\(listVariants[i])").tag(i + 1)
                }
            }.pickerStyle(.segmented)
        }
    }
}
#Preview {
    InfinityScrollView()
}
