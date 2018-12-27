pragma solidity ^0.4.24;

contract DietManager {


    event DietData(address indexed party, string ipfsHash); //party ---> msg.sender
    event ListingCreated(address indexed party, uint indexed listingID, string ipfsHash);
    event ListingData(address indexed party, uint indexed listingID, string ipfsHash);
    event OfferCreated (address indexed party, uint indexed listingID, uint indexed offerID, string ipfsHash);
    event OfferFinalized (address indexed party, uint indexed listingID, uint indexed offerID, string ipfsHash);
    event OfferData(address indexed party,uint indexed listingID, uint indexed offerID, string ipfsHash);

    struct Listing {
        address seller;
    }

    struct Offer{

        address buyer;
        uint8 status; // 0: Undefined, 1: Created, 2:Completed
    }

    Listing[] public listings;
    mapping(uint => Offer[]) public offers; //listingID => Offers
    //Offer[] public offers;


    function totalOffers(uint listingID) public view returns (uint) {
        return offers[listingID].length;
    }

    function totalListings() returns(uint) {
        return listings.length;
    }

    function createListing (string _ipfsHash) public {
        _createListing(msg.sender, _ipfsHash);
    }

    function _createListing (address _seller, string _ipfsHash) internal {
        listings.push(Listing({
            seller : _seller
            }));

        emit ListingCreated(_seller, listings.length-1, _ipfsHash);
    }

    function makeOffer(
        uint listingID,
        string _ipfsHash) public payable {

        offers[listingID].push(Offer({
            status: 1,
            buyer: msg.sender

        }));

        emit OfferCreated(msg.sender, listingID, offers[listingID].length-1, _ipfsHash);

    }



    function finalize(uint listingID, uint offerID, string _ipfsHash) public payable {
        Listing storage listing = listings[listingID];
        Offer storage offer = offers[listingID][offerID];

        require(msg.sender == offer.buyer, "Only buyer can finalize");
        require(offer.status == 1, "status != created");

        listing.seller.transfer(msg.value);
        offer.status = 2;
        emit OfferFinalized(msg.sender, listingID, offerID, _ipfsHash);

    }

    function addData1(string ipfsHash) public {
        emit DietData(msg.sender, ipfsHash);
    }

    function addData2(uint listingID, uint offerID, string ipfsHash) public {
        emit ListingData(msg.sender, listingID, ipfsHash);
    }

    function addData3(uint listingID, uint offerID, string ipfsHash) public {
        emit OfferData(msg.sender, listingID, offerID, ipfsHash);
    }

}
