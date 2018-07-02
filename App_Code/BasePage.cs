/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "App_Code/BasePage.cs"
 * Assignment: Final Project
 */

using System;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
public class BasePage : System.Web.UI.Page
{
    private void Page_PreInit(object sender, EventArgs e)
    {
    }   //end Page_PreInit


    private void Page_PreRender(object sender, EventArgs e)
    {
        if (this.Title == "Untitled Page" || string.IsNullOrEmpty(this.Title))
        {
            throw new Exception("Page title cannot be \"Untitled Page\" or an empty string.");
        }   //end if
    }   //end Page_PreRender


    public BasePage()
    {
        this.PreRender += new EventHandler(Page_PreRender);
        this.PreInit += new EventHandler(Page_PreInit);
    }   //end default constructor
}   //end class BasePage
