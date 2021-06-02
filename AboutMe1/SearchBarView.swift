//
//  SearchBarView.swift
//  AboutMe1
//
//  Created by Nazish Asghar on 02/06/21.
//
import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var placeholder: String
    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            searchBar.showsCancelButton = true
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
                    text = ""
                    searchBar.showsCancelButton = false
                    searchBar.endEditing(true)
                }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeholder
        searchBar.keyboardType = .emailAddress
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
