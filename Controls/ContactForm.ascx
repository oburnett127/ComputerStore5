<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ContactForm.ascx.cs" Inherits="Controls_ContactForm" %>
<% if (false) { %>
    <script src="../Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
<%  } %>

<script type="text/javascript">
    function ValidatePhoneNumbers(source, args)
    {
        var phoneHome = document.getElementById('<%= PhoneHome.ClientID %>'
        var phoneBusiness = document.getElementById('<%= PhoneBusiness.ClientID %>');
        if(phoneHome.value != '' || phoneBusiness.value != '')
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
</script>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <div id="TableWrapper">
            <table class="style1" runat="server" id="FormTable">
                <tr>
                    <td colspan="3" class="style4">
                        <h1>Get in touch with us</h1>
                        Use this form to contact us.&nbsp;If needed we will return your contact within 2 business days.&nbsp;Enter your name, e-mail 
                        address, and your home or business phone number to contact us.</td>
                </tr>
                <tr>
                    <td class="style7">
                        Name</td>
                    <td class="style8">
                        <asp:TextBox ID="Name" runat="server" ToolTip="Enter your name" 
                            CssClass="LargerTextBox"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="Name" CssClass="ErrorMessage" 
                            ErrorMessage="Enter your name">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style7">
                        E-mail address</td>
                    <td class="style8">
                        <asp:TextBox ID="EmailAddress" runat="server" ToolTip="Enter your e-mail address"
                            CssClass="InputBox"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="EmailAddress" CssClass="ErrorMessage" Display="Dynamic" 
                            ErrorMessage="Enter an e-mail address">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ControlToValidate="EmailAddress" CssClass="ErrorMessage" Display="Dynamic" 
                            ErrorMessage="Enter a valid e-mail address" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style7">
                        E-mail address again</td>
                    <td class="style8">
                        <asp:TextBox ID="ConfirmEmailAddress" runat="server" ToolTip="Enter your e-mail address again"
                            CssClass="InputBox"></asp:TextBox>
                        </td>
                    <td class="style2">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ControlToValidate="ConfirmEmailAddress" CssClass="ErrorMessage" 
                            Display="Dynamic" ErrorMessage="Confirm the e-mail address">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToCompare="EmailAddress" ControlToValidate="ConfirmEmailAddress" 
                            CssClass="ErrorMessage" Display="Dynamic" 
                            ErrorMessage="Retype the e-mail address">*</asp:CompareValidator>
                        </td>
                </tr>
                <tr>
                    <td class="style7">
                        Home phone number</td>
                    <td class="style8">
                        <asp:TextBox ID="PhoneHome" runat="server" ToolTip="Enter your home phone number"
                             CssClass="InputBox"></asp:TextBox>
                    </td>
                    <td>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" 
                            ClientValidationFunction="ValidatePhoneNumbers" CssClass="ErrorMessage" 
                            Display="Dynamic" ErrorMessage="Enter your home or business phone number" 
                            onservervalidate="CustomValidator1_ServerValidate">*</asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style7">
                        Business phone number</td>
                    <td class="style8">
                        <asp:TextBox ID="PhoneBusiness" runat="server" ToolTip="Enter your business phone number"
                             CssClass="InputBox"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="style7">
                        Comments</td>
                    <td class="style8">
                        <asp:TextBox ID="Comments" runat="server" Height="66px" TextMode="MultiLine" 
                            ToolTip="Enter your comments here" CssClass="InputBox"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                            ControlToValidate="Comments" CssClass="ErrorMessage" Display="Dynamic" 
                            ErrorMessage="Enter a comment">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style7">
                        &nbsp;</td>
                    <td class="style8">
                        <asp:Button ID="SendButton" runat="server" Text="Send" 
                            onclick="SendButton_Click" />
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="style3" colspan="3">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                            CssClass="ErrorMessage" 
                
                            HeaderText="Please correct the following errors then click the Send button:" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:Label ID="Message" runat="server" CssClass="Attention" Text="Message Sent" Visible="False" />
        <p runat="server" id="MessageSentPara" visible="False">
            Thank you for contacting us.  If needed we will return your contact within 2 business days.</p>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        <div class="PleaseWait">
            Please Wait...
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<script src="../Scripts/jquery.updnWatermark.js" type="text/javascript"></script>
 <script type="text/javascript">
     $(function () {
         $.updnWatermark.attachAll({ cssClass: 'Watermark' });
         $('form').bind('submit', function () {
             if (Page_IsValid) {
                 $('#TableWrapper').slideUp(3000);
             }
         });
     });
     function pageLoad() {
         $('.Attention').animate({ width: '600px' }, 3000).animate({ width: '100px' }, 3000).fadeOut('slow');
     }   
</script>