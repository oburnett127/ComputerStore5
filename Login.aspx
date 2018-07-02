<%@ Page Title="Log in to O-TECH Corporate Sales Site" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cpMainContent">
    <br /><br />
    <h1>Log in to O-TECH Corporate Sales Site</h1>
    <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate>
            <asp:Login ID="Login1" runat="server" CssClass="ControlStyle" CreateUserText="Click here to sign up."  
                PasswordRecoveryText="Forgot your password?" PasswordRecoverynUrl="~/PasswordRecovery.aspx" 
                CreateUserUrl="~/SignUp.aspx" TabIndex="1" 
                DestinationPageUrl="~/Default.aspx" DisplayRememberMe="False" 
                PasswordRecoveryUrl="PasswordRecovery.aspx">
                <CheckBoxStyle CssClass="InstructionText" />
                <HyperLinkStyle CssClass="InstructionText" />
                <InstructionTextStyle CssClass="InstructionText" />
                <LabelStyle CssClass="InstructionText" />
                <FailureTextStyle CssClass="InstructionText" />
                <LoginButtonStyle CssClass="MyButton" />
                <TitleTextStyle CssClass="ControlTitle" />
                <ValidatorTextStyle CssClass="ValidatorTextStyle" />
            </asp:Login>
        </AnonymousTemplate>
        <LoggedInTemplate>
            <asp:Label ID="lblAlreadyLoggedIn" runat="server" CssClass="InstructionText"
                Text="You are already logged in."></asp:Label>
        </LoggedInTemplate>
    </asp:LoginView>
    <asp:LoginStatus ID="LoginStatus1" runat="server" LoginText="" CssClass="InstructionText"
        LogoutText="Click here to log out." />
</asp:Content>
