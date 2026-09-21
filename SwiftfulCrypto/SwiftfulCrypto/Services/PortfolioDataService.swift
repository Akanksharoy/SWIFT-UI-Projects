//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Akanksha on 12/09/26.
//
import Foundation
import CoreData
import Combine

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName:String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading Core Data stack: \(error)")
            }
            self.getPortfolio()
        }
    }
    
    //MARK: PUBLIC
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        if let index = savedEntities.firstIndex(where: {$0.coinID == coin.id}) {
            update(entity: savedEntities[index], amount: amount)
        } else {
            add(coin: coin, amout: amount)
        }
    }
    
    
    // MARK: PRIVATE
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        }
        catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func add(coin:CoinModel, amout: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amout
        applyChanges()
    }
    
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        }
        catch let error {
            print("Error saving Portfolio Entity. \(error)")
        }
    }
    
    func applyChanges(){
        save()
        getPortfolio()
    }
}
