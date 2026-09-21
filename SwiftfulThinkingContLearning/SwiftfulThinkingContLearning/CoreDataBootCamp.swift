//
//  CoreDataBootCamp.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 17/07/26.
//

import SwiftUI
import CoreData
import Combine


class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities:[FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores{
            (description,error) in
            if let error = error {
                print("Error loading data: \(error.localizedDescription)")
            }else {
                print("Successfully loaded data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        }
        catch {
            print("Error fetching data")
        }
    }
    func addFruit(text:String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    func deleteFruit(indexset:IndexSet) {
        guard let index = indexset.first else {
            return
        }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity:FruitEntity) {
        let currentName = entity.name ?? ""
        let newName:String = currentName.uppercased() + "!"
        entity.name = newName
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        }
        catch {
            print("Error saving data")
        }
    }
    
}

struct CoreDataBootCamp: View {
    
    @StateObject var coreDataVM: CoreDataViewModel = CoreDataViewModel()
    @State var textFieldText: String = ""
    var body: some View {
        NavigationView{
            VStack {
                TextField("Add fruit here....", text: $textFieldText)
                    .font(.headline)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 55)
                    .padding(.horizontal)
                
                Button(action: {
                    guard textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 else { return }
                    coreDataVM.addFruit(text: textFieldText)
                    textFieldText = ""
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .fontWeight(.bold)

                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(20)
                        .padding(.horizontal)

                })
                List {
                    ForEach(coreDataVM.savedEntities) {
                        entity in
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                coreDataVM.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: coreDataVM.deleteFruit)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataBootCamp()
}


