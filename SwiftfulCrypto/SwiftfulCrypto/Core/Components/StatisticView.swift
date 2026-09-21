//
//  StatisticView.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 07/09/26.
//


import SwiftUI
import Combine


struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.green : Color.red)
            // instead of if let used opacity as this row will be drawn but will not be visible, for consistency in height
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
            
        }
        
    }
}

struct StatisticView_Previews: PreviewProvider {

    static var previews: some View {
        StatisticView(stat: DeveloperPreview.instance.stat3)
            
    }
}
