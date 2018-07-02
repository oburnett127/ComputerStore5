<%@ Page Title="View Order" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/MasterPage.master" CodeFile="ViewOrder.aspx.cs" Inherits="ViewOrder" %>

<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content1" runat="server" contentplaceholderid="cpMainContent"> <br /><br />
    <asp:Label ID="lblThankYouLabel" runat="server"
         Text="Thank you for your order!  Your order has been completed.  We will be shipping your order soon." CssClass="InformationTextBoldCalibri">
    </asp:Label> <br /><br />

    <asp:Label ID="lblLogoutNotice" runat="server" CssClass="NoticeText"
        Text="NOTE: Please log out of the system if you are done placing orders to help keep your financial information and any other information that can be
            used to identify you secure.  Please close your browser when you are ready to leave the website.">
    </asp:Label> <br /><br />

    <asp:Label ID="Label98" runat="server" CssClass="InformationTextBoldCalibri UnderlinedText" Text="Order Details" /><br /><br />
    
    <asp:Label ID="Label1" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Order Number: " /><br />
    <asp:Label ID="lblOrderNumber" runat="server" DefaultText="Sample text" CssClass="InformationTextCalibri WideLabel" Visible="true" /><br /><br />
    <asp:Label ID="Label2" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Date and Time Ordered: " /><br />
    <asp:Label ID="lblDateOrdered" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" /><br /><br />
    <asp:Label ID="Label3" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Shipping Address: " /><br />
    <asp:Label ID="lblShippingAddress" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" /><br /><br />
    <asp:Label ID="Label4" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Customer Name: " /><br />
    <asp:Label ID="lblCustomerName" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" /><br /><br />
    <asp:Label ID="Label5" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Card Number: " /><br />
    <asp:Label ID="lblCardNumber" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" /><br /><br />
    <asp:Label ID="Label6" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Order Subtotal: " /><br />
    <asp:Label ID="lblOrderSubtotal" runat="server" CssClass="InformationTextCalibri  WideLabel" /><br /><br />
    <asp:Label ID="Label7" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Order Tax Total: " /><br />
    <asp:Label ID="lblOrderTaxTotal" runat="server" CssClass="InformationTextCalibri WideLabel" /><br /><br />
    <asp:Label ID="Label8" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Order Shipping Total: " /><br />
    <asp:Label ID="lblOrderShippingChargeTotal" runat="server" CssClass="InformationTextCalibri WideLabel" /><br /><br />
    <asp:Label ID="Label9" runat="server" CssClass="InformationTextCalibri WideLabel" Visible="true" Text="Order Grand Total: " /><br />
    <asp:Label ID="lblOrderGrandTotal" CssClass="InformationTextCalibri WideLabel" runat="server"  /><br /><br /><br /><br />


    <asp:Label ID="Label99" runat="server" CssClass="InformationTextBoldCalibri UnderlinedText" Text="Order Items Details" /> <br />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" TabIndex="1"
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ItemNumber" 
        DataSourceID="SqlDataSourceGridViewPopulator" CssClass="InformationTextCalibri" ToolTip="Information about the items in your order.">
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
            <asp:BoundField Visible="false" DataField="QuantityAvailable" HeaderText="Quantity Available" SortExpression="QuantityAvailable">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
        </Columns>
    </asp:GridView> <br />

     <asp:SqlDataSource ID="SqlDataSourceGridViewPopulator" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT Item.ItemName, ItemsOrdered.QuantityRequested, Item.Price, Item.ItemNumber, Item.ItemWeight FROM Item INNER JOIN ItemsOrdered ON Item.ItemNumber = ItemsOrdered.ItemNumber WHERE (ItemsOrdered.OrderNumber = @OrderNumber)">
        <SelectParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Button ID="btnReturnHome" runat="server" Text="Return to Home Page" PostBackUrl="~/Default.aspx"
        ToolTip="Click this button to return to the home page." TabIndex="4" 
        onclick="btnReturnHome_Click" /> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp

    <asp:Button ID="btnViewProducts" runat="server" Text="Place an Additional Order" PostBackUrl="~/ViewProducts.aspx"
        ToolTip="Click this button if you would like to place another order." TabIndex="3" />
</asp:Content>