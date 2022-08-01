//
//  ProductViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 27/07/22.
//

import UIKit

class ProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductManagerDelegate {
    
    var id: Int?
    var name: String?
    var email: String?
    var phoneNumber: String?
    
    let categorykCellIdentifier = "CategoryViewCell"
    let productkCellIdentifier = "ProductCollectionViewCell"
    
    let productAPI = ProductAPI()
    let searchAPI = SearchAPI()
    var productsData: [ProductModel]?
    var headPhoneProducts: [ProductModel]?
    var laptopProducts : [ProductModel]?
    var mobileProducts : [ProductModel]?
    var televisionProducts : [ProductModel]?
    var watchProducts : [ProductModel]?
    var dataSource: [ProductModel]?
    
    let categoryData: [CategoryModel] = [CategoryModel(image: "https://d1qwl4ymp6qhug.cloudfront.net/Release/R268/images/landings/ebook/devices/devices.png", name: "All"),
                                         CategoryModel(image: "https://pngimg.com/uploads/headphones/headphones_PNG7630.png", name: "Headphones"),
                                          CategoryModel(image: "https://pngimg.com/uploads/laptop/laptop_PNG101768.png", name: "Laptops"),
                                          CategoryModel(image: "https://pngimg.com/uploads/smartphone/smartphone_PNG8499.png", name: "Mobiles"),
                                          CategoryModel(image: "https://pngimg.com/uploads/tv/tv_PNG39229.png", name: "Television"),
                                          CategoryModel(image: "https://e7.pngegg.com/pngimages/486/490/png-clipart-apple-watch-series-3-smartwatch-apple-watch-accessory-apple-watch.png", name: "Watches")]
          
    
    @IBOutlet var viewLeading: NSLayoutConstraint!
    @IBOutlet var viewTrailing: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var productCollectionView: UICollectionView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    
    @IBOutlet var profileName: UILabel!
    @IBOutlet var profileEmail: UILabel!
    
    
    var menuOut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCustomViewInCell()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productAPI.delegate = self
        productAPI.fecthProductsDetails()
        
        searchAPI.delegate = self
        
