<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="MyAccount_ChangePassword" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="cpMainContent">
    <asp:ChangePassword ID="ChangePassword1" runat="server" 
        CancelDestinationPageUrl="~/default.aspx" 
        ContinueDestinationPageUrl="~/default.aspx" 
        NewPasswordRegularExpressionErrorMessage="Please enter a different new password." 
        PasswordLabelText="Current Password:" 
        PasswordRequiredErrorMessage="Current password is required." 
        ToolTip="Use this form to change your password.">
        <CancelButtonStyle CssClass="MyButton" />
        <ChangePasswordButtonStyle CssClass="MyButton" />
        <ContinueButtonStyle CssClass="MyButton" />
        <InstructionTextStyle CssClass="InformationTextCalibri" />
        <LabelStyle CssClass="InformationTextCalibri" />
        <PasswordHintStyle CssClass="InformationTextCalibri" />
        <MailDefinition From="busyprogrammertech@gmail.com" BodyFileName="~/App_Data/PasswordChangedEmailBody.txt"
            Subject="Your www.otechcorporatesales.com password has been changed.">
        </MailDefinition>
        <SuccessTextStyle CssClass="" />
        <TextBoxStyle CssClass="InformationTextCalibri" />
        <TitleTextStyle CssClass="InformationTextBoldCalibri" />
        <ValidatorTextStyle CssClass="ErrorMessage" />
</asp:ChangePassword>
</asp:Content>
