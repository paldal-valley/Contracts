pragma solidity ^0.4.24;

//import "../../../../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract DietManager {
    
    event DietData(address indexed party, bytes32 ipfsHash); //party ---> msg.sender라고 생각하면 될 듯
    event OfferCreated (address indexed party, uint indexed offerID, bytes32 ipfsHash);
    event OfferAccepted (address indexed party, uint indexed offerID, bytes32 ipfsHash);
    event OfferFinalized (address indexed party, uint indexed offerID, bytes32 ipfsHash);
    event OfferData (address indexed party, uint indexed offerID, bytes32 ipfsHash);
    
    struct Offer{
        uint value;
        address seller;
        address buyer;
        uint finalizes; //Timestamp offer finalizes
        uint8 status; // 0: Undefined, 1: Created, 2:Accepted
    }
    
    Offer[] public offers;
    
    function totalOffers() public view returns (uint) {
        return offers.length;
    }
    
    function makeOffer(
        address _seller,
        bytes32 _ipfsHash,
        uint _finalizes,
        uint _value) public payable {
        
        offers.push(Offer({
            status: 1,
            seller : _seller,
            buyer: msg.sender,
            finalizes: _finalizes,
            value: _value
        }));
        
    
        emit OfferCreated(msg.sender, offers.length-1, _ipfsHash);
        
    }
    
    function acceptOffer(uint offerID, bytes32 _ipfsHash) public {
        Offer storage offer = offers[offerID];
        require(msg.sender == offer.seller, "Seller must accept");
        
        if(offer.finalizes <1000000000 ){
            offer.finalizes= now+offer.finalizes;
        }
        offer.status = 2;
        
        emit OfferAccepted(msg.sender, offerID, _ipfsHash);
    }
    
    function finalize(uint offerID, bytes32 _ipfsHash)public{
        Offer storage offer = offers[offerID];
        if(now <= offer.finalizes){
            require(msg.sender == offer.buyer,"Only buyer can finalize");
            
        }
        require(offer.status == 2, "status != accepted");
        //paySeller
        offer.seller.transfer(offer.value);
        emit OfferFinalized(msg.sender, offerID, _ipfsHash);
        delete offers[offerID];
    }
    
    function addData(bytes32 ipfsHash) public {
        emit DietData(msg.sender, ipfsHash);
    }
    
    function addData(uint offerID, bytes32 ipfsHash) public {
        emit OfferData(msg.sender, offerID, ipfsHash);
    }
    
}