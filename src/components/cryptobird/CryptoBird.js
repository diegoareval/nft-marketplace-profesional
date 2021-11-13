import React from 'react';
import {MDBCard, MDBCardBody, MDBBtn, MDBCardImage, MDBCardTitle, MDBCardText} from "mdb-react-ui-kit";


const CryptoBird = ({cryptoBirdz})=> {
    return (
        <>
            <hr></hr>
            <div className="row text-center">
                {
                    cryptoBirdz.map((bird, key)=> {
                     return (
                         <div key={key}>
                             <div>
                                 <MDBCard className='token img' style={{maxWidth: "22rem"}}/>
                                 <MDBCardImage src={bird} position="top" height="250rem" style={{marginRight: '4px'}}></MDBCardImage>
                                 <MDBCardBody>
                                 <MDBCardTitle>CryptoBird</MDBCardTitle>
                                     <MDBCardText>My Non Fungible token Marketplace(NFT)</MDBCardText>
                                     <MDBBtn href={bird}>
                                         download
                                     </MDBBtn>
                                 </MDBCardBody>
                             </div>
                         </div>
                     )

                    })
                }
            </div>
        </>
    )
}

export default CryptoBird