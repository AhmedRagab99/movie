import UIKit
import Kingfisher
import Alamofire
import MBProgressHUD


let coder = JSONDecoder()
let baseUrl="https://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"


class HomeVC: UIViewController {
    
    
    
    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var popularityCollectionView: UICollectionView!
    var moviesData = [Movie]()
    var moviesData2 = [Movie]()
    var movieSelected:Movie?
    var movieSelected2:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topRatedCollectionView.delegate=self
        topRatedCollectionView.dataSource=self
        popularityCollectionView.dataSource=self
        popularityCollectionView.delegate=self
        getMovies()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetail = segue.destination as? MovieDetailVC
        {
            movieDetail.selectedMovie = movieSelected
        }
    }
    
    func getMovies(){
        //        coder.dataDecodingStrategy = .base64
        showIndicator(withTitle: "loading", and: "")
        Alamofire.request(baseUrl).responseJSON{ response in
            switch response.result{
            case .success( _):
                guard let resultss = try? coder.decode(Results.self, from: response.data!) else { fatalError("unable to parse data to json")}
                
                for i in resultss.results.enumerated(){
                    // print(resultss.results[i.offset].posterPath)
                    self.moviesData.append(resultss.results[i.offset])
                    self.moviesData2.append(resultss.results[i.offset])
                }
                self.hideIndicator()
                self.topRatedCollectionView.reloadData()
                self.popularityCollectionView.reloadData()
            case .failure(let error):
                self.hideIndicator()
                print(error.localizedDescription)
            }
        }
    }
    
    func showIndicator(withTitle title: String, and Description:String) {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.show(animated: true)
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
}
extension HomeVC:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topRatedCollectionView{
            return moviesData.count
        }
        else  if collectionView == popularityCollectionView{
            return moviesData2.count
        }
        else{ return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topRatedCollectionView{
            
            if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ActionCell
            {
                cell.configureCell(movie: moviesData2[indexPath.item])
                return cell
                
            }
            
        }
            
        else if collectionView==popularityCollectionView{
            //            let popCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
            //            popCell.backgroundColor = .cyan
            //            return popCell
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? DramaCell{
                cell.configureCell(movie: moviesData[indexPath.item])
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topRatedCollectionView{
            movieSelected = moviesData[indexPath.item]
            performSegue(withIdentifier: "detail", sender: nil)
        }
        else {
            movieSelected = moviesData2[indexPath.item]
            performSegue(withIdentifier: "detail", sender: nil)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 3
        let hardCodedPadding:CGFloat = 5
        
        if collectionView == topRatedCollectionView{
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - 2
            let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
            return CGSize(width: itemWidth, height: itemHeight)}
            
            
        else {
            let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
            let itemHeight = collectionView.bounds.height - (3 * hardCodedPadding)
            return CGSize(width: itemWidth, height: itemHeight)}
        
    }
    
}


