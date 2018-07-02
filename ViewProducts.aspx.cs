/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "ViewProducts.aspx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class View_Products : BasePage
{
    const int ITEM_NAME_COLUMN = 1;             //Index of item name column in grid view control.
    const int QTY_AVAILABLE_COLUMN = 2;         //Index of quantity available column in grid view control.
    const int ITEM_PRICE_COLUMN = 3;            //Index of price column in grid view control.
    const int ITEM_DESCRIPTION_COLUMN = 4;      //Index of item description column in grid view control.
    const int ITEM_PICTURE_COLUMN = 5;          //Index of item picture column in grid view control.
    const int ITEM_NUMBER_COLUMN = 6;           //Index of item number column in grid view control.

    const int TYPE_CODE_INTEGER = 9;            //Identifies a SQL command parameter as being of the integer data type.
    const int TYPE_CODE_STRING = 18;            //Identifies a SQL command parameter as being of the string data type.


    public void Page_Load(object sender, EventArgs e)
    {
    }   //end Page_Load
 

    /* A record for the item selected in the GridView control will be added
     * to the ItemsOrdered table.  If the user has never added an item to their
     * cart during their current session a new order record will be inserted 
     * into the Orders table. */
    protected void btnAddToCart_Click(object sender, EventArgs e)
    {
        //Gets the userID of the currently logged in user.
        MembershipUser currentUser;
        currentUser = Membership.GetUser();
        String strUserID = currentUser.ToString();

        /* If the OrderInProgress Session variable is set to false that means the
        * btnAddToCart button has been clicked for the first time for the current
        * order.  The application variable OrderNumber needs to be incremented by
        * 1 as a new order is being placed by the customer.  The newly created
        * order is considered to be in progress.  The OrderInProgress session
        * variable will be set to false if the user has not added items to their
        * cart during the current session, if they have not added items to their
        * cart after they completed (made a payment) or canceled their last order
        * during the current session. */
        if ((Boolean)Session["NewOrder"] == true)
        {   /* This is the first item being added to the cart for this session, the order is a new order, but
               should not be considered a new order in the future. */
            Session["NewOrder"] = false;

            int intGreatestOrderNumber = 0;
            
            DataSourceSelectArguments selectArguments = new DataSourceSelectArguments();
            SqlDataSourceOrdersRecordCount.Select(selectArguments);
            int intOrderCount = Convert.ToInt32(Convert.ToString(GridViewOrdersRecordCount.Rows[0].Cells[0].Text));

            if (intOrderCount > 0)
            {
                SqlDataSourceOrdersRecord.Select(selectArguments);
                intGreatestOrderNumber = Convert.ToInt32(Convert.ToString(GridViewGreatestOrderNumber.Rows[0].Cells[0].Text));
            }   //end if

            Session["CustomerOrderNumber"] = intGreatestOrderNumber + 1;
            

            /* Create the parameters for the insert command for the order record. The user has not been directed to the Checkout.aspx
             page which gets the user's card information, therefore the order has not been completed.  The parPurchasedParameter
             which indicates whether the order has been completed, whether the items have been purchased, is set to 0, meaning the
             order has not been completed.  The default values for all parameters except for OrderNumber, UserID, and Purchased 
             are set to temporary values which will be changed by the user when they are directed to the Checkout.aspx page. */
            Parameter parOrderNumber = new Parameter("OrderNumber", TypeCode.Int32, Session["CustomerOrderNumber"].ToString());
            Parameter parUserIDParameter = new Parameter("UserID", TypeCode.String, strUserID);
            Parameter parDateTimeOrdered = new Parameter("DateTimeOrdered", TypeCode.DateTime, System.DateTime.Now.ToString());
            Parameter parCardTypeParameter = new Parameter("CardType", TypeCode.String, "not_specified");
            Parameter parCardNumberParameter = new Parameter("CardNumber", TypeCode.String, "0000000000");
            Parameter parCardCVVParameter = new Parameter("CardCVV", TypeCode.String, "000");
            Parameter parCardExpirationDate = new Parameter("CardExpirationDate", TypeCode.DateTime, System.DateTime.Now.ToString());
            Parameter parCustomerFirstName = new Parameter("CustomerFirstName", TypeCode.String, "not_specified");
            Parameter parCustomerLastName = new Parameter("CustomerLastName", TypeCode.String, "not_specified");
            Parameter parPurchasedParameter = new Parameter("Purchased", TypeCode.Char, "0");

            //Add parameters for inserting order record into Orders table to InsertParameters collection of SqlDataSourceOrdersRecord.
            SqlDataSourceOrdersRecord.InsertParameters.Insert(0, parOrderNumber);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(1, parUserIDParameter);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(2, parDateTimeOrdered);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(3, parCardTypeParameter);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(4, parCardNumberParameter);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(5, parCardCVVParameter);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(6, parCardExpirationDate);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(7, parCustomerFirstName);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(8, parCustomerLastName);
            SqlDataSourceOrdersRecord.InsertParameters.Insert(9, parPurchasedParameter);

            //Insert the record for the order into the Orders table.
            SqlDataSourceOrdersRecord.Insert();
        }   //end if

        /* Decrement the QuantityAvailable field of the record in the Item table for the item that is being added to the cart
         * by the quantity of the item the user has requested. */
        int intQuantityRequested = Convert.ToInt32(txtQuantityRequested.Text);

        /* First, get the quantity available before the current item is placed in the cart and decrement this number by the quantity
         * of the item the user has requested. */
        int intItemQuantityAvailable = Convert.ToInt32(GridView1.SelectedRow.Cells[QTY_AVAILABLE_COLUMN].Text);
        intItemQuantityAvailable = intItemQuantityAvailable - intQuantityRequested;

        //Get item number of selected row in grid view control.
        string strItemNumber = GridView1.SelectedRow.Cells[ITEM_NUMBER_COLUMN].Text;

        //Create parameters for the update operation on the item record for decrementing the quantity available.
        Parameter QuantityAvailable = new Parameter("QuantityAvailable", TypeCode.Int32, intItemQuantityAvailable.ToString());
        Parameter ItemNumber = new Parameter("ItemNumber", TypeCode.String, strItemNumber.ToString());

        /* Insert the parameter for the update operation on the Item record into the SqlDataSourceItemRecord update parameters
        collection. */
        SqlDataSourceItemsRecord.UpdateParameters.Insert(0, QuantityAvailable);
        SqlDataSourceItemsRecord.UpdateParameters.Insert(1, ItemNumber);

        /* Execute the update command on the Item table to decrement the quantity available of the selected item. */
        SqlDataSourceItemsRecord.Update();

        //Create insert parameters for inserting record into the ItemsOrdered table for the item being added to the cart.
        Parameter parOrderNumberParameter = new Parameter("OrderNumber", (TypeCode)TYPE_CODE_INTEGER, Session["CustomerOrderNumber"].ToString());
        Parameter parItemNumberParameter = new Parameter("ItemNumber", (TypeCode)TYPE_CODE_STRING, (string)GridView1.SelectedValue);
        Parameter parQtyReqParameter = new Parameter("QuantityRequested", (TypeCode)TYPE_CODE_INTEGER, txtQuantityRequested.Text);

        //Add parameters for inserting ItemsOrdered record into ItemsOrdered table to InsertParameters collection of SqlDataSourceItemsOrderedRecord.
        SqlDataSourceItemsOrderedRecord.InsertParameters.Insert(0, parOrderNumberParameter);
        SqlDataSourceItemsOrderedRecord.InsertParameters.Insert(1, parItemNumberParameter);
        SqlDataSourceItemsOrderedRecord.InsertParameters.Insert(2, parQtyReqParameter);

        /* Perform insert operation using the InsertCommand SQL string and the
         * parameters that were added to the InsertParameters collection. */
        SqlDataSourceItemsOrderedRecord.Insert();

        //NewOrder session variable does not always hold its value.  A new order should not be created when user adds next item to cart.
        Session["NewOrder"] = false;

        /* Take the user to the ViewCart.aspx page so they can see the product/products
         * they have added to their cart and manage their cart. */
        Response.Redirect("ViewCart.aspx");
    }   //end btnAddToCart_Click
}   //end class View_Products