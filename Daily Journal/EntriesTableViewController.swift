//
//  EntriesTableViewController.swift
//  Daily Journal
//
//  Created by qualson on 2022/04/12.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entries : [Entry] = []
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let request: NSFetchRequest<Entry> = Entry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            //fetchRequest Entry!
            if let entriesFromCoreData = try? context.fetch(request) {
                entries = entriesFromCoreData
                tableView.reloadData()
                
            }
            
        }
    }
    
    
    
    // 섹션의 수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }
    
    // 셀의 수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell") as? EntryTableViewCell {
            
            let entry = entries[indexPath.row]
            cell.entryTextLabel?.text = entry.text
            cell.monthLabel.text = entry.month()
            cell.dayLabel.text = entry.day()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let entryVC = segue.destination as? EntryViewController else { return }
        //performSegue를 하게되면, prepare 에서 segue의 destination 을 EntryViewController 로 unwrap하여 sender 로 전달받은 entry 를 해당 VC의 entry로 지정
        guard let entryToBeSent = sender as? Entry else { return }
        entryVC.entry = entryToBeSent
        
        
        
        // EntiresTableViewController.swift 에서 prepare 함수에서 segue가 이뤄질 때에 도착지 VC인 EntryViewController 의 entriesVC 를 스스로로 설정할 수 있도록 self 로 할당
        //entryVC.entriesVC = self
        
    }
    
    
}

