//
//  EntriesTableViewController.swift
//  Daily Journal
//
//  Created by qualson on 2022/04/12.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    var entries : [Entry] = []

    override func viewDidLoad() {
        
        
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            //fetchRequest Entry!
            if let entriesFromCoreData = try? context.fetch(Entry.fetchRequest()) as? [Entry] {
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
        
        let cell = UITableViewCell()
        let entry = entries[indexPath.row]
        cell.textLabel?.text = entry.text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
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

