import React, { Fragment } from  'react';
import Header from './Header';

export default function Dashboard(){    
    return(
        <Fragment>
            <Header />
            <div style={{display:"flex", justifyContent:"center", alignItems:"center", width:"auto", minHeight:"700px"}}>
                <h1 style={{fontSize:"100px", fontWeight:"750", textAlign:"center"}}>Welcome to H-Mart</h1>
            </div>
        </Fragment>
    )
}