<%@ Page Title="Order Manager" Language="C#" MasterPageFile="~/MasterPages/Maintenance.master" AutoEventWireup="true" CodeFile="OrderView.aspx.cs" Inherits="Maintenance_OrderView" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="cpMainContent"> <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="OrderNumber" 
        DataSourceID="SqlDataSource1" >
        <Columns>
            <asp:CommandField ShowSelectButton="True" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:CommandField>
            <asp:BoundField DataField="OrderNumber" HeaderText="Order Number" ReadOnly="True" SortExpression="OrderNumber" >
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="CustomerFirstName" HeaderText="Customer First Name" SortExpression="FirstName">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="CustomerLastName" HeaderText="Customer Last Name" SortExpression="LastName">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
            <asp:BoundField DataField="DateTimeOrdered" HeaderText="Date Time Ordered" SortExpression="DateTimeOrdered">
                <HeaderStyle CssClass="GridViewHeaderStyle" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            There are no orders in the database.
        </EmptyDataTemplate>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        SelectCommand="SELECT [OrderNumber], [CustomerFirstName], [CustomerLastName], [DateTimeOrdered] FROM [Orders]">
    </asp:SqlDataSource>
</asp:Content>
