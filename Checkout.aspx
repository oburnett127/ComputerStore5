<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/MasterPages/MasterPage.master"
 AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout"
 EnableViewState="True" %>

<asp:Content ID="Content1" runat="server" contentplaceholderid="cpMainContent"><br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="Attention"
     EnableClientScript="true" HeaderText="The following items require your attention: "
     DisplayMode="BulletList" Visible="true" ShowSummary="true"
     ValidationGroup="ValidationGroup1" />
    
    <asp:Label ID="Label1" CssClass="InformationTextCalibri" runat="server"
     Text="Please provide us with the requested information to complete your order.
       You are required to fill in each field that is marked with an asterisk (*).">
    </asp:Label>

    <asp:Table ID="Table1" runat="server" CssClass="TableStyle">
        <asp:TableRow runat="server">
            <asp:TableCell runat="server" CssClass="InformationTextBoldCalibri">Please enter your name and billing address information:</asp:TableCell>
            <asp:TableCell ID="TableCell35" runat="server" />
            <asp:TableCell ID="TableCell12" runat="server" CssClass="InformationTextBoldCalibri" />
            <asp:TableCell runat="server" CssClass="LargestCell InformationTextBoldCalibri">
                Please enter your contact information: </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow runat="server">
            <asp:TableCell runat="server"></asp:TableCell>
            <asp:TableCell ID="TableCell36" runat="server"></asp:TableCell>
            <asp:TableCell ID="TableCell9" runat="server" CssClass="InformationTextBoldCalibri" />
            <asp:TableCell runat="server" CssClass="LargestCell">* Primary Phone Number:</asp:TableCell>
            <asp:TableCell runat="server">
                <asp:TextBox ID="txtPrimaryPhone" runat="server" TabIndex="7" CssClass="LargerTextBox LargerCell" 
                    ToolTip="Enter primary phone number here." OnTextChanged="txtPrimaryPhone_TextChanged">
                </asp:TextBox>
           </asp:TableCell>
            <asp:TableCell ID="TableCell50" runat="server">
                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorPrimaryPhone"
                  runat="server" ValidationGroup="ValidationGroup1"
                  ControlToValidate="txtPrimaryPhone" CssClass="ErrorMessage"
                  Display="Dynamic" Text="*"
                  ErrorMessage="Enter your primary phone number.">
                 </asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidatorPrimaryPhone"
                  runat="server" ValidationGroup="ValidationGroup1"
                  ControlToValidate="txtPrimaryPhone" CssClass="ErrorMessage"
                  Display="Dynamic" Text="*" ErrorMessage='Invalid primary phone number
                   format. Use the following format: "(xxx)xxx-xxxx" (No letters. Only 
                   numbers, dashes, ( ), and "." are allowed).'
                  ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$">
                 </asp:RegularExpressionValidator>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow1" runat="server">
            <asp:TableCell ID="TableCell1" runat="server">*  First Name: </asp:TableCell>
            <asp:TableCell ID="TableCell2" runat="server">
              <asp:TextBox ID="txtFirstName" runat="server" TabIndex="1"
             OnTextChanged="txtFirstName_TextChanged"></asp:TextBox></asp:TableCell>
            <asp:TableCell ID="TableCell49" runat="server">
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName" runat="server"
             ValidationGroup="ValidationGroup1"
             ControlToValidate="txtFirstName" CssClass="ErrorMessage" Display="Dynamic"
             Text="*"
             ErrorMessage="Enter your first name."></asp:RequiredFieldValidator>
            </asp:TableCell>
            <asp:TableCell ID="TableCell3" runat="server" CssClass="LargestCell">
              Secondary Phone Number: </asp:TableCell>
            <asp:TableCell ID="TableCell4" runat="server">
                    <asp:TextBox ID="txtSecondaryPhone" runat="server" CssClass="LargerTextBox LargerCell" TabIndex="8" 
                        Tooltip="Enter your secondary phone number here." OnTextChanged="txtSecondaryPhone_TextChanged"/>
            </asp:TableCell><asp:TableCell>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorSecondaryPhone" runat="server"
                                ControlToValidate="txtStreetAddress" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="ValidationGroup1"
                                ErrorMessage="Enter your secondary phone number."></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorSecondaryPhone" runat="server"
                            ControlToValidate="txtSecondaryPhone" CssClass="ErrorMessage" Display="Dynamic" Text="*" ValidationGroup="ValidationGroup1"
                            ErrorMessage='Invalid secondary phone number format. Use the following format: "(xxx)xxx-xxxx" (No letters. Only numbers, dashes, ( ), and "." are allowed).'
                            ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$" Enabled="True" EnableTheming="True">
                </asp:RegularExpressionValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell6" runat="server">*  Last Name: </asp:TableCell><asp:TableCell ID="TableCell7" runat="server">
                <asp:TextBox ID="txtLastName" runat="server" TabIndex="2" OnTextChanged="txtLastName_TextChanged"></asp:TextBox>
            </asp:TableCell><asp:TableCell>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" runat="server" ValidationGroup="ValidationGroup1"
                            ControlToValidate="txtLastName" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage="Enter your last name."></asp:RequiredFieldValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell10" runat="server">*  Street Address: </asp:TableCell><asp:TableCell ID="TableCell11" runat="server">
                <asp:TextBox ID="txtStreetAddress" runat="server" TabIndex="3" OnTextChanged="txtStreetAddress_TextChanged"></asp:TextBox>
            </asp:TableCell><asp:TableCell>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorStreetAddress" runat="server" ValidationGroup="ValidationGroup1"
                            ControlToValidate="txtStreetAddress" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage="Enter your street address."></asp:RequiredFieldValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell14" runat="server">*  City: </asp:TableCell><asp:TableCell ID="TableCell15" runat="server">
                <asp:TextBox ID="txtCity" runat="server" TabIndex="4" OnTextChanged="txtCity_TextChanged"></asp:TextBox>
            </asp:TableCell><asp:TableCell ID="TableCell16" runat="server">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCity" runat="server" ValidationGroup="ValidationGroup1"
                            ControlToValidate="txtCity" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage="Enter your city."></asp:RequiredFieldValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell17" runat="server">*  Select State: </asp:TableCell><asp:TableCell ID="TableCell18" runat="server">
                <asp:DropDownList ID="ddlState" runat="server" CssClass="SmallDropDownList" 
                 ToolTip="Click the arrow and select your billing address state."
                 Enabled="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" TabIndex="5">
                    <asp:ListItem Selected="True" Text="Select billing address state" Value="" />
                    <asp:ListItem Value="AK">AK</asp:ListItem><asp:ListItem Value="AL">AL</asp:ListItem><asp:ListItem Value="AZ">AZ</asp:ListItem>
                    <asp:ListItem Value="AR">AR</asp:ListItem><asp:ListItem Value="CA">CA</asp:ListItem><asp:ListItem Value="CO">CO</asp:ListItem>
                    <asp:ListItem Value="CT">CT</asp:ListItem><asp:ListItem Value="DE">DE</asp:ListItem><asp:ListItem Value="FL">FL</asp:ListItem>
                    <asp:ListItem Value="GA">GA</asp:ListItem><asp:ListItem Value="HI">HI</asp:ListItem><asp:ListItem Value="IA">IA</asp:ListItem>
                    <asp:ListItem Value="ID">ID</asp:ListItem><asp:ListItem Value="IL">IL</asp:ListItem><asp:ListItem Value="IN">IN</asp:ListItem>
                    <asp:ListItem Value="KS">KS</asp:ListItem><asp:ListItem Value="KY">KY</asp:ListItem><asp:ListItem Value="LA">LA</asp:ListItem>
                    <asp:ListItem Value="MA">MA</asp:ListItem><asp:ListItem Value="MD">MD</asp:ListItem><asp:ListItem Value="ME">ME</asp:ListItem>
                    <asp:ListItem Value="MI">MI</asp:ListItem><asp:ListItem Value="MN">MN</asp:ListItem><asp:ListItem Value="MO">MO</asp:ListItem>
                    <asp:ListItem Value="MS">MS</asp:ListItem><asp:ListItem Value="MT">MT</asp:ListItem><asp:ListItem Value="NC">NC</asp:ListItem>
                    <asp:ListItem Value="ND">ND</asp:ListItem><asp:ListItem Value="NE">NE</asp:ListItem><asp:ListItem Value="NH">NH</asp:ListItem>
                    <asp:ListItem Value="NJ">NJ</asp:ListItem><asp:ListItem Value="NM">NM</asp:ListItem><asp:ListItem Value="NV">NV</asp:ListItem>
                    <asp:ListItem Value="NY">NY</asp:ListItem><asp:ListItem Value="OH">OH</asp:ListItem><asp:ListItem Value="OK">OK</asp:ListItem>
                    <asp:ListItem Value="OR">OR</asp:ListItem><asp:ListItem Value="PA">PA</asp:ListItem><asp:ListItem Value="RI">RI</asp:ListItem>
                    <asp:ListItem Value="SC">SC</asp:ListItem><asp:ListItem Value="SD">SD</asp:ListItem><asp:ListItem Value="TN">TN</asp:ListItem>
                    <asp:ListItem Value="TX">TX</asp:ListItem><asp:ListItem Value="UT">UT</asp:ListItem><asp:ListItem Value="VA">VA</asp:ListItem>
                    <asp:ListItem Value="VT">VT</asp:ListItem><asp:ListItem Value="WA">WA</asp:ListItem><asp:ListItem Value="WI">WI</asp:ListItem>
                    <asp:ListItem Value="WV">WV</asp:ListItem><asp:ListItem Value="WY">WY</asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell><asp:TableCell ID="TableCell51" runat="server">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorState" runat="server" ValidationGroup="ValidationGroup1"
                   ControlToValidate="ddlState" CssClass="ErrorMessage" Display="Dynamic" 
                   ErrorMessage="Select your state.">*</asp:RequiredFieldValidator>
            </asp:TableCell><asp:TableCell ID="TableCell19" runat="server" CssClass="InformationTextBoldCalibri" />
            <asp:TableCell ID="TableCell5" runat="server" CssClass="InformationTextBoldCalibri">
                Please enter your payment card information:
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell20" runat="server">*  Zip Code: </asp:TableCell><asp:TableCell ID="TableCell21" runat="server">
                <asp:TextBox ID="txtZipCode" runat="server" TabIndex="6"></asp:TextBox>
            </asp:TableCell><asp:TableCell ID="TableCell45" runat="server">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorZipCode" runat="server" ControlToValidate="txtZipCode"
                    ValidationGroup="validationGroup1" ErrorMessage="Enter your zip code." Text="*" >
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorZipCode" runat="server" ValidationGroup="ValidationGroup1"
                            ControlToValidate="txtZipCode" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage='Invalid zip code format. Use the following format (all numbers): "xxxxx-xxxx" or "xxxxx".'
                            ValidationExpression="[0-9]{5}(-)?([0-9]{4})?" Enabled="True" EnableTheming="True">
                </asp:RegularExpressionValidator>
            </asp:TableCell><asp:TableCell ID="TableCell52" runat="server"></asp:TableCell><asp:TableCell ID="TableCell23" runat="server">* Select Payment Card Type: </asp:TableCell><asp:TableCell ID="TableCell24" runat="server">
                <asp:DropDownList ID="ddlCardType" runat="server" CssClass="LargeDropDownList"
                    ToolTip="Click the arrow and select your payment card type." Enabled="true"
                    OnSelectedIndexChanged="ddlCardType_SelectedIndexChanged" TabIndex="13" Value="">
                    <asp:ListItem Selected="True" Text="Select payment card type" Value="" />
                    <asp:ListItem Value="Discover">Discover</asp:ListItem>
                    <asp:ListItem Value="Master Card">Master Card</asp:ListItem>
                    <asp:ListItem Value="Visa">Visa</asp:ListItem>
                </asp:DropDownList>
            </asp:TableCell><asp:TableCell ID="TableCell53" runat="server">
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCardType" runat="server" ValidationGroup="ValidationGroup1"
                            ControlToValidate="ddlCardType" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage="Select your payment card type."></asp:RequiredFieldValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell43" runat="server"></asp:TableCell><asp:TableCell ID="TableCell25" runat="server"></asp:TableCell><asp:TableCell ID="TableCell47" runat="server"></asp:TableCell><asp:TableCell ID="TableCell22" runat="server">*  Select Card Expiration Date: </asp:TableCell><asp:TableCell ID="TableCell8" runat="server" CssClass="InformationTextBoldCalibri" />
            <asp:TableCell ID="TableCell27" runat="server">*  Card Number: </asp:TableCell><asp:TableCell ID="TableCell28" runat="server">
                <asp:TextBox ID="txtCardNumber" runat="server" TabIndex="14" OnTextChanged="txtCardNumber_TextChanged"></asp:TextBox>
            </asp:TableCell><asp:TableCell ID="TableCell54" runat="server">
                <asp:CustomValidator ID="CustomValidatorCardNumber" runat="server" OnServerValidate="CustomValidatorCardNumber_ServerValidate"
                    ErrorMessage="Enter your payment card number." Text="*" ValidationGroup="ValidationGroup1"
                    Display="Dynamic"></asp:CustomValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell29" runat="server"></asp:TableCell><asp:TableCell ID="TableCell30" runat="server"></asp:TableCell><asp:TableCell ID="TableCell13" runat="server"></asp:TableCell><asp:TableCell ID="TableCell26" runat="server">
                <asp:Calendar ID="calCardExpirationDate" runat="server" TabIndex="16" ToolTip="Select the expiration date of your payment card."
                    SelectionMode="Day" ShowNextPrevMonth="true" CssClass="DayStyle OtherMonthDayStyle" OnSelectionChanged="calCardExpirationDate_SelectionChanged" SelectedDate="1/1/2012 12:00:00 AM" VisibleDate="1/1/2012 12:00:00 AM">
                </asp:Calendar>
            </asp:TableCell><asp:TableCell ID="TableCell55" runat="server">
           
            </asp:TableCell><asp:TableCell ID="TableCell31" runat="server">*  Card CVV: </asp:TableCell><asp:TableCell ID="TableCell32" runat="server">
                <asp:TextBox ID="txtCardCVV" runat="server" CssClass="SmallTextBox" OnTextChanged="txtCardCVV_TextChanged" TabIndex="15"
                ToolTip="Enter the three digit security code (CVV) on your payment card."></asp:TextBox>
            </asp:TableCell><asp:TableCell>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorCVV" runat="server" ValidationGroup="ValidationGroup1" 
                            ControlToValidate="txtCardCVV" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage="Enter your payment card CVV (possibly on back of card).">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorCVV" runat="server" validationGroup="validationGroup1"
                            ControlToValidate="txtCardCVV" CssClass="ErrorMessage" Display="Dynamic" Text="*"
                            ErrorMessage='Invalid payment card CVV format. Use the following format (all numbers): "xxx".'
                            ValidationExpression="[0-9]{3}" Enabled="True" EnableTheming="True">
                </asp:RegularExpressionValidator>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell39" runat="server"></asp:TableCell><asp:TableCell ID="TableCell40" runat="server"></asp:TableCell><asp:TableCell ID="TableCell41" runat="server"></asp:TableCell><asp:TableCell ID="TableCell42" runat="server"></asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell ID="TableCell37" runat="server"></asp:TableCell><asp:TableCell ID="TableCell38" runat="server"></asp:TableCell><asp:TableCell ID="TableCell33" runat="server"></asp:TableCell><asp:TableCell ID="TableCell44" runat="server"></asp:TableCell><asp:TableCell ID="TableCell46" runat="server">
                <asp:Button ID="btnCancelOrder" runat="server" Text="Cancel Order" TabIndex="18" OnClick="btnCancelOrder_Click"
                    ToolTip="Click this button to cancel your order." />
            </asp:TableCell><asp:TableCell ID="TableCell34" runat="server">
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" TabIndex="17" OnClick="btnPlaceOrder_Click"
                    ToolTip="Click this button to place your order.  Clicking this button will cause your payment card transaction to be processed. Your order will be final and it will be impossible to cancel or change your order." CausesValidation="true" ValidationGroup="ValidationGroup1" />
            </asp:TableCell></asp:TableRow>
    </asp:Table>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ItemNumber" 
        DataSourceID="SqlDataSourceGridViewPopulator" Visible="false" PagerSettings-Visible="false">
        <Columns>
            <asp:BoundField DataField="ItemName" SortExpression="ItemName" Visible="false" />
            <asp:BoundField DataField="QuantityRequested" SortExpression="Quantity"
             Visible="false" />
            <asp:BoundField DataField="Price" SortExpression="Price" Visible="false" />
            <asp:BoundField DataField="ItemNumber" SortExpression="ItemNumber" Visible="false" />
            <asp:BoundField DataField="ItemWeight" SortExpression="ItemWeight" Visible="false" />
            <asp:BoundField SortExpression="ItemSubtotal" Visible="false" />
            <asp:BoundField SortExpression="ItemTax" Visible="false" />
            <asp:BoundField SortExpression="ItemShipping" Visible="false" />
            <asp:BoundField SortExpression="ItemTotal" Visible="false" />
            <asp:BoundField DataField="QuantityAvailable" SortExpression="QuantityAvailable"
             Visible="false" />
        </Columns>
    </asp:GridView>

    <asp:GridView ID="GridViewCustomerID1" runat="server" DataSourceID="SqlDataSourceCustomers1"
     Visible="false" PagerSettings-Visible="false" DataKeyNames="CustomerID"
     AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="CustomerID" SortExpression="CustomerID" Visible="false" />
        </Columns>
    </asp:GridView>

    <asp:GridView ID="GridViewCustomerID2" runat="server" DataSourceID="SqlDataSourceCustomers2"
     Visible="false"
        PagerSettings-Visible="false" DataKeyNames="CustomerID" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="CustomerID" SortExpression="CustomerID" Visible="false" />
        </Columns>
    </asp:GridView>

    <asp:GridView ID="GridViewGreatestCustomerNumber" runat="server"
     DataSourceID="SqlDataSourceCustomers2" AutoGenerateColumns="False" Visible="false">
        <Columns>
            <asp:BoundField DataField="CustomerNumber" Visible="true"
             HeaderText="CustomerNumber" SortExpression="CustomerNumber" />
        </Columns>
    </asp:GridView>

    <asp:GridView ID="GridViewCustomersRecordCount" runat="server"
     DataSourceID="SqlDataSourceCustomers3" AutoGenerateColumns="False" Visible ="false">
        <Columns>
            <asp:BoundField DataField="CustomerRecordCount" Visible="true"
             HeaderText="CustomerRecordCount" SortExpression="CustomerRecordCount"
             ReadOnly="True" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceGridViewPopulator" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT Item.ItemName, ItemsOrdered.QuantityRequested, Item.Price,
         Item.ItemNumber, Item.ItemWeight FROM Item INNER JOIN ItemsOrdered ON
         Item.ItemNumber = ItemsOrdered.ItemNumber WHERE (ItemsOrdered.OrderNumber 
         = @OrderNumber)">
        <SelectParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber"
             Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItems" runat="server" 
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        UpdateCommand="UPDATE Item SET QuantityAvailable = @QuantityAvailable WHERE 
         ItemNumber = @ItemNumber">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceItemsOrdered" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        DeleteCommand="DELETE FROM ItemsOrdered WHERE OrderNumber = @OrderNumber">
        <DeleteParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber"
             Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceOrders" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        UpdateCommand="UPDATE Orders SET DateTimeOrdered = @DateTimeOrdered, CardType 
         = @CardType, CardNumber = @CardNumber, CardCVV = @CardCVV, CardExpirationDate 
         = @CardExpirationDate, CustomerFirstName = @CustomerFirstName, CustomerLastName 
         = @CustomerLastName, Purchased = @Purchased WHERE OrderNumber = @OrderNumber"
        DeleteCommand="DELETE FROM [Orders] WHERE [OrderNumber] = @OrderNumber">
        <DeleteParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCustomers1" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT CustomerID FROM Customers WHERE (UserID = @UserID)"
        UpdateCommand="UPDATE Customers SET CustomerID = @CustomerID, UserID = @UserID,
         FirstName = @CustomerFirstName, LastName = @CustomerLastName, PrimaryPhone 
         = @PrimaryPhone, SecondaryPhone = @SecondaryPhone, StreetAddress = @StreetAddress,
         City = @City, State = @State, ZipCode = @ZipCode WHERE CustomerID = @CustomerID" 
        DeleteCommand="DELETE FROM Orders WHERE (OrderNumber = @OrderNumber)">
        <DeleteParameters>
            <asp:SessionParameter Name="OrderNumber" SessionField="CustomerOrderNumber" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCustomers2" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        InsertCommand="INSERT INTO Customers(CustomerID, UserID, FirstName, LastName,
         PrimaryPhone, SecondaryPhone, StreetAddress, City, State, ZipCode)
         VALUES(@CustomerID, @UserID, @CustomerFirstName, @CustomerLastName, @PrimaryPhone,
         @SecondaryPhone, @StreetAddress, @City, @State, @ZipCode)"
        SelectCommand="SELECT MAX(CustomerNumber) AS CustomerNumber FROM Customers">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceCustomers3" runat="server"
        ConnectionString="<%$ ConnectionStrings:otechConnectionString1 %>" 
        ProviderName="<%$ ConnectionStrings:otechConnectionString1.ProviderName %>"
        SelectCommand="SELECT COUNT(*) AS CustomerCount FROM Customers">
    </asp:SqlDataSource>
    
</asp:Content>