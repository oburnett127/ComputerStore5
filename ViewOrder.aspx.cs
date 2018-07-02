/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "ViewOrder.aspx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewOrder : BasePage
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
    const double TAX_RATE = 0.08;           //The sales tax rate.
    const double SHIPPING_RATE = .5;        /* The shipping charge is fifty cents per pound. See calculate_Item_Shipping for
                                             * more information. */


    /* Member data. */
    
    private double dblItemPrice;                     /* Price of each instance of an item in the current row in the GridView
                                                      * which represents the user's shopping cart. */
    private double dblItemSubtotal;                  /* The amount of money to be paid for the purchase of quantityRequested number
                                                      * of instances of the item in the current row of the GridView shopping cart. */
    private double dblItemTaxTotal;                  /* Total amount of tax to pay for all instances of a type of item. */
    private double dblItemTotalShipping;             /* Total amount of money to pay in shipping for all instances of a type of item. */
    private double dblOrderSubtotal;                 /* Subtotal for all instances of items in cart before tax and shipping. */
    private double dblOrderTaxTotal;                     /* Total tax for all items in the order. */
    private double dblOrderShippingTotal;                /* Total shipping charge for all items in the order. */
    
    private int intQuantityRequested;               /* The number of instances the user has placed in their cart of the item in
                                                     * the current row of the GridView. */
    private string strItemPrice;                    /* String to hold price of current item in GridView in string format. */
    private string strItemSubtotal;                 /* String to hold item subtotal for current item. */
    private TableCell tableCellItemPrice;           /* Table Cell of current row which holds price of item. */
    private TableCell tableCellQuantityRequested;   /* Table Cell of current row which holds quantity requested of item. */
    

    /* Member functions. */
    protected ViewOrder()
    {
        dblItemPrice = 0.0;
        dblItemSubtotal = 0.0;
        dblItemTaxTotal = 0.0;
        dblItemTotalShipping = 0.0;
        dblOrderSubtotal = 0.0;
        dblOrderTaxTotal = 0.0;
        dblOrderShippingTotal = 0.0;
        intQuantityRequested = 0;
        strItemPrice = "";
        strItemSubtotal = "";
        tableCellItemPrice = new TableCell();
        tableCellQuantityRequested = new TableCell();   
    }   //end default constructor


    /* Executes when the page is loaded.  Calls the function which computes the item subtotal, tax, and shipping; the order
     * subtotal, tax, and shipping; and the order grand total.  These totals are stored in the GridView control on the
     * ConfirmOrder.aspx page and are placed in label controls on the page. */
    protected void Page_Load(object sender, EventArgs e)
    {
        Calculate_Totals();
        Show_Order_Details();
    }   //end Page_Load


    /* Calculate the total tax paid for all instances of the item represented by row r.
     * @param r, GridViewRow for which the total item tax is to be calculated.
     * @return the total tax for all instances of the item represented by row r. */
    protected void calculate_Item_Tax_Total(GridViewRow r)
    {
        dblItemTaxTotal = dblItemSubtotal * TAX_RATE;     //Calculate the item total tax.
        string strItemTotalTax = dblItemTaxTotal.ToString("C2");      //Convert item tax to string format.
        r.Cells[ITEM_TAX_COLUMN].Text = strItemTotalTax;  //Store total tax for all instances of item in row r.
    }   //end calculate_Item_Tax


    /* Calculate the total paid in shipping for all instances of the item represented by row r. 
     * The shipping charge is fifty cents per pound.  All instances of items weighing less than one pound
     * will have a shipping charge of fifty cents per instance of the item.  An instance of an item with
     * a weight which has a non-zero fraction and is over one pound will be treated as though there were no
     * fraction, that is no additional shipping cost will be added for the fraction of a pound.
     * Examples: Item weight is 0.4 pounds, shipping charge is $0.50 for each instance of the item.
     * Item weight is 1.0 pounds, shipping charge is $0.50 per instance. Item weight is 1.8 pounds,
     * shipping charge is $0.50 per instance. Item weight is 2.0 pounds shipping charge is $1.00 per
     * instance. Item weight is 2.6 pounds, shipping charge is $1.00 per instance.
     * @param r, GridViewRow containing item information including the weight of the quantity
     * of instances of the item for which the shipping charge is being calculated.
     * @return total shipping charge for all instances of item represented by row r. */
    protected void calculate_Item_Shipping_Total(GridViewRow r)
    {
        //Retrieve item instance weight and quantity requested from GridViewRow r
        double dblItemInstanceWeight = Convert.ToDouble(r.Cells[ITEM_WEIGHT_COLUMN].Text); //Cast item weight to double.
        intQuantityRequested = Convert.ToInt32(r.Cells[QTY_REQ_COLUMN].Text);

        //Switch statement cannot be used with double variables.
        if (dblItemInstanceWeight < 1.0)
        {   //Each item instance weighs less than one pound.
            dblItemTotalShipping = intQuantityRequested * SHIPPING_RATE;
        }
        else
        {   //Each item instance weighs one pound or more.
            dblItemTotalShipping = Math.Floor(dblItemInstanceWeight) * SHIPPING_RATE * intQuantityRequested;
        }   //end if
        
        string strItemTotalShipping = dblItemTotalShipping.ToString("C2");    //Convert item shipping to string format.
        r.Cells[ITEM_SHIPPING_COLUMN].Text = strItemTotalShipping;   //Store the shipping charge for all instances of item in row r.
    }   //end calculate_Item_Shipping


    /* Calculate the total amount to be paid by the customer for all instances of the item represented by GridViewRow r before
     * shipping and tax. 
     * @param r, GridViewRow which represents the item for which the item subtotal is being calculated. */
    protected void calculate_Item_Subtotal(GridViewRow r)
    {
        tableCellItemPrice = r.Cells[ITEM_PRICE_COLUMN]; //Get the table cell from current row which stores price of item.
        strItemPrice = tableCellItemPrice.Text;   //Get the string representation of cell contents.
        dblItemPrice = Convert.ToDouble(strItemPrice);  //Convert string representation of cell to double representation.

        intQuantityRequested = Convert.ToInt32(r.Cells[QTY_REQ_COLUMN].Text);    //Convert grid view quantity requested value to integer.

        dblItemSubtotal = dblItemPrice * intQuantityRequested;  //Calculate item subtotal.
        strItemSubtotal = dblItemSubtotal.ToString("C2");    //Convert Item Subtotal to a string.

        r.Cells[ITEM_SUBTOTAL_COLUMN].Text = strItemSubtotal;  //Store item subtotal in grid view
    }   //end calculate_Item_Subtotal


    /* Calculate total paid for all instances of item in GridViewRow r by adding the item subtotal, the item tax, and the
     * item shipping.  Store the item total in the GridView in row r. Instead of accessing the values of the item subtotal,
     * item tax, and item shipping using the GridViewRow parameter r, it requires less time to access the values already stored in
     * dblItemSubtotal, dblItemTaxTotal, and dblItemShipping.
     * @param dblItemSubtotal, the total amount of money to be paid for all instances of the item of row r before shipping and tax.
     * @param dblItemTax, the total amount of tax to be paid for all instances of the item of row r.
     * @param dblItemShipping, the total amount of money to be paid for shipping all instances of item of row r to the customer. */
    protected void calculate_Item_Total(double dblItemSubtotal, double dblItemTaxTotal, double dblItemShipping, GridViewRow r)
    {
        double dblItemTotal = dblItemSubtotal + dblItemTaxTotal + dblItemShipping;   //Calculate item total.
        r.Cells[ITEM_TOTAL_COLUMN].Text = dblItemTotal.ToString("C2");   //Store item total in row r of GridView control.
    }   //end calculate_Item_Total


    /* Computes the item subtotal, tax, and shipping; the order subtotal, tax, and shipping; and the order grand total.
     * These totals are stored in the GridView control on the ConfirmOrder.aspx page and are placed in label controls
     * on the ConfirmOrder.aspx page. */
    protected void Calculate_Totals()
    {
        double dblOrderTotal = 0.0;
        string strOrderSubtotal = "";
        string strOrderTaxTotal = "";
        string strOrderShippingTotal = "";
        string strOrderTotal = "";

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            calculate_Item_Subtotal(GridView1.Rows[i]);         //Calculate the subtotal for the quantity of item in current row.
            calculate_Item_Tax_Total(GridView1.Rows[i]);        //Calculate the tax for the quantity of the item in current row.
            calculate_Item_Shipping_Total(GridView1.Rows[i]);   //Calculate the shipping for the quantity of the item in current row.

            //Calculate total paid for all instances of current item with tax and shipping included.
            calculate_Item_Total(dblItemSubtotal, dblItemTaxTotal, dblItemTotalShipping, GridView1.Rows[i]);

            dblOrderSubtotal = dblOrderSubtotal + dblItemSubtotal;                      //Add ItemSubtotal to CartSubtotal.
            dblOrderTaxTotal = dblOrderTaxTotal + dblItemTaxTotal;                      //Add item tax to the order tax total.
            dblOrderShippingTotal = dblOrderShippingTotal + dblItemTotalShipping;       //Add item shipping to the order shipping total.
        }   //end for

        /* Calculate the order total which is the sum of the order subtotal (sum of price of all instances of items in order), the total tax, and
         * the total shipping. */
        dblOrderTotal = dblOrderSubtotal + dblOrderTaxTotal + dblOrderShippingTotal;

        /* Convert total values to string currency format. */
        strOrderSubtotal = dblOrderSubtotal.ToString("C2");
        strOrderTaxTotal = dblOrderTaxTotal.ToString("C2");
        strOrderShippingTotal = dblOrderShippingTotal.ToString("C2");
        strOrderTotal = dblOrderTotal.ToString("C2");
    }   //end Calculate_Totals


    /* Store order details in text property of labels in TableOrderDetails table for user to see. */
    private void Show_Order_Details()
    {
        /* Retrieve order detail information from sesion variables that were filled on Checkout.aspx and ConfirmOrder.aspx. */
        string strOrderNumber = Convert.ToString(Session["CustomerOrderNumber"]);
        string strDateTimeOrdered = Convert.ToString(Session["DateTimeOrdered"]);
        string strShippingAddress = Convert.ToString(Session["CustomerStreetAddress"]);
        string strCustomerName = Convert.ToString(Session["CustomerFirstName"]) + " " + Convert.ToString(Session["CustomerLastName"]);
        string strCardNumber = Convert.ToString(Session["CustomerCardNumber"]);
        string strOrderSubtotal = Convert.ToString(Session["OrderSubtotal"]);
        string strOrderTaxTotal = Convert.ToString(Session["OrderTaxTotal"]);
        string strOrderShippingChargeTotal = Convert.ToString(Session["OrderShippingTotal"]);
        string strOrderGrandTotal = Convert.ToString(Session["OrderTotal"]);

        /* Store Order detail text information in labels in the TableOrderDetails table for the user to see. */
        lblOrderNumber.Text = strOrderNumber;
        lblDateOrdered.Text =  strDateTimeOrdered;
        lblShippingAddress.Text = strShippingAddress;
        lblCustomerName.Text = strCustomerName;
        lblCardNumber.Text = strCardNumber;
        lblOrderSubtotal.Text = strOrderSubtotal;
        lblOrderTaxTotal.Text = strOrderTaxTotal;
        lblOrderShippingChargeTotal.Text = strOrderShippingChargeTotal;
        lblOrderGrandTotal.Text = strOrderGrandTotal;
    }   //end Show_Order_Details


    //Transfer user to home page.
    protected void btnReturnHome_Click(object sender, EventArgs e)
    {
        Server.Transfer("~/Default.aspx");
    }   //end btnReturnHome_Click


    //Transfer user to ViewProducts.aspx so they can place another order or browse products.
    protected void btnViewProducts_Click(object sender, EventArgs e)
    {
        Server.Transfer("~/ViewProducts.aspx");
    }   //end btnViewProducts_Click
}   //end class ViewOrder