        profileName.text = name
        profileEmail.text = email
        
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
    }
    
    func segregateProducts() -> Void {
        headPhoneProducts = productsData?.filter({ (item) -> Bool in
            return item.category?.rawValue == "headphone"
        })
        laptopProducts = productsData?.filter({ (item) -> Bool in
            return item.category?.rawValue == "laptop"
        })
        mobileProducts = productsData?.filter({ (item) -> Bool in
            return item.category?.rawValue == "mobile"
        })
        televisionProducts = productsData?.filter({ (item) -> Bool in
            return item.category?.rawValue == "television"
        })
        watchProducts = productsData?.filter({ (item) -> Bool in
            return item.category?.rawValue == "watch"
        })
    }

    func updatedData(products: [ProductModel]) {
        
        DispatchQueue.main.async {
            self.productsData = products
            self.dataSource = products
            self.segregateProducts()
            self.productCollectionView.reloadData()
        }
    }
    
    func searchedData(products: [ProductModel]) {
        
        DispatchQueue.main.async {
            self.dataSource = products
            self.productCollectionView.reloadData()
        }
    }

    
    func registerCustomViewInCell() {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(nib, forCellWithReuseIdentifier: categorykCellIdentifier)
        
        let newNib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(newNib, forCellWithReuseIdentifier: productkCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoryCollectionView {
            if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
            return categoryData.count
        } else if collectionView == productCollectionView {
            if let layout = productCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
            }
            if let data = self.dataSource {
                return data.count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: categorykCellIdentifier, for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = .clear
            
            if let urlLink = URL(string: categoryData[indexPath.row].image ?? "") {
                cell.categoryImage.load(url: urlLink)
            }
        
            cell.categoryName.text = categoryData[indexPath.row].name
            return cell
            
        } else if collectionView == productCollectionView {
            guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: productkCellIdentifier, for: indexPath) as? ProductCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if let urlLink = URL(string: dataSource?[indexPath.row].image ?? "") {
                cell.productImage.load(url: urlLink)
            }
            
            if let brand = dataSource?[indexPath.row].brand {
                cell.productBrand.text = brand
            }
            
            if let price = dataSource?[indexPath.row].price {
                cell.productPrice.text = "$ \(String(describing: price))"
            }
            
            if let stock = dataSource?[indexPath.row].stock {
                cell.productStock.text = "In Stock: \(String(describing: stock))"
            }

            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            return CGSize(width: 130.0 , height: 100.0)
        } else if collectionView == productCollectionView {
            return CGSize(width: 150.0 , height: 200.0)
        } else {
            return CGSize(width: 0.0, height: 0.0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == categoryCollectionView {
            let categorySelected = categoryData[indexPath.row].name
                switch categorySelected {
                case "Headphones":
                    dataSource = headPhoneProducts
                    self.searchedData(products: dataSource ?? [])
                    productCollectionView.reloadData()
                case "Laptops":
                    dataSource = laptopProducts
                    self.searchedData(products: dataSource ?? [])
                    productCollectionView.reloadData()
                case "Mobiles":
                    dataSource = mobileProducts
                    self.searchedData(products: dataSource ?? [])
                    productCollectionView.reloadData()
                case "Television":
                    dataSource = televisionProducts
                    self.searchedData(products: dataSource ?? [])
                    productCollectionView.reloadData()
                case "Watches":
                    dataSource = watchProducts
                    self.searchedData(products: dataSource ?? [])
                    productCollectionView.reloadData()
                case "All":
                    dataSource = productsData
                    self.searchedData(products: dataSource ?? [])
                    productCollectionView.reloadData()
                default:
                    print("NO DATA")
            }
        } else if collectionView == productCollectionView {
            if let productDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductDetailViewController") as? ProductDetailViewController {

                let data = dataSource?[indexPath.row]
                
                if let userId = id {
                    productDetailViewController.userId = userId
                }
                
                if let prodId = data?.id {
                    productDetailViewController.productId = prodId
                }
                
                if let merchantId = data?.merchantID {
                    productDetailViewController.merchantId = merchantId
                }
                
                if let image = data?.image {
                    productDetailViewController.productImage = image
                }

                productDetailViewController.productCategory = (data?.category).map { $0.rawValue }
                
                if let brand = data?.brand {
                    productDetailViewController.productBrand = brand
                }
                
                if let price = data?.price {
                    productDetailViewController.productPrice = String(describing: price)
                }
                
                if let stock = data?.stock {
                    productDetailViewController.productStock = String(describing: stock)
                }
                
                if let rating = data?.rating {
                    productDetailViewController.productRating = String(describing: rating)
                }
                
                if let camera = data?.camera {
                    productDetailViewController.productRating = String(describing: camera)
                }
                
                if let ram = data?.ram {
                    productDetailViewController.productRam = String(describing: ram)
                }
                
                if let processor = data?.processor {
                    productDetailViewController.productProcessor = String(describing: processor)
                }
                
                if let dialShape = data?.dialShape {
                    productDetailViewController.productDailShape = dialShape
                }
                
                if let headphoneType = data?.headphoneType {
                    productDetailViewController.productHeadphoneType = headphoneType
                }
                
                if let color = data?.color {
                    productDetailViewController.productColor = color
                }
                
                //productDetailViewController.productScreenType = (data?.screenType).map { $0.rawValue }
                productDetailViewController.productScreenType = data?.screenType
                
                if let screenSize = data?.screenSize {
                    productDetailViewController.productScreenSize = String(describing: screenSize)
                }

                navigationController?.pushViewController(productDetailViewController, animated: true)
            } else {
                print("Error getitng detail view controller")
            }
        }
    }
    
    
    @IBAction func burgerMenu(_ sender: Any) {
         
        if !menuOut {
            viewLeading.constant = 200.0
            viewTrailing.constant = -200.0
            menuOut = true
            //mainView.dropShadow()
        } else {
            viewLeading.constant = 0.0
            viewTrailing.constant = 0.0
            menuOut = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        if let searchedItem = searchBar.text {
            searchAPI.fecthBrandDetails(searchField: searchedItem)
        }
    }
    
    @IBAction func profileButton(_ sender: Any) {
        if let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController {

            profileViewController.email = email
            profileViewController.name = name
            profileViewController.phoneNumber = phoneNumber
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    @IBAction func cartButton(_ sender: Any) {
        if let cartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CartViewController") as? CartViewController {
            
            if let id = id {
                cartViewController.userId = id
            }
            self.navigationController?.pushViewController(cartViewController, animated: true)
        }
    }
}

