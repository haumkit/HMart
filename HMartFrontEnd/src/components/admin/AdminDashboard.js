import React, { Fragment } from  'react';
import AdminHeader from './AdminHeader';

export default function AdminDashboard(){    
    return(
        <Fragment>
        <AdminHeader />
        <div style={{display:"flex", justifyContent:"center", alignItems:"center", width:"auto", minHeight:"700px"}}>
                <h1 style={{fontSize:"100px", fontWeight:"750", textAlign:"center"}}>Welcome to H-Mart</h1>
            </div>
        </Fragment>
    )
}