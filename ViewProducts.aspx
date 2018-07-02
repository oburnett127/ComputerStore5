<%@ Page Title="View Products"  Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ViewProducts.aspx.cs" Inherits="View_Products" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="cpMainContent">
    <asp:GridView ID="GridView1" runat="server" TabIndex="1" 
        AutoGenerateSelectButton="True" AllowPaging="True"
        AllowSorting="True" SelectedRowStyle-CssClass="SelectedItem" 
        GridLines="Horizontal" AutoGenerateColumns="False"
        DataKeyNames="ItemNumber" DataSourceID="SqlDataSourceItemsOrderedRecord"
        EmptyDataText="The list of products cannot be displayed at this time, because there is a technical
        problem with our website.  We are working to resolve the issue as quickly as possible and we
        apologize for the inconvenience.  Please check this page again soon.">
        <AlternatingRowStyle CssClass="AlternatingRow" />
        <SelectedRowStyle CssClass="SelectedItem"></SelectedRowStyle>
        <Columns>
            <asp:BoundField DataField="ItemName" HeaderText="Item Name" 
                SortExpression="ItemName">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="QuantityAvailable" HeaderText="Quantity Available" 
                SortExpression="QuantityAvailable" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" 
                SortExpression="Price" DataFormatString="{0:C}" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemDescription" HeaderText="Item Description" 
                SortExpression="ItemDescription" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:ImageField AlternateText="No picture available." 
                DataImageUrlField="ImageUrl" HeaderText="Product Picture" 
                NullDisplayText="The picture for this product cannot currently be displayed." 
                ReadOnly="True" ItemStyle-CssClass="ProductImage">
                <ControlStyle CssClass="ProductImage" />
                <HeaderStyle CssClass="GridViewHeaderStyle" />
                <ItemStyle CssClass="ProductImage"></ItemStyle>
            </asp:ImageField>
            <asp:BoundField DataField="ItemNumber" HeaderText="Item Number" 
                SortExpression="ItemNumber" ReadOnly="True" >
            <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            The list of products cannot be displayed at this time, because there is a 
            technical problem with our website. We are working to resolve the issue as 
            quickly as possible and we apologize for the inconvenience. Please check this 
            page again soon.
        </EmptyDataTemplate>
    </asp:GridView>

    <asp:GridView ID="GridViewGreatestOrderNumber" runat="server" DataSourceID="SqlDataSourceOrdersRecord"
        AutoGenerateColumns="False" Visible="false">
        <Columns>
            <asp:BoundField DataField="OrderNumber" Visible="true" HeaderText="OrderNumber" 
                SortExpression="OrderNumber" />
        </Columns>
    </asp:GridView>

    <asp:GridView ID="GridViewOrdersRecordCount" runat="server" DataSourceID="SqlDataSourceOrdersRecordCount"
        AutoGenerateColumns="False" Visible ="false">
        <Columns>
            <asp:BoundField DataField="OrderCount" Visible="true" HeaderText="OrderCount" 
                SortExpression="OrderCount" ReadOnly="True" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceItemsRecord" runat="server" 
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        UpdateCommand="UPDATE [Item] SET [QuantityAvailable] = @QuantityAvailable WHERE [ItemNumber] = @ItemNumber">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItemsOrderedRecord" runat="server" 
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>" 
        SelectCommand="SELECT * FROM [Item]" 
        InsertCommand="INSERT INTO ItemsOrdered(OrderNumber, ItemNumber, QuantityRequested) VALUES (@OrderNumber, @ItemNumber, @QuantityRequested)">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceOrdersRecord" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>" 
        InsertCommand="INSERT INTO Orders(OrderNumber, UserID, DateTimeOrdered, CardType, CardNumber, CardCVV, CardExpirationDate,
            CustomerFirstName, CustomerLastName, Purchased) VALUES (@OrderNumber, @UserID, @DateTimeOrdered, @CardType, @CardNumber, @CardCVV,
            @CardExpirationDate, @CustomerFirstName, @CustomerLastName, @Purchased)"
        SelectCommand="SELECT MAX(OrderNumber) AS OrderNumber FROM Orders">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceOrdersRecordCount" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT COUNT(*) AS OrderCount FROM Orders">
    </asp:SqlDataSource>

    <asp:Label ID="Label1" runat="server" CssClass="InformationTextCalibri" 
        Text="How many of the selected product would you like to add to your cart?"></asp:Label><br /><br />
    <asp:TextBox ID="txtQuantityRequested" runat="server" CssClass="QuantityTextbox" TabIndex="2"
        ToolTip="Enter the quantity of the selected product that you would like to purchase in this text box."> 
    </asp:TextBox><br /><br />
    <asp:Button ID="btnViewCart" runat="server"  CssClass="MyButton" Text="View Cart" PostBackUrl="ViewCart.aspx"
        TabIndex="3" /> &nbsp&nbsp
    <asp:Button ID="btnAddToCart" runat="server" CssClass="MyButton" Text="Add To Cart" TabIndex="4" 
        onclick="btnAddToCart_Click" /> &nbsp&nbsp&nbsp&nbsp&nbsp       
    </asp:Content>




