/*
 * Name: Owen Burnett
 * Course: Advanced Visual Programming CMSC 3413, MW 2:45 - 4:00pm
 * Semester: Spring 2012
 * Due: April 29, 2012
 * File name: "ConfirmOrder.aspx.cs"
 * Assignment: Final Project
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ConfirmOrder : BasePage
{
    const int ITEM_NAME_COLUMN = 0;         
    const int QTY_REQ_COLUMN = 1;           
    const int ITEM_PRICE_COLUMN = 2;        
    const int ITEM_NUM_COLUMN = 3;          
    const int ITEM_WEIGHT_COLUMN = 4;       
    const int ITEM_SUBTOTAL_COLUMN = 5;     
    const int ITEM_TAX_COLUMN = 6;          
    const int ITEM_SHIPPING_COLUMN = 7;     
    const int ITEM_TOTAL_COLUMN = 8;        
    const double TAX_RATE = 0.08;           
    const double SHIPPING_RATE = .5;

    /* Member data. */  
    private double dblItemPrice;     /* Price of each instance of an item in the
                                      * current row in the GridView which represents
                                      * the user's shopping cart. */
    private double dblItemSubtotal;  /* The amount of money to be paid
                                      * for the purchase of quantityRequested number
                                      * of instances of the item in the current row of
                                      * the GridView shopping cart. */
    private double dblItemTaxTotal;       /* Total amount of tax to pay for all
                                           * instances of a type of item. */
    private double dblItemTotalShipping;  /* Total amount of money to pay in shipping
                                           * for all instances of a type of item. */
    private double dblOrderSubtotal;      /* Subtotal for all instances of items in
                                           * cart before tax and shipping. */
    private double dblOrderTaxTotal;      /* Total tax for all items in the order. */
    private double dblOrderShippingTotal; /* Total shipping charge for all items in
                                           * the order. */
    
    private int intQuantityRequested;     /* The number of instances the user has
                                           * placed in their cart of the item in
                                           * the current row of the GridView. */
    private string strItemPrice;          /* String to hold price of current item
                                           * in GridView in string format. */
    private string strItemSubtotal;       // String to hold item subtotal for current item.
    private TableCell tableCellItemPrice; /* Table Cell of current row which holds price of
                                           * item. */
    private TableCell tableCellQuantityRequested; /* Table Cell of current row which
                                                   * holds quantity requested of item. */
    
    /* Member functions. */
    protected ConfirmOrder()
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

    /* Executes when the page is loaded.  Calls the function which computes the item
     * subtotal, tax, and shipping; the order subtotal, tax, and shipping; and the
     * order grand total.  These totals are stored in the GridView control on the
     * ConfirmOrder.aspx page and are placed in label controls on the page. */
    protected void Page_Load(object sender, EventArgs e)
    {
        Calculate_Totals();
    }   //end Page_Load


    /* Calculate the total tax paid for all instances of the item represented by row r.
     * @param r, GridViewRow for which the total item tax is to be calculated.
     * @return the total tax for all instances of the item represented by row r. */
    protected void calculate_Item_Tax_Total(GridViewRow r)
    {
        dblItemTaxTotal = dblItemSubtotal * TAX_RATE; //Calculate the item total tax.
        string strItemTotalTax = dblItemTaxTotal.ToString("C2"); /* Convert item tax
                                                                   to string format. */
        r.Cells[ITEM_TAX_COLUMN].Text = strItemTotalTax;  /* Store total tax for all
                                                          instances of item in row r. */
    }   //end calculate_Item_Tax


    /* Calculate the total paid in shipping for all instances of the item represented
     * by row r. The shipping charge is fifty cents per pound.  All instances of items
     * weighing less than one pound will have a shipping charge of fifty cents per
     * instance of the item.  An instance of an item with a weight which has a
     * non-zero fraction and is over one pound will be treated as though there were no
     * fraction, that is no additional shipping cost will be added for the fraction
     * of a pound.
     * @param r, GridViewRow containing item information including the weight of the
     * quantity of instances of the item for which the shipping charge is being calculated.
     * @return total shipping charge for all instances of item represented by row r. */
    protected void calculate_Item_Shipping_Total(GridViewRow r)
    {
        //Retrieve item instance weight and quantity requested from GridViewRow r
        double dblItemInstanceWeight = Convert.ToDouble(r.Cells[ITEM_WEIGHT_COLUMN].Text);
        intQuantityRequested = Convert.ToInt32(r.Cells[QTY_REQ_COLUMN].Text);

        //Switch statement cannot be used with double variables.
        if (dblItemInstanceWeight < 1.0)
        {   //Each item instance weighs less than one pound.
            dblItemTotalShipping = intQuantityRequested * SHIPPING_RATE;
        }
        else
        {   //Each item instance weighs one pound or more.
            dblItemTotalShipping = Math.Floor(dblItemInstanceWeight) * SHIPPING_RATE
                * intQuantityRequested;
        }   //end if

        string strItemTotalShipping = dblItemTotalShipping.ToString("C2");

        //Store the shipping charge for all instances of item in row r.
        r.Cells[ITEM_SHIPPING_COLUMN].Text = strItemTotalShipping;
    }   //end calculate_Item_Shipping

    /* Calculate the total amount to be paid by the customer for all instances
     * of the item represented by GridViewRow r before shipping and tax. 
     * @param r, GridViewRow which represents the item for which the item
     * subtotal is being calculated. */
    protected void calculate_Item_Subtotal(GridViewRow r)
    {
        tableCellItemPrice = r.Cells[ITEM_PRICE_COLUMN];
        strItemPrice = tableCellItemPrice.Text;
        dblItemPrice = Convert.ToDouble(strItemPrice);

        intQuantityRequested = Convert.ToInt32(r.Cells[QTY_REQ_COLUMN].Text);

        //Calculate item subtotal.
        dblItemSubtotal = dblItemPrice * intQuantityRequested;  
        strItemSubtotal = dblItemSubtotal.ToString("C2"); /* Convert item
           * subtotal to currency format */

        r.Cells[ITEM_SUBTOTAL_COLUMN].Text = strItemSubtotal;
    }   //end calculate_Item_Subtotal


    /* Calculate total paid for all instances of item in GridViewRow r by adding
     * the item subtotal, the item tax, and the item shipping. Store the item
     * total in the GridView in row r. Instead of accessing the values of the
     * item subtotal, item tax, and item shipping using the GridViewRow parameter
     * r, it requires less time to access the values already stored in
     * dblItemSubtotal, dblItemTaxTotal, and dblItemShipping.
     * @param dblItemSubtotal, the total amount of money to be paid for
     * all instances of the item of row r before shipping and tax.
     * @param dblItemTax, the total amount of tax to be paid for all
     * instances of the item of row r.
     * @param dblItemShipping, the total amount of money to be paid for
     * shipping all instances of item of row r to the customer. */
    protected void calculate_Item_Total(double dblItemSubtotal, double dblItemTaxTotal,
        double dblItemShipping, GridViewRow r)
    {
        double dblItemTotal = dblItemSubtotal + dblItemTaxTotal + dblItemShipping;
        r.Cells[ITEM_TOTAL_COLUMN].Text = dblItemTotal.ToString("C2");
    }   //end calculate_Item_Total


    /* Computes the item subtotal, tax, and shipping; the order subtotal, tax,
     * and shipping; and the order grand total. These totals are stored in the
     * GridView control on the ConfirmOrder.aspx page and are placed in label controls
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
            calculate_Item_Subtotal(GridView1.Rows[i]); /* Calculate subtotal for
                                                   * quantity of item in current row. */
            calculate_Item_Tax_Total(GridView1.Rows[i]); /* Calculate tax for the
                                                   * quantity of item in current row. */
            calculate_Item_Shipping_Total(GridView1.Rows[i]); /* Calculate the shipping
                                       * for the quantity of the item in current row. */

            /* Calculate total paid for all instances of current item with tax and
            shipping included. */
            calculate_Item_Total(dblItemSubtotal, dblItemTaxTotal, dblItemTotalShipping,
                GridView1.Rows[i]);

            dblOrderSubtotal = dblOrderSubtotal + dblItemSubtotal;
            dblOrderTaxTotal = dblOrderTaxTotal + dblItemTaxTotal;
            dblOrderShippingTotal = dblOrderShippingTotal + dblItemTotalShipping;
        }   //end for

        /* Calculate the order total which is the sum of the order subtotal
         * (sum of price of all instances of items in order), the total tax, and
         * the total shipping. */
        dblOrderTotal = dblOrderSubtotal + dblOrderTaxTotal + dblOrderShippingTotal;

        /* Convert total values to string currency format. */
        strOrderSubtotal = dblOrderSubtotal.ToString("C2");
        strOrderTaxTotal = dblOrderTaxTotal.ToString("C2");
        strOrderShippingTotal = dblOrderShippingTotal.ToString("C2");
        strOrderTotal = dblOrderTotal.ToString("C2");

        /* Store currency formatted string totals in labels for the user to see. */
        lblOrderSubtotal.Text = strOrderSubtotal;
        lblOrderTaxTotal.Text = strOrderTaxTotal;
        lblOrderShippingChargeTotal.Text = strOrderShippingTotal;
        lblOrderGrandTotal.Text = strOrderTotal;

        /* Store currency formatted string totals in session variables to be
         * used on ViewOrder.aspx page. */
        Session["OrderSubtotal"] = strOrderSubtotal;
        Session["OrderTaxTotal"] = strOrderTaxTotal;
        Session["OrderShippingTotal"] = strOrderShippingTotal;
        Session["OrderTotal"] = strOrderTotal;
    }   //end Calculate_Totals


    /* Transfer the user to the Checkout.aspx page so they can pay for their order. */
    protected void btnProceedToPayment_Click(object sender, EventArgs e)
    {
        Server.Transfer("Checkout.aspx");
    }   //end btnProceedToPayment_Click
}   //end class ConfirmOrder