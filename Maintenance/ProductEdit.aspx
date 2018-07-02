<%@ Page  Title="Product Manager" Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/Maintenance.master" CodeFile="ProductEdit.aspx.cs" Inherits="Maintenance_ProductEdit" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="cpMainContent">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ItemNumber" 
        DataSourceID="SqlDataSource1" 
        EmptyDataText="There are no data records to display." >
        <AlternatingRowStyle CssClass="AlternatingRow" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowSelectButton="True" ButtonType="Button" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:CommandField>
            <asp:BoundField DataField="ItemNumber" HeaderText="Item Number" ReadOnly="True" 
                SortExpression="ItemNumber" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemName" HeaderText="Item Name" 
                SortExpression="ItemName" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="QuantityAvailable" HeaderText="Quantity Available" 
                SortExpression="QuantityAvailable" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemDescription" HeaderText="Item Description" 
                SortExpression="ItemDescription" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ImageUrl" HeaderText="Image Url" 
                SortExpression="ImageUrl" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="ItemWeight" HeaderText="Item Weight" 
                SortExpression="ItemWeight" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
        </Columns>
        <SelectedRowStyle CssClass="SelectedItem" />
    </asp:GridView>

    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
        DataKeyNames="ItemNumber" DataSourceID="SqlDataSource1" 
        DefaultMode="Insert">
        <Fields>
            <asp:BoundField DataField="ItemNumber" HeaderText="ItemNumber" ReadOnly="true" SortExpression="ItemNumber" />
            <asp:BoundField DataField="ItemName" HeaderText="ItemName" SortExpression="ItemName" />
            <asp:BoundField DataField="QuantityAvailable" HeaderText="QuantityAvailable" SortExpression="QuantityAvailable" />
            <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
            <asp:BoundField DataField="ItemDescription" HeaderText="ItemDescription" SortExpression="ItemDescription" />
            <asp:BoundField DataField="ImageUrl" HeaderText="ImageUrl" SortExpression="ImageUrl" />
            <asp:BoundField DataField="ItemWeight" HeaderText="Item Weight" SortExpression="ItemWeight" />
            <asp:CommandField ShowInsertButton="True" ButtonType="Button" />
        </Fields>
    </asp:DetailsView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        DeleteCommand="DELETE FROM [Item] WHERE [ItemNumber] = @ItemNumber" 
        InsertCommand="INSERT INTO [Item] ([ItemNumber], [ItemName], [QuantityAvailable], [Price], [ItemDescription], [ImageUrl], [ItemWeight]) VALUES (@ItemNumber, @ItemName, @QuantityAvailable, @Price, @ItemDescription, @ImageUrl, @ItemWeight)" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>" 
        SelectCommand="SELECT [ItemNumber], [ItemName], [QuantityAvailable], [Price], [ItemDescription], [ImageUrl], [ItemWeight] FROM [Item]" 
        UpdateCommand="UPDATE [Item] SET [ItemName] = @ItemName, [QuantityAvailable] = @QuantityAvailable, [Price] = @Price, [ItemDescription] = @ItemDescription, [ImageUrl] = @ImageUrl, [ItemWeight] = @ItemWeight WHERE [ItemNumber] = @ItemNumber">
        <DeleteParameters>
            <asp:Parameter Name="ItemNumber" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ItemNumber" Type="String" />
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="QuantityAvailable" Type="Int32" />
            <asp:Parameter Name="Price" Type="Double" />
            <asp:Parameter Name="ItemDescription" Type="String" />
            <asp:Parameter Name="ImageUrl" Type="String" />
            <asp:Parameter Name="ItemWeight" Type="Double" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="QuantityAvailable" Type="Int32" />
            <asp:Parameter Name="Price" Type="Double" />
            <asp:Parameter Name="ItemDescription" Type="String" />
            <asp:Parameter Name="ImageUrl" Type="String" />
            <asp:Parameter Name="ItemNumber" Type="Double" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>