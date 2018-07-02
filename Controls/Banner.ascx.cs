/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "Controls/Banner.ascx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Controls_Banner : System.Web.UI.UserControl {
    protected void Page_Load(object sender, EventArgs e) {
        /*
        HorizontalPanel.Visible = false;
        VerticalPanel.Visible = false;

        switch (DisplayDirection) {
            case Direction.Horizontal:
                HorizontalPanel.Visible = true;
                HorizontalLink.HRef = NavigateUrl;
                break;
        }   //end switch
        */
    }   //end Page_Load event handler

    public Direction DisplayDirection { get; set; }

    public string NavigateUrl {
        get {
            object _navigateUrl = ViewState["NavigateUrl"];
            if (_navigateUrl != null) {
                return (string)_navigateUrl;
            } else {
                return "http://p2p.wrox.com";   //Return a default value
            }   //end if
        }   //end get
        
        set {
            ViewState["NavigateUrl"] = value;
        }   //end set
    }   //end NavigateUrl
}   //end partial class Controls_Banner