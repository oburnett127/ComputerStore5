<%@ Page Title="Password Recovery" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="PasswordRecovery.aspx.cs" Inherits="PasswordRecovery" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="cpMainContent">
    <h1>
        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" 
            onsendingmail="PasswordRecovery1_SendingMail" 
            ToolTip="Enter user name to have your password sent to your e-mail account." 
            UserNameInstructionText="Enter your User Name below and we will send your password to your e-mail account." 
            InstructionTextStyle-CssClass="InformationTextCalibri" CssClass="InformationTextCalibri">
        </asp:PasswordRecovery>
        <asp:HyperLink ID="hlkToLoginPage" runat="server" href="Login.aspx">Click here to return to log in page.</asp:HyperLink>
    </h1>
</asp:Content>