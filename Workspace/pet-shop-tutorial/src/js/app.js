App = {
  web3Provider: null,
  contracts: {},
  web3: null,

  init: function() {
    // Load pets.
    $.getJSON('../pets.json', function(data) {
      var petsRow = $('#petsRow');
      var petTemplate = $('#petTemplate');

      for (i = 0; i < data.length; i ++) {
        petTemplate.find('.panel-title').text(data[i].name);
        petTemplate.find('img').attr('src', data[i].picture);
        petTemplate.find('.pet-breed').text(data[i].breed);
        petTemplate.find('.pet-age').text(data[i].age);
        petTemplate.find('.pet-location').text(data[i].location);
        petTemplate.find('.btn-adopt').attr('data-id', data[i].id);

        petsRow.append(petTemplate.html());
      }
    });

    return App.initWeb3();
  },

  initWeb3: function() {
// Is there is an injected web3 instance?
var http = 'http://localhost:8545';

var provider = new Web3.providers.HttpProvider(http);

// mongoose.connect('mongodb');
// var db = mongoose.connection;

web3 = new Web3(provider);

if (typeof web3 !== 'undefined') {
  App.web3Provider = web3.currentProvider;
  web3 = new Web3(web3.currentProvider);
} 
    return App.initContract();
  },

  initContract: function() {
$.getJSON('Adoption.json', function(data) {
  // Get the necessary contract artifact file and instantiate it with truffle-contract.
  var AdoptionArtifact = data;
  App.contracts.Adoption = TruffleContract(AdoptionArtifact);

  // Set the provider for our contract.
  App.contracts.Adoption.setProvider(App.web3Provider);

  // Use our contract to retieve and mark the adopted pets.
  return App.markAdopted();
});

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.handleAdopt);
  },

  handleAdopt: function() {
    console.log(web3.eth.blockNumber);

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      } else {
        console.log(accounts);
      }
    });
  },

  markAdopted: function(adopters, account) {
    /*
     * Replace me...
     */
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
