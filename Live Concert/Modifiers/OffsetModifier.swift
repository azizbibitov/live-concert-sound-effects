//
//  OffsetModifier.swift
//  StickyHeaderZamena
//
//  Created by Aziz Bibitov on 24.04.2022.
//

import SwiftUI

//getting Scrollview offsett...
struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .overlay(
                 
                GeometryReader{proxy -> Color in
                    
                    let minY = proxy.frame(in: .global).minY
                    offset = minY
                    //print(minY)
                    
                    return Color.clear
                }
                
                ,alignment: .top
            )
    }
}


