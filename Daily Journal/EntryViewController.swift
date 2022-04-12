//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by qualson on 2022/04/12.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var entryTextView: UITextView!
    
    var entriesVC : EntriesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 각 Entry(EntryViewController.swift) 에서 글을 쓰고 back 버튼을 누르면, 어떻게 데이터를 저장하게할것? => viewDidAppear로 view가 사라질 때 실행되는 함수, view가 사라질 때(viewWillDisappear 함수) Entry 객체를 만들고, date 와 text 를 UI에서 지정된 값으로 설정해주는 방식
    override func viewWillDisappear(_ animated: Bool) {
        //엔트리를 만든다.
        //class는 reference방식이므로, let으로 선언해도 값을 변경하는것은 문제 없다
        let entry = Entry()
        
        // 뷰가 사라질 때 date 와 text 를 UI에서 지정된 값으로 설정
        entry.date = datePicker.date
        entry.text = entryTextView.text
        
        //Listing Entry
        entriesVC?.entries.append(entry)
        entriesVC?.tableView.reloadData()
        
    }
}
