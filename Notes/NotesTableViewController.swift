//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Lily  on 23.05.2019.
//  Copyright © 2019 Lily . All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, EditNoteDelegate {

    @IBAction func addNoteButtonTapped(_ sender: UIBarButtonItem) {
        
        let note = ["title": "", "body": ""]
        notes.insert(note, at: 0)
        self.tableView.reloadData()
        self.selectedIndex = 0
        performSegue(withIdentifier: "ShowEditScreenSegue", sender: nil)
    }
    //an array of dictionaries with string key and string value
    //keys: "title", "body"
    var notes = [[String:String]]()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readNotes()
    }
    
    func saveNotes() {
        
        UserDefaults.standard.set(self.notes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }

    func readNotes() {
        
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String:String]] {
            
            self.notes = newNotes
        }
    }
    // MARK : - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        cell.textLabel?.text = self.notes[indexPath.row]["title"]
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    self.selectedIndex = indexPath.row
    performSegue(withIdentifier: "ShowEditScreenSegue", sender: nil)
    }
    
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
        
        self.notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.saveNotes()
    }
    }
    
    
    func updateNote(updatedTitle: String, updatedBody: String) {
        
        self.notes[selectedIndex]["title"] = updatedTitle
        self.notes[selectedIndex]["body"] = updatedBody
        self.tableView.reloadData()
        self.saveNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let destinationVc = segue.destination as? EditNoteViewController
        destinationVc?.title = self.notes[selectedIndex]["title"]
        destinationVc?.noteBody = self.notes[selectedIndex]["body"]
        destinationVc?.editNoteDelegate = self
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
