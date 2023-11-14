//
//  Timer.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 24.04.2022.
//

import Foundation


class MyTimer: ObservableObject{
    @Published var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

}
