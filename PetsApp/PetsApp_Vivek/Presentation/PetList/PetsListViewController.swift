//
//  PetsListViewController.swift
//  PetsApp_Vivek
//


import UIKit

class PetsListViewController: UIViewController {
    
    @IBOutlet weak var containerForShopClosed: UIView!
    @IBOutlet weak var errorMessageImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var refreshControl: UIRefreshControl!
    var viewModel: PetsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PetsListViewModel()
        initUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    //MARK: Refresh Control
    @objc func refresh(sender: UIRefreshControl) {
        fetchData()
    }
    
    func initUIElements() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: viewModel.getRefreshControlText())
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.table.separatorStyle = .none
        table.addSubview(refreshControl)
    }
    
    func navigateToPetDetail(forPetAt index: Int){
        guard let selectedPet = viewModel.getPetAt(index: index) else {return}
        
        let petDetailVc = instantiateVC(storyboardName: Constants.Storyboard.main,
                                        storyboardId: Constants.StoryboardIdentifiers.petDetailId) as! PetDetailViewController
        petDetailVc.viewModel = PetDetailViewModel(pet: selectedPet)
        self.navigationController?.pushViewController(petDetailVc, animated: true)
    }
    
    func showAlert() {
        let shopNotOpenAlert = UIAlertController(title: viewModel.getAlertTitle(),
                                                 message: "", preferredStyle: .alert)
        shopNotOpenAlert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(shopNotOpenAlert, animated: true, completion: nil)
    }
    
}
//MARK: Tableview Datasource & Delegate
extension PetsListViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.getPetsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.petListId) as? PetsListTableCell else {
            return UITableViewCell()
        }
        cell.configureCellWith(model: viewModel.getPetAt(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.CellHeight.petList
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPetDetail(forPetAt: indexPath.row)
    }
    
}
//MARK: ViewModel Accessors
extension PetsListViewController {
    
    func fetchData() {        
        viewModel.getData(filePath: DataManager.shared.getfilePath(for: Operation.WORKING_TIME)!) { error in
            DispatchQueue.main.async {
                self.handleResponse(with: error)
            }
        }
    }
    
    func handleResponse(with errorContent: ErrorContent?) {
        if let content = errorContent {
            showErrorMessage(with: content)
        }else {
            refresh()
        }
    }
    
    func refresh() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        table.isHidden = false
        table.reloadData()
    }
    
    func showErrorMessage(with error: ErrorContent) {
        errorMessageImage.image = UIImage(named: error.imageName)
        errorMessage.attributedText = error.message
        containerForShopClosed.isHidden = false
        table.isHidden = true
    }
}
