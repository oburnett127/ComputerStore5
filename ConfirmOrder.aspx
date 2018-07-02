<%@ Page Title="Confirm Order" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ConfirmOrder.aspx.cs" Inherits="ConfirmOrder" %>

<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content1" runat="server" contentplaceholderid="cpMainContent">
    <asp:Label ID="Label1" runat="server" CssClass="Title" Text="Confirm Order"></asp:Label> <br /><br />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" TabIndex="1"
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ItemNumber" 
        DataSourceID="SqlDataSourceGridViewPopulator" CssClass="InformationTextCalibri">
        <AlternatingRowStyle CssClass="AlternatingRow" />
        <SelectedRowStyle CssClass="SelectedItem" />
        <Columns>
            <asp:BoundField DataField="ItemName" HeaderText="ItemName" 
                SortExpression="ItemName" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="QuantityRequested" HeaderText="Quantity Req." SortExpression="Quantity" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemNumber" HeaderText="Item Number" 
                SortExpression="ItemNumber" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemWeight" HeaderText="Item Weight" SortExpression="ItemWeight">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Item Subtotal" SortExpression="ItemSubtotal">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Item Tax" SortExpression="ItemTax">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Item Shipping" SortExpression="ItemShipping">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Item Total" SortExpression="ItemTotal">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <asp:Label ID="lblNoItems" runat="server" CssClass="InstructionText" Text="There are no items in your order.
                Click the Return to Product View button to view our products and add products to your cart."></asp:Label>
        </EmptyDataTemplate>
    </asp:GridView> <br />

     <asp:SqlDataSource ID="SqlDataSourceGridViewPopulator" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT Item.ItemName, ItemsOrdered.QuantityRequested, Item.Price, Item.ItemNumber, Item.ItemWeight, Item.QuantityAvailable FROM Item INNER JOIN ItemsOrdered ON Item.ItemNumber = ItemsOrdered.ItemNumber WHERE (ItemsOrdered.OrderNumber = @OrderNumber)">
        <SelectParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Label ID="Label2" runat="server" CssClass="InformationTextBoldCalibri" Text="Order Totals"></asp:Label> <br /><br />
    <asp:Label ID="Label3" runat="server" CssClass="InformationTextCalibri" Text="Order Subtotal: "></asp:Label>
    <asp:Label ID="lblOrderSubtotal" runat="server" CssClass="InformationTextCalibri" Text="$0.00"></asp:Label> <br /><br />
    <asp:Label ID="Label4" runat="server" CssClass="InformationTextCalibri" Text="Order Total Tax: "></asp:Label>
    <asp:Label ID="lblOrderTaxTotal" runat="server" CssClass="InformationTextCalibri" Text="$0.00"></asp:Label> <br /><br />
    <asp:Label ID="Label5" runat="server" CssClass="InformationTextCalibri" Text="Order Total Shipping Charge: "></asp:Label>
    <asp:Label ID="lblOrderShippingChargeTotal" runat="server" CssClass="InformationTextCalibri" Text="$0.00"></asp:Label> <br /><br />
    <asp:Label ID="Label6" runat="server" CssClass="InformationTextCalibri" Text="Order Grand Total: "></asp:Label>
    <asp:Label ID="lblOrderGrandTotal" runat="server" CssClass="InformationTextCalibri" Text="$0.00"></asp:Label> <br /><br />

    <asp:Button ID="btnReturnToProductView" runat="server" Text="Return to Product View" PostBackUrl="ViewProducts.aspx"
        ToolTip="Click this button to return to Product View and browse for products." TabIndex="1" CssClass="MyButton" /> &nbsp&nbsp&nbsp&nbsp&nbsp

    &nbsp&nbsp&nbsp&nbsp&nbsp

    <asp:Button ID="btnProceedToPayment" runat="server" Text="Proceed to Payment" PostBackUrl="Checkout.aspx"
        ToolTip="Click this button to proceed to payment." TabIndex="3" 
        onclick="btnProceedToPayment_Click" />
</asp:Content>