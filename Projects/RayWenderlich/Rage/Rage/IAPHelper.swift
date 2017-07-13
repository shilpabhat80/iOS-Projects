/*
* Copyright (c) 2016 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import StoreKit

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> ()


open class IAPHelper : NSObject  {
  
  static let IAPHelperPurchaseNotification = "IAPHelperPurchaseNotification"
  
  fileprivate var productIdentifiers: Set<ProductIdentifier>
  fileprivate var purchasedProductIdentifiers =  Set<ProductIdentifier>()
  fileprivate var productsRequest: SKProductsRequest?
  fileprivate var productsRequestCompletionHandler: ProductsRequestCompletionHandler?

  public init(productIds: Set<ProductIdentifier>) {
    
    productIdentifiers = productIds
    
    super.init()
    
    for productIdentifier in productIds {
      let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
      if purchased {
        purchasedProductIdentifiers.insert(productIdentifier)
        print("Previously purchased: \(productIdentifier)")
      } else {
        print("Not purchased: \(productIdentifier)")
      }
    }
  }
}

// MARK: - StoreKit API

extension IAPHelper {
  
  public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
    completionHandler(false, [])
    
    productsRequest?.cancel()
    productsRequestCompletionHandler = completionHandler
    
    productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
    productsRequest!.delegate = self
    productsRequest!.start()
  }

  public func buyProduct(_ product: SKProduct) {
    
    let payment = SKPayment(product: product)
    SKPaymentQueue.default().add(payment)
    
  }

  public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
    return purchasedProductIdentifiers.contains(productIdentifier)
  }
  
  public class func canMakePayments() -> Bool {
    return SKPaymentQueue.canMakePayments()
  }
  
  public func restorePurchases() {
    SKPaymentQueue.default().restoreCompletedTransactions()
  }
}

extension IAPHelper: SKProductsRequestDelegate {
  
  public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
  
    let prods = response.products
    productsRequestCompletionHandler?(true, prods)
    clearRequestAndHandler()

    for p in prods {
      print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
    }
  }
  
  public func request(_ request: SKRequest, didFailWithError error: Error) {
    productsRequestCompletionHandler?(false, nil)
    clearRequestAndHandler()
  }
  
  private func clearRequestAndHandler() {
    productsRequest = nil
    productsRequestCompletionHandler = nil
  }
}

extension IAPHelper: SKPaymentTransactionObserver {
  
  public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    for transaction in transactions {
      switch transaction.transactionState {
      case .purchased:
        complete(transaction:transaction)
      case .failed:
        fail(transaction:transaction)
      case .restored:
        restore(transaction:transaction)
      default:
        break
      }
    }
  }
  
  private func complete(transaction:SKPaymentTransaction) {
    deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func fail(transaction:SKPaymentTransaction) {
    
    if let transactionError = transaction.error as NSError? {
      print("Transaction Error: \(transactionError.localizedDescription)")
    }
    SKPaymentQueue.default().finishTransaction(transaction)
  }

  private func restore(transaction:SKPaymentTransaction) {
    
    guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
    deliverPurchaseNotificationFor(identifier: productIdentifier)
    SKPaymentQueue.default().finishTransaction(transaction)
  }
  
  private func deliverPurchaseNotificationFor(identifier:String?) {
    guard let identifier = identifier else { return }
    
    purchasedProductIdentifiers.insert(identifier)
    
  }
}
