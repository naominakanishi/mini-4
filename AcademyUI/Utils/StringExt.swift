//
//  StringExt.swift
//  AcademyUI
//
//  Created by HANNA P C FERREIRA on 18/05/22.
//

import Foundation

extension StringProtocol {
    
    func masked(_ mask: String?) -> String {
        
        guard let mask = mask else {
            return String(self)
        }
        
        var available = self.cleaned()
        var finalText = ""
        for position in 0..<mask.count {
            
            if !available.isEmpty {
                if mask.char(at: position) == "#" {
                    finalText.append(available.removeFirst())
                } else {
                    finalText.append(mask.char(at: position))
                }
            } else {
                return finalText
            }
            
        }
        return finalText
        
    }
    
    func char(at: Int) -> Character {
        let characterStartIndex = self.index(self.startIndex, offsetBy: at)
        return self[characterStartIndex]
    }
    
    func cleaned() -> String {
        return self.components(
            separatedBy: CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
        ).joined(separator: "")
    }
    
    func cleanedNumberString() -> String {
        return self.compactMap(\.wholeNumberValue).map { String($0) }.joined()
    }
    
    func maskedCard() -> String {
        return self.suffix(4).masked("**** **** **** ####")
    }
    
    func maskedPhone(_ showDDI: Bool = false) -> String {
        let phone: String = self.cleaned()
        if phone.count == 13 || phone.count == 12 {
            if showDDI {
                return phone.masked(phone.count == 13 ? "+## (##) #####-####" : "+## (##) ####-####")
            } else {
                let index = phone.index(startIndex, offsetBy: 2)
                return String(phone[index...]).masked(phone.count == 13 ? "(##) #####-####" : "(##) ####-####")
            }
        } else if phone.count == 11 || phone.count == 10 {
            return phone.masked(phone.count == 11 ? "(##) #####-####" : "(##) ####-####")
        } else if phone.count == 9 || phone.count == 8 {
            return phone.masked(phone.count == 9 ? "#####-####" : "####-####")
        }
        return String(phone)
    }
    
    func toDecimalValue() -> Decimal {
        let clean = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if let value = Decimal(string: clean) {
            return value
        }
        return 0
        
    }
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isCNPJ: Bool {
        let numbers = compactMap(\.wholeNumberValue)
        guard numbers.count == 14 && Set(numbers).count != 1 else { return false }
        return numbers.prefix(12).digitoCNPJ == numbers[12] &&
            numbers.prefix(13).digitoCNPJ == numbers[13]
    }
    
}

extension String {
    func removingLastWord() -> String {
        if let spaceIndex = self.lastIndex(of: " ") {
            let length = self.distance(from: spaceIndex, to: self.endIndex)
            var copy = self
            copy.removeLast(length)
            return copy
        }
        return self
        
    }
}

extension String {
    
    func isValidCEP() -> Bool {
        return self.count == 8
    }
    
    func isValidAddressNumber() -> Bool {
        return !self.isEmpty && self.count <= 5
    }
    
    func isValidAddressComplement() -> Bool {
        return self.count <= 10
    }
    
    func isValidEmail() -> Bool {
        return String.validEmail(self)
    }
    
    static func validEmail(_ email: String!) -> Bool {
        if email.count == 0 {
            return false
        }
        
        let regExPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regEx: NSRegularExpression = try! NSRegularExpression(pattern: regExPattern, options: NSRegularExpression.Options.caseInsensitive)
        let regExMatches: Int = regEx.numberOfMatches(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.count) )
        
