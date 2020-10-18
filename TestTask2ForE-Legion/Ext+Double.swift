//
//  Ext+Double.swift
//  TestTask2ForE-Legion
//
//  Created by Дмитрий Юдинцев on 18.10.2020.
//

import Foundation

//Расширил тип чтобы можно было удобно округлять широту и долготу до нужного количества знаков
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
