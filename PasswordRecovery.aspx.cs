using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PasswordRecovery : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hlkToLoginPage.Enabled = false;
        hlkToLoginPage.Visible = false;
    }
    protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
    {
        hlkToLoginPage.Visible = true;
        hlkToLoginPage.Enabled = true;
    }
}