<%@ Page Title="Sign Up for a New Account at O-TECH Corporate Sales Website" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="SignUp" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="cpMainContent">
    <asp:CreateUserWizard ID="CreateNewUserAccountWizard1" runat="server" 
        ContinueDestinationPageUrl="~/Default.aspx">
        <MailDefinition BodyFileName="~/App_Data/SignUpConfirmation.txt" 
            Subject="Your New Account at www.otechcorporatesales.com">
        </MailDefinition>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
            </asp:CreateUserWizardStep>
            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>