pragma solidity ^0.4.23;

contract Buying {

  string ipfsHash;
  address public sellerAddress;
  uint listingID;
  uint balance = 100;
  address public buyerAddress;


  mapping(uint => address) public postIDtoSellerAccount;




//   function getMapping(uint _id) public view returns (address) {
//     return postIDtoSellerAccount[_id];
//   }

    // set mapping included
  function sendPost(string hash, address seller, uint id) public {
      ipfsHash = hash;
      sellerAddress = seller;
      listingID = id;
      postIDtoSellerAccount[id] = seller;
  }

  event funcpostIDtoSellerAccountEvent(address _from);
  function funcpostIDtoSellerAccount() external returns(address){
      emit funcpostIDtoSellerAccountEvent(this);
      return sellerAddress;

  }

  event PostCreated(string ipfsHash_, address sellerAddress_, uint listingID_);


  function CreatedPost(){
      emit PostCreated(ipfsHash, sellerAddress, listingID);
  }





//   modifier onlyBuyer(){
//       require(msg.sender == buyerAddress);
//       _;
//   }



//  function callsellerAddress(address _contractAddress) public returns (address){
//         require(_contractAddress.call(bytes4(keccak256("funcpostIDtoSellerAccount()"))));
//         require(_contractAddress.delegatecall(bytes4(keccak256("funcpostIDtoSellerAccount()"))));

//         return sellerAddress2;

//  }


  function sendBuying(string hash, address buyer, uint id) public{

      ipfsHash = hash;
      buyerAddress = buyer;
      listingID = id;
    //   sellerAddress = bscontract.getpostIDtoSellerAccount(id);
    //   sellerAddress2 = s.funcpostIDtoSellerAccount(id);
    //   sellerAddress2 = s.funcpostIDtoSellerAccount(id);



  }

   event Buying(address _buyerAddress, uint listingID, string _ipfsHash);


  //mapping 사용
  //price value send
  function sendMoney(uint _ID) public payable {


    balance += msg.value;
     //   sellerAddress = bscontract.getpostIDtoSellerAccount(_ID);
    sellerAddress.transfer(msg.value);
    emit Buying(buyerAddress, listingID, ipfsHash);

  }

}
