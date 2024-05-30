﻿using HMartBackEnd.Models;

using Microsoft.AspNetCore.Mvc;

using System.Data.SqlClient;


namespace HMartBackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdminController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        public AdminController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpPost]
        [Route("addUpdateProduct")]
        public Response addUpdateProduct(Products products)
        {
            DAL dal = new DAL();
            SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("HMartCS").ToString());
            Response response = dal.addUpdateProduct(products, connection);
            return response;
        }

        [HttpGet]
        [Route("userList")]
        public Response userList()
        {
            DAL dal = new DAL();
            SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("HMartCS").ToString());
            Response response = dal.userList(connection);
            return response;
        }

        [HttpPost]
        [Route("updateFund")]
        public Response updateFund(Users users)
        {
            Response response = new Response();
            DAL dal = new DAL();
            SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("HMartCS").ToString());
            response = dal.updateFund(users, connection);
            return response;
        }

        [HttpPost]
        [Route("updateOrderStatus")]
        public Response updateOrderStatus(Orders order)
        {
            DAL dal = new DAL();
            SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("HMartCS").ToString());
            Response response = dal.updateOrderStatus(order, connection);
            return response;
        }

        [HttpPost]
        [Route("UploadFile")]
        public Response UploadFile([FromForm] FileModel fileModel)
        {
            Response response = new Response();
            try
            {
               
                string path = Path.Combine(@"D:\Code\TTCS\HMart\HMartFrontEnd\public\assets\images\", fileModel.FileName);
                using (Stream stream = new FileStream(path, FileMode.Create))
                {
                    fileModel.FormFile.CopyTo(stream);
                }
                response.StatusCode = 200;
                response.StatusMessage = "File uploaded";
            }
            catch (Exception ex)
            {
                response.StatusCode = 100;
                response.StatusMessage = "File upload failed" + ex.Message;
            }
            return response;
        }

        [HttpPost]
        [Route("cartList")]
        public Response cartList(Cart cart)
        {
            DAL dal = new DAL();
            SqlConnection connection = new SqlConnection(_configuration.GetConnectionString("HMartCS").ToString());
            Response response = dal.cartList(cart,connection);
            return response;
        }
    }
}
