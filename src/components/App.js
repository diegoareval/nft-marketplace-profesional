import React, {useEffect, useState} from 'react';
import Web3 from 'web3';
import detectEthereumProvider from "@metamask/detect-provider";
import Navbar from './navbar/Navbar.js'
import KryptoBird from '../abis/CryptoBirdz.json';

const App = ()=> {
    const [account, setAccount] = useState('');
     const [contract, setContract] = useState(null);
     const [totalSupply, setTotalSupply] = useState(null);
     const [cryptoBirdz, setCryptoBirdz]  = useState([]);
    useEffect( ()=>{
         loadWeb3();
        }, []
    )
    const loadWeb3 = async ()=>{
      const provider = await detectEthereumProvider();
      if(provider) {
          console.log("ethereum wallet connected")
          window.web3 = new Web3(provider);
          loadBlockChainData()
      }else {
          console.log("no wallet detected")
      }
    }

    const loadBlockChainData = async ()=>{
        const web3 = window.web3;
       const accounts = await web3.eth.getAccounts();
       setAccount(accounts[0]);
       const networkId = await web3.eth.net.getId();
       const networkData = KryptoBird.networks[networkId];
       if(networkData)  {
           const abi = KryptoBird.abi;
           const address =  networkData.address;
           const contractAt =  new web3.eth.Contract(abi, address);
           setContract(contractAt);
           // total supply
           const totalSupplyData = await contractAt.methods.totalSupply() .call();
           setTotalSupply(totalSupplyData)

            for(let i = 1; i <= totalSupply; i++){
                const kryptoBird = await contract.methods.kryptoBirds(i - 1).call();
                setCryptoBirdz([...cryptoBirdz, kryptoBird]);
            }
       }else {
           window.alert("smart contract not deployed");
       }

    }
    console.log(cryptoBirdz)

  return (
      <div>
          <Navbar account={account}/>
          <h1>NFT marketplace</h1>
      </div>
  )
}

export default App;