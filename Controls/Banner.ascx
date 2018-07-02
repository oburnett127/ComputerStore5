<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Banner.ascx.cs" Inherits="Controls_Banner" %>
<asp:Panel ID="VerticalPanel" runat="server">
</asp:Panel>
<asp:Panel ID="HorizontalPanel" CssClass="HorizontalPanel" runat="server" Height="125px" 
    style="text-align: center" Width="520px">
    <a href="~/Default.aspx" target="_blank" runat="server" id="HorizontalLink">
        <asp:Image ID="otech_logo" runat="server" AlternateText="O-TECH Inc. Logo"
            ImageUrl="~/Images/otech_logo.gif" />
    </a>
    <br />
    <br />
    <br />
    <br />
</asp:Panel>

