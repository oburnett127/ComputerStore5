<%@ Page Title="Admin Home - O-TECH Corporate Sales" Language="C#" MasterPageFile="~/MasterPages/Maintenance.master" AutoEventWireup="true" CodeFile="AdminMenu.aspx.cs" Inherits="Maintenance_AdminMenu" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="cpMainContent">
    <div id="AdminHeader" runat="server">
        <asp:Label CssClass="InformationTextBoldCalibri" ID="label1" runat="server" Text="Admin Home" />
    </div>

    <div id="Instructions" runat="server">
        <asp:Label CssClass="InformationTextCalibri" id="label3" runat="server">Use the buttons below
            or the menu at the top left to navigate to the admin page that you need.
        </asp:Label>
    </div> <br />

    <div id="ButtonHolder" runat="server">
            <asp:Label ID="Label5" CssClass="InformationTextCalibri" runat="server" Text="Admins can edit product information and submit it."></asp:Label>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />

            <asp:Button ID="btnProductManager" runat="server" EnableTheming="false" Text="Product Manager" CssClass="AdminButton" 
             PostBackUrl="~/Maintenance/ProductEdit.aspx" /> <br /><br />

            <asp:Label ID="Label4" CssClass="InformationTextCalibri" runat="server" 
                Text="Admins can view order information including the order number, customer name, and order date.">
            </asp:Label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />

            <asp:Button ID="btnOrderManager" runat="server" EnableTheming="false" Text="Order Manager" CssClass="AdminButton" 
             PostBackUrl="~/Maintenance/OrderView.aspx" /> <br /><br />

            <asp:Button ID="btnReturnToFrontend" runat="server" EnableTheming="false" Text="Return to Customer Home Page" CssClass="AdminButton" 
             PostBackUrl="~/Default.aspx" 
             Tooltip="Click this button to return to the home page of the website that users see when they first navigate to the website."/> <br /> <br />
    </div> <!-- end div ButtonHolder -->
</asp:Content>
