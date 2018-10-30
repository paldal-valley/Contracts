pragma solidity ^0.4.23;


contract Seller {


  string ipfsHash;
  address public sellerAddress;
  uint listingID;


  function sendPost(string hash, address seller, uint id) public {
      ipfsHash = hash;
      sellerAddress = seller;
      listingID = id;

  }



  event PostCreated(string ipfsHash_, address sellerAddress_, uint listingID_);

  function CreatedPost(){
      emit PostCreated(ipfsHash, sellerAddress, listingID);

  }

  mapping(uint => address) public postIDtoSellerAccount;





}
