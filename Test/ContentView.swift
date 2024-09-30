//
//  ContentView.swift
//  Test
//
//  Created by junpei arai on 2024/07/10.
//

import SwiftUI

struct ContentView: View {
    
    struct Item:  Codable, Identifiable {
        var uuid = UUID().uuidString
        var name: String
        var id: String
        var pass:String
        var memo: String
    }
    // リストアイテムの配列
    //    @State var items: [Item]?
    
    let sampleItems: [Item] = [
        Item(name: "Item 1", id: "1", pass: "password1", memo: "このアイテムはサンプルです"),
        Item(name: "Item 2", id: "2", pass: "password2", memo: "別のサンプルアイテム"),
        Item(name: "Item 2", id: "2", pass: "password2", memo: "別のサンプルアイテム"),
        Item(name: "Item 2", id: "2", pass: "password2", memo: "別のサンプルアイテム"),
        Item(name: "Item 2", id: "2", pass: "password2", memo: "別のサンプルアイテム"),
        Item(name: "Item 3", id: "3", pass: "password3", memo: "これは3番目のサンプルアイテムです")
    ]
    @State private var showEditDialog = false // ダイアログの表示状態を管理する変数
    @State private var showDeleteDialog = false
    var body: some View {
        ZStack{
            NavigationView{
                ScrollView{
                    Spacer()
                    ForEach(sampleItems){ item in
                        VStack{
                            cardView(title:"アイテム名")
                            cardView(title:"ユーザーID")
                            cardView(title:"パスワード")
                            cardView(title:"メモ           ")
                            cardButton()
                        }
                        .padding() // HStack全体の内側にパディングを追加
                        
                        .background(Color.white) // 背景色を追加（枠線が見えるように）
                        .cornerRadius(10) // 角丸
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // 角丸の枠線
                                .stroke(Color.gray, lineWidth: 2) // 枠線の色と幅
                        )
                        .padding(.top,16)
                        .padding(.horizontal, 16) // 横方向の余白を追加
                        .navigationTitle("アプリタイトル") // ナビゲーションバーにタイトルを表示
                        .navigationBarTitleDisplayMode(.inline) // タイトルをインライン表示
                        
                    }
                }
            }
            if showEditDialog {
                CustomDialog(showEditDialog: $showEditDialog) // カスタムダイアログを表示
            }
        }
    }
    
    func cardView(title: String) -> some View {
        
        VStack{
            VStack{
                HStack{
                    Button(action: {
                        // クリップボードにテキストをコピー
                        //                        UIPasteboard.general.string = copiedMessage
                        print("coppy tap ")
                    }) {
                        Image(systemName: "doc.on.doc") // コピーアイコン
                            .resizable()
                            .frame(width: 24, height: 24) // アイコンのサイズ
                    }
                    .buttonStyle(PlainButtonStyle()) // ボタンのスタイルをシンプルに
                    
                    Text("\(title) :")
                    Spacer()
                    Text("aaaaaaasaasasasas")
                    Spacer()
                }
                
            }
        }
        
    }
    
    func cardButton() -> some View {
        
        HStack{
            Button(action: {
                // ボタン1のアクション
                showEditDialog = !showEditDialog
            }) {
                Text("編集")
                    .frame(height: 10) // 縦サイズを指定
                    .frame(maxWidth: .infinity) // ボタンの幅を最大に設定
                    .padding() // 横方向のパディングを追加
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            
            Spacer() // ボタン間のスペースを追加
            
            Button(action: {
                // ボタン2のアクション
                showDeleteDialog = !showDeleteDialog
            }) {
                Text("削除")
                    .frame(height: 10) // 縦サイズを指定
                    .frame(maxWidth: .infinity) // ボタンの幅を最大に設定
                    .padding() // 横方向のパディングを追加
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .alert(isPresented: $showDeleteDialog) {
                Alert(
                    title: Text("Alert Title"),
                    message: Text("This is the alert message."),
                    primaryButton: .default(Text("OK")) {
                        // OKボタンがタップされたときのアクション
                        print("OK tapped")
                        //todo 端末内DBからの読み込み時にエラーになる為調査
                        if let savedData = UserDefaults.standard.data(forKey: "customItemList"),
                           let decodedItemList = try? JSONDecoder().decode([ContentView.Item].self, from: savedData) {
                            print("\(decodedItemList) :test!!!")  // デコードされたリストを使用
                        } else {
                            print("Failed to decode item list.")
                        }
                    },
                    secondaryButton: .cancel() // キャンセルボタン
                )
            }
        }
    }
    
}

