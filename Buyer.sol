pragma solidity ^0.4.23;

import "./Seller.sol";


contract Buyer {


  string ipfsHash;
  address public buyerAddress;
  uint listingID;
  address public sellerAddress;
  uint price = 10; // ether price 우리가 지정



  modifier onlyBuyer(){
      require(msg.sender == buyerAddress);
  }


  function sendBuying(string hash, address buyer, uint id) public {
      ipfsHash = hash;
      buyerAddress = buyer;
      listingID = id;

  }

   event Buying(string _buyerAddress, uint listingID);



  function sendMoney() public payable onlyBuyer{
    sellerAddress = postIDtoSellerAccount[listingID];
    sellerAddress.transfer(price);
    emit Buying(buyerAddress, listingID);

  }


}
