import React from 'react';

const Navbar = ({account =''}) => {
    return (
        <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
            <div className="navbar-brand col-sm-3 col-md-3 mr-0" style={{color: "white"}}>
              KryptoBirds(NFT)
            </div>
            <ul className="navbar-nav px-3">
            <li className="nav-item text-nowrap d-none d-sm-none d-sm-block">
             <small className="text-white">
                 {account}
             </small>
            </li>
            </ul>
        </nav>
    )
}

export default  Navbar;