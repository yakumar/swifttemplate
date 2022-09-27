//
//  ContentView.swift
//  LoanCD
//
//  Created by ani on 25/08/22.
//

import SwiftUI

struct FruitModel: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var count: Int
    
    
}

class FruitViewModel: ObservableObject {
   @Published var fruitArray: [FruitModel] = [
      
    
    ]
    
    init() {
        getFruits()
    }
    func getFruits(){

        let fruit1 = FruitModel(name: "Guava", count: 23)
        let fruit2 = FruitModel(name: "Plum", count: 34)

        fruitArray.append(fruit1)
        fruitArray.append(fruit2)

    }

    func deleteFruit(index: IndexSet){
        
        fruitArray.remove(atOffsets: index)
        
    }
    func addFruit(name: String, count: Int){
        print("name, \(name)")
        print("count, \(count)")
        
        let newFruit = FruitModel(name: name, count: count)
        
        print("new Fruit, \(newFruit)")
        
       
        
        fruitArray.append(newFruit)
        
        print("fruit array from addFruit, \(fruitArray)")
        
    }
    
    
}

struct OtherView: View {
    @State var fruitName: String = ""
    @State var fruitNumber: String = ""
    
    @ObservedObject var fruitViewModel: FruitViewModel
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        
       
        VStack {
            
            TextField("name", text: $fruitName)
                .padding()
                .textFieldStyle(.roundedBorder)
           TextField("number", text: $fruitNumber)
                .padding()
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            Button("Add fruit") {
                print("print numbeer , \(fruitNumber)" )
                fruitViewModel.addFruit(name: fruitName, count: Int(fruitNumber) ?? 0)
                presentationMode.wrappedValue.dismiss()
            }
            
            
            
            
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}


struct ContentView: View {
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationView{
            
            
            
            
            
            List {
                ForEach (fruitViewModel.fruitArray){ fruit in
                    HStack {
                        Text("\(fruit.name)")
                            .foregroundColor(.red)
                        Text("\(fruit.count)")
                            .font(.headline)
                            .bold()
                            
                        
                    }
                }.onDelete(perform: fruitViewModel.deleteFruit)
            }
            .toolbar {
                NavigationLink("Add", destination: OtherView(fruitViewModel: fruitViewModel))
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Fruit List")
//            .onAppear {
//                fruitViewModel.getFruits()
//                print("\(fruitViewModel.fruitArray)")
//            }
            
        
        }
       
        
    }
    
    
    
}
                

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
