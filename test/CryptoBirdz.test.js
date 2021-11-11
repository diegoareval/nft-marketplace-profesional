const {assert} = require("chai");

const KryptoBird = artifacts.require("./CryptoBirdz");

// check for chai
require("chai").use(require('chai-as-promised')).should();


contract('CryptoBirdz', async (accounts)=> {
   let contract;


    beforeEach(async () =>  {
        contract = await KryptoBird.deployed();

    })

   describe('deployment', async ()=> {
       it('it deplys successfully', async ()=> {
          const address = contract.address;
          assert.notEqual(address, '');
           assert.notEqual(address, null);
           assert.notEqual(address, undefined);
       });

       it('has a name', async ()=> {
           const name = await contract.name();
           assert.notEqual(name, '');
           assert.notEqual(name, null);
           assert.notEqual(name, undefined);
           assert.equal(name, 'KriptoBirdz')
       });

       it('has a symbol',async  ()=> {
           const symbol = await contract.symbol();
           assert.notEqual(symbol, '');
           assert.notEqual(symbol, null);
           assert.notEqual(symbol, undefined);
           assert.equal(symbol, 'KBIRDZ');
       });
   });

    describe('minting', async ()=> {
        it('creates a new token', async ()=> {
           const result = await contract.mint('https...4');
           const totalSupply = await contract.totalSupply();
           assert.equal(totalSupply, 1);
           const event = result.logs[0].args;
            assert.equal(event[0], '0x0000000000000000000000000000000000000000', 'from the contract')
            assert.equal(event[1], accounts[0], 'to is msg.sender');

            await contract.mint('https...4').should.be.rejected;
        });
    })

    describe('indexing',  async ()=> {
        it('list cryptoBirdz', async ()=> {
            await contract.mint('https...1');
            await contract.mint('https...2');
            await contract.mint('https...3');

            const totalSupply = await contract.totalSupply();

            // loop trhrough list and grab kryptoBird
            let result = [];
            let kryptoBird;
            for(let i = 1; i <= totalSupply; i++) {
                kryptoBird = await contract.kryptoBirds(i - 1);
                result.push(kryptoBird);
            }
            const expected = ['https...4', 'https...1', 'https...2', 'https...3'];
            assert.equal(result.join(','), expected.join(','));
        })
    })
})