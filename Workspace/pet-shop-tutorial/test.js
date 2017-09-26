var SimpleStorage = artifacts.require("Adoption");

module.exports = function(done) {
  console.log("Getting deployed version of SimpleStorage...")
  SimpleStorage.deployed().then(function(instance) {
    console.log("Setting value to 65...");
    return instance.GetOwner.call();
  }).then(function(result) {
    console.log("Result:", result);
    done();
  }).catch(function(e) {
    console.log(e);
    done();
  });
};