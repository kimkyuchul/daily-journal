//
//  EntryViewController.swift
//  Daily Journal
//
//  Created by qualson on 2022/04/12.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var entryTextView: UITextView!
    @IBOutlet var bottomConstraints: NSLayoutConstraint!
    var entry: Entry?
    
    //var entriesVC : EntriesTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if entry == nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                entry = Entry(context: context)
                entry?.date = datePicker.date
                entry?.text = "Today was .."
                entryTextView.becomeFirstResponder()
            }
        }
        
        entryTextView.text = entry?.text
        if let dateToBeShown = entry?.date {
            datePicker.date = dateToBeShown
        }
        
        entryTextView.delegate = self
}
    
    // 각 Entry(EntryViewController.swift) 에서 글을 쓰고 back 버튼을 누르면, 어떻게 데이터를 저장하게할것? => viewWillDidAppear로 view가 사라질 때 실행되는 함수, view가 사라질 때(viewWillDisappear 함수) Entry 객체를 만들고, date 와 text 를 UI에서 지정된 값으로 설정해주는 방식
    override func viewWillDisappear(_ animated: Bool) {
        //엔트리를 만든다.
        //class는 reference방식이므로, let으로 선언해도 값을 변경하는것은 문제 없다
        // let entry = Entry()
        
        //entry?.date = datePicker.date
        //entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        
        /*
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let conText = appdelegate.persistentContainer.viewContext
    
        let entry = Entry(context: conText)
        entry.date = datePicker.date
        entry.text = entryTextView.text
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
         */
        
        
        //Listing Entry
        //entriesVC?.entries.append(entry)
       // entriesVC?.tableView.reloadData()
    }
    
    @objc func keyboardWillShow ( Notification: NSNotification) {
        
        if let keyboardFrame: NSValue = Notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                    
                bottomConstraints.constant = keyboardHeight
        
    }
}
    @IBAction func deleteTapped(_ sender: Any) {
        
        if entry != nil {
            if let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                //context에서 entry를 제거해주고 save 해준다. save 는 context.save와 달리 직접하는거라 에러를 내뱉을 수 있어 앞에 try? 를 달아준다.
                context.delete(entry!)
                try? context.save()
            }
        }
        
        navigationController?.popViewController(animated: true)
    }

    func textViewDidChange(_ textView: UITextView) {
        entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

