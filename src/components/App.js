import React, {useEffect, useState} from 'react';
import Web3 from 'web3';
import detectEthereumProvider from "@metamask/detect-provider";
import Navbar from './navbar/Navbar.js'
import KryptoBird from '../abis/CryptoBirdz.json';
import KryptoBirdComponent from './cryptobird/CryptoBird'
import './App.css'

const App = ()=> {
    const [account, setAccount] = useState('');
     const [contract, setContract] = useState(null);
     const [totalSupply, setTotalSupply] = useState(null);
     const [cryptoBirdz, setCryptoBirdz]  = useState([]);
    const [cryptoBird, setCryptoBird]  = useState('');
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
          window.alert("no wallet detected");
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

           const totalSupplyData = await contractAt.methods.totalSupply().call();
           setTotalSupply(totalSupplyData)

            for(let i = 1; i <= totalSupply; i++){
                const kryptoBird = await contract.methods.kryptoBirds(i - 1).call();
                setCryptoBirdz([...cryptoBirdz, kryptoBird]);
            }
       }else {
           window.alert("smart contract not deployed");
       }

    }

    const mint = (cryptoBird) => {
        if(contract){
            contract.methods.mint(cryptoBird).send({from: account}, (error, result)=> {
                if(result){
                    setCryptoBirdz([...cryptoBirdz, cryptoBird]);
                    setCryptoBird('')
                    window.alert("result: "+ result );
                }else{
                    window.alert("error: "+ JSON.stringify(error) );
                }
            })
        }else {
            window.alert("contract does not exist");
        }

    }

    const onSubmit = (event)=> {
        event.preventDefault();
        if(cryptoBird){
            mint(cryptoBird);
        }else{
            window.alert("not crypto Bird to mint");
        }
    }

  return (
      <div className="container-filled">
          <Navbar account={account}/>
          <div className="container-fluid mt-1">
            <div className="row">
                <main role="main" className="col-lg-12 d-flex text-center">
                    <div className="content mr-auto ml-auto ml-auto" style={{opacity: '0.8'}}>
                        <h1 style={{color: "white"}}>CryptoBirdz - NFT MARKETPLACE</h1>
                        <form onSubmit={(event)=> onSubmit(event)}>
                            <input type='text' placeholder="add a file location" className="form-control mb-1"
                                   value={cryptoBird}
                                   onChange={(event)=> setCryptoBird(event.target.value)}
                            />
                            <input style={{margin: '6px'}} type='submit' value="MINT" className="btn btn-primary btn-black"
                            />
                        </form>

                    </div>

                </main>
            </div>
              <KryptoBirdComponent cryptoBirdz={cryptoBirdz}/>
          </div>
      </div>
  )
}

export default App;