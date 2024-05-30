import React, { Fragment, useEffect, useState } from "react";
import axios from "axios";
import AdminHeader from "./AdminHeader";
import { baseUrl } from "../constants";
import { Link } from "react-router-dom";
import ScrollToTop from "react-scroll-to-top";

export default function Product() {
  const [data, setData] = useState([]);
  const [productId, setProductId] = useState("");
  const [name, setName] = useState("");
  const [manufacturer, setManufacturer] = useState("");
  const [unitPrice, setUnitPrice] = useState("");
  const [discount, setDiscount] = useState("");
  const [quantity, setQuantity] = useState("");
  const [expdate, setExpdate] = useState("");
  const [file, setFile] = useState("");
  const [fileName, setFileName] = useState("");
  const [addUpdateFlag, setAddUpdateFlag] = useState(true);

  useEffect(() => {
    getData();
  }, []);
  
  const getData = () => {
    const data = {
      type: "Get",
      Email: localStorage.getItem("loggedEmail"),
    };
    const url = `${baseUrl}/api/Admin/addUpdateProduct`;
    axios
      .post(url, data)
      .then((result) => {
        const data = result.data;
        if (data.statusCode === 200) {
          setData(data.listProducts);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const deleteProduct = (e, id) => {
    debugger;
    e.preventDefault();
    const data = {
      Id: id,
      Type: "Delete",
    };
    const url = `${baseUrl}/api/Admin/addUpdateProduct`;
    axios
      .post(url, data)
      .then((result) => {
        const data = result.data;
        if (data.statusCode === 200) {
          getData();
          alert(data.statusMessage);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const editProduct = (e, id) => {
    e.preventDefault();
    setAddUpdateFlag(false);

    const data = {
      ID: id,
      Type: "GetByID",
    };
    const url = `${baseUrl}/api/Admin/addUpdateProduct`;
    axios
      .post(url, data)
      .then((result) => {
        const data = result.data;
        if (data.statusCode === 200) {
          setProductId(id);
          setName(data.listProducts[0]["name"]);
          setManufacturer(data.listProducts[0]["manufacturer"]);
          setUnitPrice(data.listProducts[0]["unitPrice"]);
          setDiscount(data.listProducts[0]["discount"]);
          setQuantity(data.listProducts[0]["quantity"]);
          setExpdate(data.listProducts[0]["expDate"]);
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  const SaveFile = (e) => {
    setFile(e.target.files[0]);
    setFileName(e.target.files[0].name);
  };

  const uploadFile = async (e) => {
    e.preventDefault();
    const formdata = new FormData();
    formdata.append("FormFile", file);
    formdata.append("FileName", fileName);

    try {
      const res = await axios.post(`${baseUrl}/api/Admin/UploadFile`, formdata);
      console.log(res);
      if (
        res.data.statusCode === 200 &&
        res.data.statusMessage === "File uploaded"
      ) {
        const data = {
          Name: name,
          Manufacturer: manufacturer,
          UnitPrice: unitPrice,
          Discount: discount,
          Quantity: quantity,
          ExpDate: expdate,
          Status: 1,
          ImageUrl: fileName,
          Type: "Add",
        };
        const url = `${baseUrl}/api/Admin/addUpdateProduct`;
        axios
          .post(url, data)
          .then((result) => {
            const data = result.data;
            if (data.statusCode === 200) {
              getData();
              Clear();
            }
          })
          .catch((error) => {
            console.log(error);
          });
      }
    } catch (ex) {
      console.log(ex);
    }
  };

  const Clear = () => {
    setName("");
    setManufacturer("");
    setUnitPrice("");
    setDiscount("");
    setExpdate("");
    setFile("");
    setFileName("");
    setQuantity("");
  };

  const updateProduct = (e) => {
    const data = {
      ID : productId,
      Name: name,
      Manufacturer: manufacturer,
      UnitPrice: unitPrice,
      Discount: discount,
      Quantity: quantity,
      ExpDate: expdate,
      Status: 1,
      ImageUrl: fileName,
      Type: "Update",
    };
    const url = `${baseUrl}/api/Admin/addUpdateProduct`;
    axios
      .post(url, data)
      .then((result) => {
        const dt = result.data;
        if (dt.statusCode === 200) {
          getData();
          Clear();
        }
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <Fragment >
      <AdminHeader />
      <ScrollToTop />
      <br></br>
      <div id="top-page"></div>
      <form>
        <div  
          class="form-row"
          style={{ width: "80%", backgroundColor: "white", margin: " auto", borderRadius:"10px" }}
        >
          <div class="form-group col-md-12">
            <h3>Product Management</h3>
          </div>
          <div className="form-group col-md-6">
            <input
              type="text"
              onChange={(e) => setName(e.target.value)}
              placeholder="Name"
              className="form-control"
              required
              value={name}
            />
          </div>
          <div className="form-group col-md-6">
            <input
              type="text"
              onChange={(e) => setManufacturer(e.target.value)}
              placeholder="Manufacturer"
              className="form-control"
              required
              value={manufacturer}
            />
          </div>

          <div className="form-group col-md-6">
            <input
              type="text"
              className="form-control"
              id="validationTextarea"
              placeholder="UnitPrice"
              onChange={(e) => setUnitPrice(e.target.value)}
              required
              value={unitPrice}
            ></input>
          </div>
          <div className="form-group col-md-6">
            <input
              type="text"
              onChange={(e) => setDiscount(e.target.value)}
              placeholder="Discount"
              className="form-control"
              required
              value={discount}
            />
          </div>
          <div className="form-group col-md-6">
            <input
              type="text"
              onChange={(e) => setQuantity(e.target.value)}
              placeholder="Quantity"
              className="form-control"
              required
              value={quantity}
            />
          </div>
          <div className="form-group col-md-6">
            <input
              type="date"
              onChange={(e) => setExpdate(e.target.value)}
              placeholder="Exp Date"
              className="form-control"              
              value={expdate}
              
            />
          </div>
          <div className="form-group col-md-6">
            <input
              type="file"
              onChange={(e) => SaveFile(e)}
              placeholder="Image url"
              className="form-control"
              value=""
            />
          </div>
          <div className="form-group col-md-6">
            
            {addUpdateFlag ? (
              <button
                className="btn btn-primary"
                style={{ width: "150px", float: "left" }}
                onClick={(e) => uploadFile(e)}
              >
                Add
              </button>
            ) : (
              <button
                className="btn btn-primary"
                style={{ width: "150px", float: "left" }}
                onClick={(e) => updateProduct(e)}
              >
                Update
              </button>
            )}
            <button
              className="btn btn-danger"
              style={{ width: "150px" }}
              onClick={(e) => Clear(e)}
            >
              Reset
            </button>
          </div>
        </div>
      </form>
      {data ? (
        <table
          className="table stripped table-hover mt-4"
          style={{ backgroundColor: "white", width: "80%", margin: "0 auto", borderRadius:"10px"}}
        >
          <thead className="thead-dark">
            <tr>
              <th scope="col">#</th>
              <th scope="col">Name</th>
              <th scope="col">Manufacturer</th>
              <th scope="col">UnitPrice</th>
              <th scope="col">Discount</th>
              <th scope="col">Quantity</th>
              <th scope="col">Exp Date</th>
              <th scope="col">Image</th>
              <th scope="col" colSpan="2">
                Action
              </th>
            </tr>
          </thead>
          <tbody>
            {data.map((val, index) => {
              return (
                <tr key={index} >
                  <td scope="row" className="center">{index + 1}</td>
                  <td className="center">{val.name}</td>
                  <td className="center">{val.manufacturer}</td>
                  <td className="center">{val.unitPrice}</td>
                  <td className="center">{val.discount}</td>
                  <td className="center">{val.quantity}</td>
                  <td className="center">{val.expDate}</td>
                  <td className="center">
                    <img
                      src={`assets/images/${val.imageUrl}`}
                      style={{ width: "70px", borderRadius: "11px" }}
                    />
                  </td>
                  <td className="center">
                      <button onClick={(e) => editProduct(e, val.id)}>
                        Edit   
                      </button>{" "}
                
                  </td>
                  <td className="center">
                    <button onClick={(e) => deleteProduct(e, val.id)}>
                      Delete
                    </button>{" "}
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      ) : (
        "Không có sản phẩm nào"
      )}
    </Fragment>
  );
}
