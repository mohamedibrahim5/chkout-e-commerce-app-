//
//  FavouriteTableViewCell.swift
//  Merita
//
//  Created by mohamed ibrahim on 10/07/2022.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
     func fetchSingleData (data:Favourite){
        self.name.text = data.valueArrayName
        self.price.text = "\(data.valueArrayPrice)$"
        self.imageview.sd_setImage(with: URL(string: data.valueArrayImage))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension FavouriteScreenViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        let index = indexPath.row
        cell.fetchSingleData(data: arrayOfData[index])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "ProductInfo", bundle: nil).instantiateViewController(withIdentifier: "cell") as? productInfoViewController
        getIndexPath(index: indexPath.row) { numberOfIndexPath in
            self.numberOfIndexPath = numberOfIndexPath
        }
        vc?.userId = userId
        vc?.arrayOfProducts = arrayOfProduct[numberOfIndexPath!]
        self.checkFav = Double(arrayOfData[indexPath.row].valueArrayPrice)!
        UserDefaults.standard.set(self.checkFav, forKey: "\(self.arrayOfProduct[numberOfIndexPath!].id!)")
        self.navigationController!.pushViewController(vc!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAtion = UIContextualAction(style: .destructive, title: "Delete") { [self] action, view, complationHandler in
            getIndexPath(index: indexPath.row) { numberOfIndexPath in
                self.numberOfIndexPath = numberOfIndexPath
            }
            deleteFromFirebase(userId:self.userId!,productId:self.arrayOfProduct[self.numberOfIndexPath!].id!, collection: "FAV")
            self.arrayOfData.remove(at: indexPath.row)
            self.tableview.beginUpdates()
            self.tableview.deleteRows(at: [indexPath], with: .automatic)
            self.tableview.endUpdates()
            if self.arrayOfData.count == 0 {
                self.tableview.isHidden = true
                self.tableview.reloadData()
            }
            complationHandler(true)
        }
       
        return UISwipeActionsConfiguration(actions: [deleteAtion])
    }
    func getIndexPath (index:Int,completion:@escaping(Int)->()) {
        let checkName = arrayOfData[index].valueArrayName
        for i in 0..<self.arrayOfProduct.count{
            if checkName == self.arrayOfProduct[i].title {
                self.numberOfIndexPath = i
                completion(numberOfIndexPath!)
            }
        }

    }
}
