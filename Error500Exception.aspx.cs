/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "Error500Exception.aspx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Error500Exception : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) {
        Response.Status = "500 Server Error";
        Response.StatusCode = 500;
    }
}