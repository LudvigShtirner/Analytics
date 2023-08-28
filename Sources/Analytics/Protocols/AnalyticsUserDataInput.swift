//
//  AnalyticsUserDataInput.swift
//  
//
//  Created by Алексей Филиппов on 19.08.2023.
//

// Apple
import Foundation

/// Протокол для обработки входящих операций над свойствами пользователя для системы аналитики
public protocol AnalyticsUserDataInput {
    /**
     Добавляет/обновляет свойства пользователя используя модель
     
     ## Note ##
     Нужно использовать плоскую модель, с параметрами, которые сериализуются в String
     
     ### Пример модели ###
     ````
     struct BaseProperties: Codable {
     
     var yearOfFirstLaunch: String
     
     enum CodingKeys: String, CodingKey {
     case yearOfFirstLaunch = "year_of_first_launch"
     }
     }
     
     ````
     
     - Parameters:
     - model: Модель с пользовательскими параметрами, реализующая Codable
     */
    func setUserPropertiesWithModel<T: Codable>(_ model: T)
    
    /**
     Добавляет/обновляет свойства пользователя используя dictionary
     
     ## Note ##
     Нужно использовать простой dictionary с параметрами, конвертируемыми в String
     
     - Parameters:
     - dictionary: Dictionary содержащий данные для свойств пользователя
     */
    func setUserPropertiesWithDictionary(_ dictionary: [String: Any])
    
    /**
     Устанавливает значение для User Property определенного по ключу.
     Если свойство уже существует - то будет переписано с новым значением (см. заметку)
     ## Note ##
     Вы можете установить мутабельность свойства при определении его ключа в UserPropertyKey to **.ummutable**
     для  неизменяемых свойст - при новых значениях оно не будет переписано, если это позволяет система аналитики.
     **(For 12.06.2019 Work only in Amplitude)**
     
     - Parameters:
     - value: конвертируемый в String тип
     - key: ключ, описанный как static let в UserProperyKey
     
     ### Пример создания ключей: ###
     ````
     extension AnalyticsUserPropertyKeys {
     static let ummutableProperty = UserPropertyKey<String>("umutable_property", mutability: .unmutable)
     static let mutableProperty = UserPropertyKey<Int>("mutable_property")
     }
     ````
     */
    func set<T>(value: T, key: UserPropertyKey<T>) where T: LosslessStringConvertible
    
    /**
    
     Инкременитирует свойстов пользоватля на переднное значение (может быть отрицательным для дикремента)
     Если свойство еще не установлено то будет инициализровано как 0 перед инкрементом.
     
     ## Note ##
     **(На 12.06.2019 работает только для  Amplitude)**
     
     ### Пример создания ключа: ###
     ````
     extension AnalyticsUserPropertyKeys {
     static let purchaseCounter = UserPropertyKey<Int>("counter")
     }
     ````
     
     - Parameters:
     - value: String конвертируемый тип. Значение на которое свойство должно быть инткрементировано.
     - key: ключ, описанный как static let в UserProperyKey
     
     */
    func add<T>(value: T, key: UserPropertyKey<T>) where T: LosslessStringConvertible
    
    /**
     Очищает и удаляет свойство пользователя. Это свойство больше не будет показываться в профиле.  profile.
     
     ### Пример создания ключа: ###
     ````
     extension AnalyticsUserPropertyKeys {
     static let purchaseCounter = UserPropertyKey<Int>("counter")
     }
     ````
     
     - Parameters:
     - key:Свойство пользователя для очистки. ключ, описанный как static let в UserProperyKey
     
     */
    func unset<T: LosslessStringConvertible>(key: UserPropertyKey<T>)
    
    /**
     Очищает все свойства, которые трекаются на уровне пользователя. (зависит от системы аналитики)
     
     ## Note ##
     На 12.06.2019 работает только для Amplitude (результат операции необратим)
     */
    func clearUserProperties()
}

extension Analytics: AnalyticsUserDataInput {
    public class var userDataInput: AnalyticsUserDataInput {
        return shared
    }
    
    // MARK: User Properties
    public func setUserPropertiesWithModel<T: Codable>(_ model: T) {
        let encoder = DictionaryEncoder()
        do {
            let properties: [String: Any] =  try encoder.encode(model)
            userDataDirectors.forEach { $0.setUserProperties(properties) }
        } catch {
            fatalError("Error! Encoding for model of user propery. \(model)")
        }
    }
    
    public func setUserPropertiesWithDictionary(_ dictionary: [String: Any]) {
        userDataDirectors.forEach { $0.setUserProperties(dictionary) }
    }
    
    public func clearUserProperties() {
        userDataDirectors.forEach { $0.clearUserProperties() }
    }

    public func set<T>(value: T, key: UserPropertyKey<T>) where T: LosslessStringConvertible {
        userDataDirectors.forEach { $0.set(value: value, key: key) }
    }
    
    public func add<T>(value: T, key: UserPropertyKey<T>) where T: LosslessStringConvertible {
        userDataDirectors.forEach { $0.add(value: value, key: key) }
    }
    
    public func unset<T: LosslessStringConvertible>(key: UserPropertyKey<T>) {
        userDataDirectors.forEach { $0.unset(key: key) }
    }
}
