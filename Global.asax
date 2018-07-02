<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown
        HttpContext.Current.Session.Abandon();
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs
    }

    void Session_Start(object sender, EventArgs e) 
    {
        //New order created at start of every session. Set to false when first item is added to cart.
        Session["NewOrder"] = true; 
        
        Session["CustomerOrderNumber"] = -1;

        Session["CustomerCardExpirationDate"] = "";
        Session["CustomerFirstName"] = "";
        Session["CustomerLastName"] = "";
        Session["CustomerStreetAddress"] = "";
        Session["CustomerZipCode"] = "";
        Session["CustomerState"] = "";
        Session["CustomerCity"] = "";
        Session["CustomerCreditCardType"] = "";
        Session["CustomerCreditCardNumber"] = "";
        Session["CustomerCreditCVV"] = "";
        Session["CustomerPrimaryPhone"] = "";
        Session["CustomerSecondayPhone"] = "";
    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
        HttpContext.Current.Session.Abandon();
        
        Session["NewOrder"] = true;

        Session["CustomerOrderNumber"] = -1;

        Session["CustomerCardExpirationDate"] = "";
        Session["CustomerFirstName"] = "";
        Session["CustomerLastName"] = "";
        Session["CustomerStreetAddress"] = "";
        Session["CustomerZipCode"] = "";
        Session["CustomerState"] = "";
        Session["CustomerCity"] = "";
        Session["CustomerCreditCardType"] = "";
        Session["CustomerCreditCardNumber"] = "";
        Session["CustomerCreditCVV"] = "";
        Session["CustomerPrimaryPhone"] = "";
        Session["CustomerSecondayPhone"] = "";
    }
       
</script>