        if regExMatches == 0 {
            return false
        } else {
            return true
        }
    }
    
    
    func isNumeric() -> Bool {
        let sc = Scanner(string: self)
        return sc.scanInt32(nil) && sc.isAtEnd
        // let phoneRegEx = "^((\\+)|(00)|(\\*)|())[0-9]{3,14}((\\#)|())$"
    }
    
    
    func isValidPhone() -> Bool {
        return String.validPhone(self)
    }
    
    static func validPhone(_ phone: String!) -> Bool {
        return phone.count >= 11
    }
    
    func getDDD() -> String {
        let phone = self.removeDDI()
        let startIndex = phone.startIndex
        let endIndex = phone.index(startIndex, offsetBy: 2)
        return String(phone[startIndex..<endIndex])
    }
    
    func removeDDI() -> String {
        if self.count == 13 || self.count == 12 {
            let index = self.index(startIndex, offsetBy: 2)
            return String(self[index...])
        }
        return self
    }
    
    func removeDDD() -> String {
        if self.count == 11 || self.count == 10 {
            let index = self.index(startIndex, offsetBy: 2)
            return String(self[index...])
        }
        return self
    }
    
    func addDDI() -> String {
        let cleaned = self.cleaned()
        if cleaned.count == 11 || cleaned.count == 10 {
            return "55" + cleaned
        }
        return self
    }
    
    func separeDDDFromPhone() -> (String, String) {
        var ddd = ""
        var phone = self.cleaned().removeDDI()
        if phone.count == 11 || phone.count == 10 {
            ddd = String(phone.prefix(2))
            
            let index = phone.index(phone.endIndex, offsetBy: -(phone.count - 2))
            phone = String(phone[index...])
        }
        
        return (ddd, phone)
    }
    
    var isCPF: Bool {
        let numbers = self.compactMap({ Int(String($0)) })
        guard numbers.count == 11 && Set(numbers).count != 1 else { return false }
        let sum1 = 11 - ( numbers[0] * 10 +
            numbers[1] * 9 +
            numbers[2] * 8 +
            numbers[3] * 7 +
            numbers[4] * 6 +
            numbers[5] * 5 +
            numbers[6] * 4 +
            numbers[7] * 3 +
            numbers[8] * 2 ) % 11
        let dv1 = sum1 > 9 ? 0 : sum1
        let sum2 = 11 - ( numbers[0] * 11 +
            numbers[1] * 10 +
            numbers[2] * 9 +
            numbers[3] * 8 +
            numbers[4] * 7 +
            numbers[5] * 6 +
            numbers[6] * 5 +
            numbers[7] * 4 +
            numbers[8] * 3 +
            numbers[9] * 2 ) % 11
        let dv2 = sum2 > 9 ? 0 : sum2
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    func formatDocument() -> String {
        var cleaned = self.cleaned()
        if cleaned.count == 11 {
            cleaned.insert(".", at: cleaned.index(cleaned.startIndex, offsetBy: 3))
            cleaned.insert(".", at: cleaned.index(cleaned.startIndex, offsetBy: 7))
            cleaned.insert("-", at: cleaned.index(cleaned.startIndex, offsetBy: 11))
        } else if cleaned.count == 14 {
            cleaned.insert(".", at: cleaned.index(cleaned.startIndex, offsetBy: 2))
            cleaned.insert(".", at: cleaned.index(cleaned.startIndex, offsetBy: 6))
            cleaned.insert("/", at: cleaned.index(cleaned.startIndex, offsetBy: 10))
            cleaned.insert("-", at: cleaned.index(cleaned.startIndex, offsetBy: 15))
        }
        return cleaned
    }
    
    func convertBarCodeToLine() -> String {
        let barcode = self.cleaned()
        var line = ""
        if barcode.isNumeric() && barcode.count == 44 {
            if barcode.prefix(1) == "8" {
                let barcodeIndex11 = barcode.index(barcode.startIndex, offsetBy: 11)
                let barcodeIndex22 = barcode.index(barcode.startIndex, offsetBy: 22)
                let barcodeIndex33 = barcode.index(barcode.startIndex, offsetBy: 33)
                                
                line += barcode.prefix(11)
                line += String(generateIdenfiferForBlock(block: line))
                line += String(barcode[barcodeIndex11..<barcodeIndex22])
                line += String(generateIdenfiferForBlock(block: String(line[line.index(line.startIndex, offsetBy: 12)...])))
                line += String(barcode[barcodeIndex22..<barcodeIndex33])
                line += String(generateIdenfiferForBlock(block: String(line[line.index(line.startIndex, offsetBy: 24)...])))
                line += String(barcode[barcodeIndex33...])
                line += String(generateIdenfiferForBlock(block: String(line[line.index(line.startIndex, offsetBy: 36)...])))
            } else {
                let barcodeIndex3 = barcode.index(barcode.startIndex, offsetBy: 3)
                let barcodeIndex4 = barcode.index(barcode.startIndex, offsetBy: 4)
                let barcodeIndex5 = barcode.index(barcode.startIndex, offsetBy: 5)
                let barcodeIndex9 = barcode.index(barcode.startIndex, offsetBy: 9)
                let barcodeIndex19 = barcode.index(barcode.startIndex, offsetBy: 19)
                let barcodeIndex24 = barcode.index(barcode.startIndex, offsetBy: 24)
                let barcodeIndex34 = barcode.index(barcode.startIndex, offsetBy: 34)
                                
                line += barcode.prefix(3)
                line += String(barcode[barcodeIndex3..<barcodeIndex4])
                line += String(barcode[barcodeIndex19..<barcodeIndex24])
                line += String(generateIdenfiferForBlock(block: line))
                line += String(barcode[barcodeIndex24..<barcodeIndex34])
                line += String(generateIdenfiferForBlock(block: String(line[line.index(line.startIndex, offsetBy: 10)..<line.index(line.startIndex, offsetBy: 20)])))
                line += String(barcode[barcodeIndex34...])
                line += String(generateIdenfiferForBlock(block: String(line[line.index(line.startIndex, offsetBy: 21)..<line.index(line.startIndex, offsetBy: 31)])))
                line += String(barcode[barcodeIndex4..<barcodeIndex5])
                line += String(barcode[barcodeIndex5..<barcodeIndex9])
                line += String(barcode[barcodeIndex9..<barcodeIndex19])
            }
        }
        return line
    }
    
    private func generateIdenfiferForBlock(block: String) -> Int {
        var sum: Int = 0
        var mult: Int = 2
        for index in stride(from: block.count - 1, through: 0, by: -1) {
            if mult == 0 {
                mult = 2
            }
            
            var multResult: Int = Int(String(block.char(at: index)))! * mult
            
            if multResult > 9 {
                multResult -= 9
            }
            
            sum += multResult
            mult -= 1
        }
        
        let sumRemnant = sum % 10
        
        if sumRemnant == 0 {
            return 0
        } else {
            return 10 - sumRemnant
        }
    }
    
    func toDateFormat(dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}

extension Collection where Element == Int {
    var digitoCNPJ: Int {
        var number = 1
        let digit = 11 - reversed().reduce(into: 0) {
            number += 1
            $0 += $1 * number
            if number == 9 { number = 1 }
        } % 11
        return digit > 9 ? 0 : digit
    }
}
