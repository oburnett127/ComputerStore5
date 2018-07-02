/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "ViewCart.aspx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewCart : BasePage
{
    /* These constants help with column indexing in the GridView control. Index 0 is
     * for the select button command field. */
    const int ITEM_NAME_COLUMN = 1; //Index of item name column in grid view control.
    const int QTY_REQ_COLUMN = 2;   //Index of quantity requested column in grid view control.
    const int ITEM_PRICE_COLUMN = 3; //Index of price column in grid view control.
    const int ITEM_NUM_COLUMN = 4;   //Index of item number column in grid view control.
    const int ITEM_SUBTOTAL_COLUMN = 5; //Index of item subtotal column in grid view control.
    const int QTY_AVAILABLE_COLUMN = 6; //Index of qty available column in grid view control.
    
    
    /* Member data. */
    private double dblCartSubtotal; /* Subtotal for all instances of items in cart before
       * tax and shipping. */
    private double dblItemPrice; /* Price of each instance of an item in the current row
       * in the GridView which represents the user's shopping cart. */
    private int intQuantityRequested; /* The number of instances the user has placed in their
       * cart of the item in the current row of the GridView. */
    private double dblItemSubtotal;  /* The amount of money to be paid for purchase of
       * quantityRequested number of instances of item in current row of the GridView shopping
       * cart. */
    private string strItemPrice;
    private string strQuantityRequested;
    private string strItemSubtotal;
    private TableCell tableCellItemPrice;
    private TableCell tableCellQuantityRequested;
    private string strItemNumber;  // Stores item number of record or row being processed.
    private string strOrderNumber; //Stores order number for customer's current order.
    int intQuantityAvailable;      /* To store the new quantity available after the item is
                                     * removed from the cart. */

    /* Member functions. */
    protected ViewCart()
    {
        dblCartSubtotal = 0.0;
        dblItemPrice = 0.0;
        intQuantityRequested = 0;
        dblItemSubtotal = 0.0;
        strItemPrice = "";
        strQuantityRequested = "";
        strItemSubtotal = "";
        tableCellItemPrice = new TableCell();
        tableCellQuantityRequested = new TableCell();
    }   //end default constructor

    /* Executed each time the page is loaded.  Calls function which calculates and displays
     * the item subtotal for each item in the cart and calculates and displays the cart subtotal. */
    protected void Page_Load(object sender, EventArgs e)
    {
        Calculate_Totals();
    }   //end Page_Load


    protected void calculate_Item_Subtotal(GridViewRow r)
    {
        dblItemSubtotal = 0.0;
        strItemSubtotal = "";

        tableCellItemPrice = r.Cells[ITEM_PRICE_COLUMN];
        strItemPrice = tableCellItemPrice.Text;
        dblItemPrice = Convert.ToDouble(strItemPrice);

        tableCellQuantityRequested = r.Cells[QTY_REQ_COLUMN];
        strQuantityRequested = tableCellQuantityRequested.Text;
        intQuantityRequested = Convert.ToInt32(strQuantityRequested);

        dblItemSubtotal = dblItemPrice * intQuantityRequested;  //Calculate item subtotal.
        strItemSubtotal = dblItemSubtotal.ToString("C2");

        r.Cells[ITEM_SUBTOTAL_COLUMN].Text = strItemSubtotal;
    }   //end calculate_Item_Subtotal


    /* Remove the selected item in the GridView from the cart by removing the associated
     * record from the ItemsOrdered table based on the ItemNumber and OrderNumber.
     * Invoking Server.Transfer causes the ViewCart.aspx page to be re-built and eventually
     * Page_Load executes and Calculate_Totals is called which leads to the calculating
     * and displaying of the new cart subtotal. */
    protected void  btnRemoveFromCart_Click(object sender, EventArgs e)
    {
        strItemNumber = GridView1.SelectedValue.ToString();
        strOrderNumber = Session["CustomerOrderNumber"].ToString();

        /* Create parameters for removing the record from the ItemsOrdered table. */
        Parameter parItemNumber = new Parameter("ItemNumber", TypeCode.String, strItemNumber);
        Parameter parOrderNumber = new Parameter("OrderNumber", TypeCode.Int32, strOrderNumber);

        //Insert parameters into DeleteParameters collection.
        SqlDataSourceCart.DeleteParameters.Insert(0, parItemNumber);
        SqlDataSourceCart.DeleteParameters.Insert(1, parOrderNumber);

        //Remove the selected item from the cart by removing record from ItemsOrdered table.
        SqlDataSourceCart.Delete();

        /* Get quantity of item to be returned to stock, item number of the item, and
         * quantity available before the return to stock. */
        intQuantityRequested = Convert.ToInt32(
            GridView1.SelectedRow.Cells[QTY_REQ_COLUMN].Text);
        strItemNumber = GridView1.SelectedRow.Cells[ITEM_NUM_COLUMN].Text;
        intQuantityAvailable = Convert.ToInt32(
            GridView1.SelectedRow.Cells[QTY_AVAILABLE_COLUMN].Text);

        /* The new quantity of the item available in stock is the quantity before the item
         * is returned added to the number of item instances returned to stock. */
        intQuantityAvailable = intQuantityAvailable + intQuantityRequested;

        // Create parameter for update command on Item table for updating item qty available.
        Parameter parQuantityAvailable = new Parameter(
            "QuantityAvailable", TypeCode.Int32, Convert.ToString(intQuantityAvailable));

        /* Insert the parameters for the update command on the item table to the update
         * parameters collection of data source. */
        SqlDataSourceItems.UpdateParameters.Insert(0, parQuantityAvailable);
        SqlDataSourceItems.UpdateParameters.Insert(0, parItemNumber);

        //Execute the update command on the Item table.  Quantity available should be updated.
        SqlDataSourceItems.Update();

        //A new order should not be created when user adds next item to cart.
        Session["NewOrder"] = false;

        //Re-build and load ViewCart.aspx so that new cart subtotal is displayed.
        Server.Transfer("ViewCart.aspx");
    }   //end btnRemoveFromCart_Click


    /* Update the record for the item selected and the current order number in
     * the GridView in the ViewCart.aspx page in the ItemsOrdered table with
     * the number the user entered in the txtNewQuantityRequest text box. */
    protected void  btnChangeQuantityRequest_Click(object sender, EventArgs e)
    {
        strItemNumber = GridView1.SelectedValue.ToString(); //Item number to change qty for.
        strOrderNumber = Session["CustomerOrderNumber"].ToString(); //Customer's order number.
        string strNewQuantityRequested = txtNewQuantityRequest.Text;
        int intOldQuantityAvailable = Convert.ToInt32(
            GridView1.SelectedRow.Cells[QTY_AVAILABLE_COLUMN].Text);

        //Get quantity of item to be returned to stock and old quantity requested.
        int intOldQuantityRequested = Convert.ToInt32(
            GridView1.SelectedRow.Cells[QTY_REQ_COLUMN].Text);
        int intQuantityToReturn = intOldQuantityRequested - Convert.ToInt32(
            strNewQuantityRequested);

        /* The new quantity of the item available in stock is the quantity
         * before the item is returned added to the number of item instances returned to stock. */
        intQuantityAvailable = intOldQuantityAvailable + intQuantityToReturn;

        //Create parameters for update command for updating quantity requested in ItemsOrdered.
        Parameter NewQuantityRequested = new Parameter(
            "NewQuantityRequested", TypeCode.Int32, strNewQuantityRequested);
        Parameter ItemNumber = new Parameter("ItemNumber", TypeCode.String, strItemNumber);
        Parameter OrderNumber = new Parameter("OrderNumber", TypeCode.Int32, strOrderNumber);

        /* Insert the parameters for update command into collection of update parameters. */
        SqlDataSourceCart.UpdateParameters.Insert(0, NewQuantityRequested);
        SqlDataSourceCart.UpdateParameters.Insert(1, ItemNumber);
        SqlDataSourceCart.UpdateParameters.Insert(2, OrderNumber);

        // Run update command and modify selected GridView record in ItemsOrdered table
        SqlDataSourceCart.Update();

        //Create parameter for update command on Item table for updating item qty available.
        Parameter parQuantityAvailable = new Parameter(
            "QuantityAvailable", TypeCode.Int32, Convert.ToString(intQuantityAvailable));

        /* Insert the parameters for the update command on the item table to the update
         * parameters collection of data source. */
        SqlDataSourceItems.UpdateParameters.Insert(0, parQuantityAvailable);
        SqlDataSourceItems.UpdateParameters.Insert(0, ItemNumber);

        //Execute the update command on the Item table.  Quantity available should be updated.
        SqlDataSourceItems.Update();

        //A new order should not be created when user adds next item to cart.
        Session["NewOrder"] = false;

        /* When the quantity requested of an item in the customer's cart is changed, this
         * changes the item subtotal as well as the cart subtotal.  The totals must be
         * re-calculated, the new item subtotal needs to be displayed in the item subtotal
         * column of the row selected in the grid view control, and the new cart subtotal needs
         * to be displayed in the label for the cart subtotal. Invoking Server.Transfer
         * causes the page life cycle for this same page to start over, eventually Page_Load
         * executes and Calculate_Totals is called which leads to the re-populating of the
         * GridView control containing the new item subtotal and cart subtotal.*/
        Server.Transfer("ViewCart.aspx");
    }   //end btnChangeQuantityRequest_Click


    /* For each row in the GridView1 control (for each type of item in the shopping cart,
     * as opposed to each instance of a type of item) get the item price and the quantity
     * requested for that type of item, calculate the item subtotal (the total amount to
     * be paid for the type of item), store the item subtotal in the item subtotal column
     * in the GridView. Calculate the cart subtotal and display in label. */
    protected void Calculate_Totals()
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            calculate_Item_Subtotal(GridView1.Rows[i]); /* Calculate total for all instances
                                                         * of item before shipping and tax. */
            dblCartSubtotal = dblCartSubtotal + dblItemSubtotal; /* Add item subtotal to total
                                                    * for all items in cart, cart subtotal. */
            lblCartSubtotal.Text = dblCartSubtotal.ToString("C2");  /* Display the new shopping
                                                           cart subtotal in currency format */
        }   //end for
    }   //end Calculate_Totals
}   //end class ViewCart