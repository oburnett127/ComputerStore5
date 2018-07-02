/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "Checkout.aspx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Checkout : BasePage
{
    const int ITEM_NAME_COLUMN = 0;         //Index of item name column in grid view control.
    const int QTY_REQ_COLUMN = 1;           //Index of quantity requested column in grid view control.
    const int ITEM_PRICE_COLUMN = 2;        //Index of price column in grid view control.
    const int ITEM_NUM_COLUMN = 3;          //Index of item number column in grid view control.
    const int ITEM_WEIGHT_COLUMN = 4;       //Index of item weight column in grid view control.
    const int ITEM_SUBTOTAL_COLUMN = 5;     //Index of item subtotal column in grid view control.
    const int ITEM_TAX_COLUMN = 6;          //Index of item tax column in grid view control.
    const int ITEM_SHIPPING_COLUMN = 7;     //Index of item shipping column in grid view control.
    const int ITEM_TOTAL_COLUMN = 8;        //Index of item total column in grid view control.
    const int QTY_AVAILABLE_COLUMN = 9;     //Index of quantity available column in grid view control.
    const int ZIP_CODE_LENGTH = 5;
    const int PHONE_LENGTH = 10;

    //default constructor
    public Checkout()
    {
    }   //end default constructor


    //Executes when the page loads.
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtFirstName.Text = Convert.ToString(Session["CustomerFirstName"]);
            txtLastName.Text = Convert.ToString(Session["CustomerLastName"]);
            txtPrimaryPhone.Text = Convert.ToString(Session["CustomerPrimaryPhone"]);
            txtSecondaryPhone.Text = Convert.ToString(Session["CustomerSecondaryPhone"]);
            txtStreetAddress.Text = Convert.ToString(Session["CustomerStreetAddress"]);
            txtCity.Text = Convert.ToString(Session["CustomerCity"]);
            ddlState.SelectedValue = Convert.ToString(Session["CustomerState"]);
            txtZipCode.Text = Convert.ToString(Session["CustomerZipCode"]);
            txtCardCVV.Text = Convert.ToString(Session["CustomerCardCVV"]);
            txtCardNumber.Text = Convert.ToString(Session["CustomerCardNumber"]);

            if (Convert.ToString(Session["CustomerCardExpirationDate"]) != "")
            {
                calCardExpirationDate.SelectedDate = Convert.ToDateTime(Session["CustomerCardExpirationDate"]);
            }
            if (Convert.ToString(Session["CustomerCardType"]) != "")
            {
                ddlCardType.SelectedValue = Convert.ToString(Session["CustomerCardType"]);
            }
        }
    }   //end Page_Load
    

    /* Executes when the btnPlaceOrder button is clicked.  The information the customer has entered to identify themselves,
     * their contact information, and payment card information will be entered into the Orders table if all fields contain
     * valid values and if all of this information has been given by the customer.  The customer is not required to provide
     * a primary phone number, secondary phone number, or an e-mail address. */
    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        Page.Validate();    //Check input of every control that has validate control attached to it on the page.
        if (!Page.IsValid) return;  //The input of one of the controls on the page is not valid, so whole page is not valid.

        /* Create strings to be used with parameter initialization.  Initialize the strings with the values entered in the
         * corresponding controls in the table of the Checkout.aspx page. */
        string strDateTimeOrdered = Convert.ToString(System.DateTime.Now.ToString());
        string strCardType = ddlCardType.SelectedValue;
        string strCardNumber = Convert.ToString(txtCardNumber.Text);
        string strCardCVV = txtCardCVV.Text;
        string strCardExpirationDate = Convert.ToString(Session["CustomerCardExpirationDate"]);
        string strCustomerFirstName = Convert.ToString(txtFirstName.Text);
        string strCustomerLastName = Convert.ToString(txtLastName.Text);
        string strPrimaryPhone = txtPrimaryPhone.Text;
        string strSecondaryPhone = txtSecondaryPhone.Text;
        string strUserID = User.Identity.Name;
        string strStreetAddress = Convert.ToString(txtStreetAddress.Text);
        string strCity = Convert.ToString(txtCity.Text);
        string strState = Convert.ToString(ddlState.SelectedValue);
        string strZipCode = Convert.ToString(txtZipCode.Text);

        string strCustomerID = "";  //string for storing the customer's customer ID.
        string strCustomerOrderNumber = Convert.ToString(Session["CustomerOrderNumber"]);

        ///* Store information the user entered on the checkout form in session variables so the user does not have
        // * to retype the information everytime they visit the page in a session. */
        //Session["CustomerCardType"] = strCardType;
        //Session["CustomerCardNumber"] = strCardNumber;
        //Session["CustomerCardCVV"] = strCardCVV;
        //Session["CustomerCardExpirationDate"] = strCardExpirationDate;
        //Session["CustomerFirstName"] = strCustomerFirstName;
        //Session["CustomerLastName"] = strCustomerLastName;
        //Session["CustomerPrimaryPhone"] = strPrimaryPhone;
        //Session["CustomerSecondaryPhone"] = strSecondaryPhone;
        //Session["CustomerStreetAddress"] = strStreetAddress;
        //Session["CustomerCity"] = strCity;
        //Session["CustomerState"] = strState;
        //Session["CustomerZipCode"] = strZipCode;
         
        /* Create parameters for updating the customer's information in the record
         * for the customer in Customers table. */
        Parameter parCustomerFirstName = new Parameter("CustomerFirstName",
            TypeCode.String, strCustomerFirstName);
        Parameter parCustomerLastName = new Parameter("CustomerLastName",
            TypeCode.String, strCustomerLastName);
        Parameter parPrimaryPhone = new Parameter("PrimaryPhone",
            TypeCode.String, strPrimaryPhone);
        Parameter parSecondaryPhone = new Parameter("SecondaryPhone",
            TypeCode.String, strSecondaryPhone);
        Parameter parStreetAddress = new Parameter("StreetAddress",
            TypeCode.String, strStreetAddress);
        Parameter parCity = new Parameter("City",
            TypeCode.String, strCity);   //Value of 1 indicates order has been paid for.
        Parameter parState = new Parameter("State", TypeCode.String, strState);
        Parameter parZipCode = new Parameter("ZipCode", TypeCode.String, strZipCode);

        /* See if the user has a customer record in the Customers table or not.
         * If they do their CustomerID will be stored in GridViewCustomerID,
         * allowing for access to the customerID in this code behind file.  If they do
         * not have a record in the Customers table then a record will be created. */
        DataSourceSelectArguments selectArguments = new DataSourceSelectArguments();
        Parameter parUserID = new Parameter("UserID", TypeCode.String, strUserID);
        SqlDataSourceCustomers1.SelectParameters.Insert(0, parUserID);
        SqlDataSourceCustomers1.Select(selectArguments);

        if (GridViewCustomerID1.Rows.Count > 0)
        {   //A customer record was found for the user.
            //Store customerID in strCustomerID.
            strCustomerID = GridViewCustomerID1.Rows[0].Cells[0].Text;

            Parameter parCustomerID = new Parameter("CustomerID",
                TypeCode.Int32, strCustomerID);

            /* Create parameters for insert operation on customers table. */
            SqlDataSourceCustomers1.UpdateParameters.Insert(0, parCustomerID);
            SqlDataSourceCustomers1.UpdateParameters.Insert(1, parUserID);
            SqlDataSourceCustomers1.UpdateParameters.Insert(2, parCustomerFirstName);
            SqlDataSourceCustomers1.UpdateParameters.Insert(3, parCustomerLastName);
            SqlDataSourceCustomers1.UpdateParameters.Insert(4, parPrimaryPhone);
            SqlDataSourceCustomers1.UpdateParameters.Insert(5, parSecondaryPhone);
            SqlDataSourceCustomers1.UpdateParameters.Insert(6, parStreetAddress);
            SqlDataSourceCustomers1.UpdateParameters.Insert(7, parCity);
            SqlDataSourceCustomers1.UpdateParameters.Insert(8, parState);
            SqlDataSourceCustomers1.UpdateParameters.Insert(9, parZipCode);

            /* Run update command on Customers SQL table which inserts information
             * the customer entered on this page into their record. */
            SqlDataSourceCustomers1.Update();
        }
        else
        {   /* A customer record was not found for the user.  Generate a new
             * customer id for the user. */
            int intGreatestCustomerNumber = 0;

            DataSourceSelectArguments select2Arguments
                = new DataSourceSelectArguments();
            SqlDataSourceCustomers3.Select(select2Arguments);
            int intCustomersRecordCount
                = Convert.ToInt32(Convert.ToString(
                GridViewCustomersRecordCount.Rows[0].Cells[0].Text));

            if (intCustomersRecordCount > 0)
            {
                SqlDataSourceCustomers2.Select(select2Arguments);
                intGreatestCustomerNumber = Convert.ToInt32(Convert.ToString(
                    GridViewGreatestCustomerNumber.Rows[0].Cells[0].Text));
            }   //end if

            intGreatestCustomerNumber = intGreatestCustomerNumber + 1;

            strCustomerID = Convert.ToString(intGreatestCustomerNumber);
            
            Parameter parCustomerID = new Parameter("CustomerID",
                TypeCode.Int32, strCustomerID);

            /* Create parameters for insert operation on customers table. */
            SqlDataSourceCustomers2.InsertParameters.Insert(0, parCustomerID);
            SqlDataSourceCustomers2.InsertParameters.Insert(1, parUserID);
            SqlDataSourceCustomers2.InsertParameters.Insert(2, parCustomerFirstName);
            SqlDataSourceCustomers2.InsertParameters.Insert(3, parCustomerLastName);
            SqlDataSourceCustomers2.InsertParameters.Insert(4, parPrimaryPhone);
            SqlDataSourceCustomers2.InsertParameters.Insert(5, parSecondaryPhone);
            SqlDataSourceCustomers2.InsertParameters.Insert(6, parStreetAddress);
            SqlDataSourceCustomers2.InsertParameters.Insert(7, parCity);
            SqlDataSourceCustomers2.InsertParameters.Insert(8, parState);
            SqlDataSourceCustomers2.InsertParameters.Insert(9, parZipCode);

            /* Run insert command on Customers SQL table which inserts information
             * the customer entered on this page into their record. */
            SqlDataSourceCustomers2.Insert();
        }   //end if
        

        /* Create parameters for the update operation on the Orders SQL table.
         * The OrderNumber and UserID have already been entered into the Orders
         * table and do not need to be re-entered.  The DateTimeOrdered field for
         * the order record needs to have its value replaced with the current time,
         * the time shortly after the btnPlaceOrder button is clicked.  This field
         * was filled with a temporary date time value earlier to keep from having
         * to allow null values.  Allowing null values on a field that must contain
         * an accurate value upon order completion is bad practice.  A value of 1
         * in the parPurchasedParameter to fill the Purchased attribute of the
         * orders record indicates the order has been paid for.  If the insert
         * operation is completed without error the value of 1 will be inserted
         * into the Purchased field, and the order is complete.  If the insert
         * operation is not completed without error a value of 0 will remain
         * in the Purchased field and the order will be incomplete. OrderNumber
         * parameter is for the where clause. */
        Parameter parDateTimeOrdered = new Parameter("DateTimeOrdered", TypeCode.DateTime, strDateTimeOrdered);

        //Card type should be a string, if it were integer and values assigned to each card changed then information in DB may be incorrect.
        Parameter parCardTypeParameter = new Parameter("CardType", TypeCode.String, strCardType);

        Parameter parCardNumberParameter = new Parameter("CardNumber", TypeCode.String, strCardNumber);
        Parameter parCardCVVParameter = new Parameter("CardCVV", TypeCode.String, strCardCVV);  //CVV is 3 digit security code.
        Parameter parCardExpirationDate = new Parameter("CardExpirationDate", TypeCode.DateTime, strCardExpirationDate);
        Parameter parPurchasedParameter = new Parameter("Purchased", TypeCode.Char, "1");   //Value of 1 indicates order has been paid for.
        Parameter parOrderNumber = new Parameter("OrderNumber", TypeCode.Int32, strCustomerOrderNumber);    //Used to locate order record.
        
        //Add parameters for inserting order record into Orders table to InsertParameters collection of SqlDataSourceOrders.
        SqlDataSourceOrders.UpdateParameters.Insert(0, parDateTimeOrdered);
        SqlDataSourceOrders.UpdateParameters.Insert(1, parCardTypeParameter);
        SqlDataSourceOrders.UpdateParameters.Insert(2, parCardNumberParameter);
        SqlDataSourceOrders.UpdateParameters.Insert(3, parCardCVVParameter);
        SqlDataSourceOrders.UpdateParameters.Insert(4, parCardExpirationDate);
        SqlDataSourceOrders.UpdateParameters.Insert(5, parCustomerFirstName);
        SqlDataSourceOrders.UpdateParameters.Insert(6, parCustomerLastName);
        SqlDataSourceOrders.UpdateParameters.Insert(7, parPurchasedParameter);
        SqlDataSourceOrders.UpdateParameters.Insert(8, parOrderNumber);

        /* Update the order record in the Orders table. */
        SqlDataSourceOrders.Update();

        /* NewOrder session variable must be incremented so new order is created if the user wants to place another order before
           ending their session. */
        Session["NewOrder"] = true;

        /* Store information needed for order details on ViewOrder.aspx page in session variables so they can be accessed on that page. */
        Session["DateTimeOrdered"] = strDateTimeOrdered;
        Session["ShippingAddress"] = strStreetAddress + " " + strCity + " " + strState + " " + strZipCode;
        Session["CustomerName"] = strCustomerFirstName + " " + strCustomerLastName;
        Session["CardNumber"] = strCardNumber;
        Session["CustomerStreetAddress"] = strStreetAddress;
        Session["CustomerCity"] = strCity;
        Session["CustomerState"] = strState;
        Session["CustomerZipCode"] = strZipCode;

        Response.Redirect("ViewOrder.aspx");

    }   //end btnPlaceOrder_Click


    /* Remove all ItemsOrdered records from the ItemsOrdered table which contain the customer's order number in the order
    * number field. Remove the Order record from the Orders table that has the customer's order number in the order number
    * field. For every item in the order that is being cancelled the quantity available in the Item table needs to be
    * increased by the quantity of the item that the user had in their cart.  Transfer user to ViewProducts.aspx page. */
    protected void btnCancelOrder_Click(object sender, EventArgs e)
    {
        int intQuantityAvailable = 0;   //To store the new quantity available after each item is removed from cart.
        int intQuantityRequested = 0;   //Used to calculate the quantity available after each item is removed from cart.
        string strItemNumber = "";  //Used to update Item table with Quantity available after each item is removed from cart.

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            //Get quantity of item to be returned to stock, item number of the item, and quantity available before the return to stock.
            intQuantityRequested = Convert.ToInt32(GridView1.Rows[i].Cells[QTY_REQ_COLUMN].Text);
            strItemNumber = GridView1.Rows[i].Cells[ITEM_NUM_COLUMN].Text;
            intQuantityAvailable = Convert.ToInt32(GridView1.Rows[i].Cells[QTY_AVAILABLE_COLUMN].Text);

            /* The new quantity of the item available in stock is the quantity before the item is returned added to the number
             * of item instances returned to stock. */
            intQuantityAvailable = intQuantityAvailable + intQuantityRequested;

            //Create parameters for the update command on the Item table for updating item quantity available.
            Parameter parQuantityAvailable = new Parameter("QuantityAvailable", TypeCode.Int32, Convert.ToString(intQuantityAvailable)); //hold new quantity.
            Parameter parItemNumber = new Parameter("ItemNumber", TypeCode.String, strItemNumber);  //Used to locate the Item record.

            //Insert the parameters for the update command on the item table to the update parameters collection of data source.
            SqlDataSourceItems.UpdateParameters.Insert(0, parQuantityAvailable);
            SqlDataSourceItems.UpdateParameters.Insert(0, parItemNumber);

            //Execute the update command on the Item table.  Quantity available should be updated.
            SqlDataSourceItems.Update();
        }   //end for

        /* Remove the records for items in this order from the ItemsOrdered table. */
        SqlDataSourceItemsOrdered.Delete();

        /* Remove the record for this order from the Orders table. */
        SqlDataSourceOrders.Delete();

        /* Session variable NewOrder has to be set to true so that when the user is transfered to the ViewProducts.aspx page
         * and they try to add an item to their cart there will be a record created for their order in the Orders table as the
         * old order record has been removed.  The problem is that the record that is supposed to be inserted
         * into the ItemsOrdered table when the user adds an item to their cart tries to reference an order number in an Orders
         * record that no longer exists.  When this variable is set to true, code in the ViewProducts.aspx page will increment
         * the CustomerOrderNumber session variable and create a new order record in the Orders table.  This way no foreign key
         * constraint violation occurs when the user adds an item to their cart after cancelling their order because an order
         * record does not exist. */
        Session["NewOrder"] = true;

        /* Transfer the user to the ViewProducts.aspx page. */
        Server.Transfer("ViewProducts.aspx");
    }   //end btnCancelOrder


    /* Executes when server validates data entered in card number text box. */
    protected void CustomValidatorCardNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (String.IsNullOrEmpty(args.Value))
        {   //The card number has not been entered, the input for the card number is not valid.
            args.IsValid = false;
        }   //end if

        try
        {   //See if card number is made only of numeric digits.
            Convert.ToInt32(txtCardNumber.Text);
        }
        catch
        {   //Non-numeric characters were entered for the payment card number.  Input is not valid.
            args.IsValid = false;
        }   //end try

        //validateCreditCard will return true if credit card number is valid and false if not.
        args.IsValid = Validate_Credit_Card(args.Value);
    }   //end CustomValidator1_ServerValidate event handler


    //protected void CustomValidatorCardExpirationDate_ServerValidate(object source, ServerValidateEventArgs args)
    //{
    //    if (calCardExpirationDate.SelectedDate.Date.CompareTo(System.DateTime.Today) == 1)
    //        //The payment card has not expired and does not expire today.
    //        args.IsValid = true;
    //    else args.IsValid = false;  /* The card is expired or expires today.  This card cannot be used to make a purchase. */
    //    //end if
    //}   //end CustomerValidatorCardExpirationDate_ServerValidate


    /* Validates a credit card number using Luhn's algorithm.  The check digit must be entered
     * with the full credit card number. */
    private bool Validate_Credit_Card(string cardNumber)
    {
        //Remove spaces from credit card number.
        cardNumber.Replace(" ", "");

        int intDigitIndex = 0;
        int intDigitValue = 0;
        int sum = 0;

        for (intDigitIndex = cardNumber.Length - 1; intDigitIndex >= 0; intDigitIndex--)
        {
            intDigitValue = Convert.ToInt32(cardNumber.Substring(intDigitIndex));

            if (intDigitIndex % 2 == 0)
                sum += intDigitValue * 2;
            else
                sum += intDigitValue;
        }   //end for

        if (sum % 10 == 0)
            //The credit card number is valid
            return true;
        else
            //The credit card number is not valid
            return false;
        //end if
    }   //end function validateCreditCard

    
    protected void calCardExpirationDate_SelectionChanged(object sender, EventArgs e)
    {
        Session["CustomerCardExpirationDate"] = Convert.ToString(calCardExpirationDate.SelectedDate);
    }   //end function Save_Form_Data()

    protected void txtFirstName_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerFirstName"] = txtFirstName.Text.ToString(); 
    }

    protected void txtLastName_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerLastName"] = Convert.ToString(txtLastName.Text);
    }

    protected void txtPrimaryPhone_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerPrimaryPhone"] = Convert.ToString(txtPrimaryPhone.Text);
    }

    protected void txtSecondaryPhone_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerSecondaryPhone"] = Convert.ToString(txtSecondaryPhone.Text);
    }

    protected void txtStreetAddress_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerStreetAddress"] = Convert.ToString(txtStreetAddress.Text);
    }

    protected void txtCity_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerCity"] = Convert.ToString(txtCity.Text);
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["CustomerState"] = Convert.ToString(ddlState.SelectedValue);
    }

    protected void txtZipCode_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerZipCode"] = Convert.ToString(txtZipCode.Text);
    }

    protected void txtCardCVV_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerCardCVV"] = Convert.ToString(txtCardCVV.Text);
    }

    protected void txtCardNumber_TextChanged(object sender, EventArgs e)
    {
        Session["CustomerCardNumber"] = Convert.ToString(txtCardNumber.Text);
    }

    protected void ddlCardType_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["CustomerCardType"] = Convert.ToString(ddlCardType.SelectedValue);
    }
}   //end class Checkout