<%@ Page Title="O-TECH Corporate Sales Home Page" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="cpMainContent">
    <br />
    <div>
        <asp:Label CssClass="WelcomeText" ID="label1" runat="server" Text="Welcome to O-TECH!" />
    </div>
    <div>
        <asp:Label CssClass="InformationTextCalibri" id="label2" runat="server"> &nbsp&nbsp&nbsp&nbsp&nbsp O-TECH is the leading computer parts manufacturer and your best option for 
        finding reliable, durable, and affordable computer parts including processors, RAM, motherboards, hard drives, power supplies, mice, keyboards, speakers, and more.
        Please take a  <a href="ViewProducts.aspx">look at our products</a>.</asp:Label>
    </div>
</asp:Content>


