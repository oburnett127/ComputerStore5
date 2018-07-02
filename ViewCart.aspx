<%@ Page Title="View Cart" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ViewCart.aspx.cs" Inherits="ViewCart" %>

<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content1" runat="server" contentplaceholderid="cpMainContent">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" TabIndex="1"
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ItemNumber" 
        DataSourceID="SqlDataSourceCart" CssClass="InformationTextCalibri">
        <AlternatingRowStyle CssClass="AlternatingRow" />
        <SelectedRowStyle CssClass="SelectedItem" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" ButtonType="Button">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:CommandField>
            <asp:BoundField DataField="ItemName" HeaderText="ItemName" 
                SortExpression="ItemName">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="QuantityRequested" HeaderText="Qty Requested" SortExpression="Quantity">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemNumber" HeaderText="Item Number" 
                SortExpression="ItemNumber">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Item Subtotal">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField  DataField="QuantityAvailable" HeaderText="Qty Available" SortExpression="QuantityAvailable">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            There are no items in your shopping cart.
        </EmptyDataTemplate>
    </asp:GridView> <br />

    <asp:label ID="Label1" runat="server" CssClass="InformationTextCalibri" 
        text="Change the quantity of the selected item by entering a number in the text box below." /> <br /><br />

    <asp:TextBox ID="txtNewQuantityRequest" runat="server" CssClass="QuantityTextbox"
        ToolTip="Change the quantity of the selected item here."></asp:TextBox> &nbsp&nbsp&nbsp&nbsp&nbsp

    <asp:Button ID="btnChangeQuantityRequest" runat="server" 
        Text="Change Item Quantity" onclick="btnChangeQuantityRequest_Click" CausesValidation="true"
        CssClass="MyButton" /> &nbsp&nbsp&nbsp&nbsp&nbsp

    <asp:Button ID="btnRemoveFromCart" runat="server" Text="Remove from Cart" Tooltip="Remove the selected item from your shopping cart."
        CausesValidation="true" onclick="btnRemoveFromCart_Click" CssClass="MyButton" /> 
        
    <br /><br />

    <asp:Label ID="Label2" runat="server" CssClass="InformationTextCalibri" Text="Shopping Cart Subtotal: " ></asp:Label>

    <asp:Label ID="lblCartSubtotal" runat="server" CssClass="InformationTextCalibri" Text="$0.00"></asp:Label> <br /><br />

    <asp:Button ID="btnReturnToProductView" runat="server" Text="Return to Product View"
        PostBackUrl="ViewProducts.aspx" ToolTip="Click this button to return to Product View to browse for products." 
        TabIndex="3" CssClass="MyButton" /> &nbsp&nbsp&nbsp&nbsp&nbsp

    <asp:Button ID="btnProceedToCheckout" runat="server" Text="Proceed to Checkout" PostBackUrl="~/ConfirmOrder.aspx"
        ToolTip="Click this button to proceed to checkout." TabIndex="4" CssClass="MyButton" />

    <asp:SqlDataSource ID="SqlDataSourceCart" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT Item.ItemName, ItemsOrdered.QuantityRequested, Item.Price, Item.ItemNumber, Item.QuantityAvailable FROM Item INNER JOIN ItemsOrdered ON Item.ItemNumber = ItemsOrdered.ItemNumber WHERE (ItemsOrdered.OrderNumber = @OrderNumber)"
        UpdateCommand="UPDATE ItemsOrdered SET QuantityRequested = @NewQuantityRequested WHERE ItemNumber = @ItemNumber AND OrderNumber = @OrderNumber"
        DeleteCommand="DELETE FROM ItemsOrdered WHERE ItemNumber = @ItemNumber AND OrderNumber = @OrderNumber">
        <SelectParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItems" runat="server" 
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        UpdateCommand="UPDATE Item SET QuantityAvailable = @QuantityAvailable WHERE ItemNumber = @ItemNumber">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItemsOrdered" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        DeleteCommand="DELETE FROM ItemsOrdered WHERE OrderNumber = @OrderNumber">
        <DeleteParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceOrders" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        DeleteCommand="DELETE FROM Orders WHERE OrderNumber = @OrderNumber">
        <DeleteParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource> <br />
</asp:Content>