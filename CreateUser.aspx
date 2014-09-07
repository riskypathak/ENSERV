<%@ Page Title="Create User" Language="C#" MasterPageFile="~/DefaultMasterforRegulisation.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="margin: 0 auto; width: 50%; padding: 10px;">
        <legend style="font-size: large;">User Deatils</legend>

        <div style="padding: 20px;">
            <asp:HiddenField  id="hdnUserID" Value="0" runat="server" />
            <table style="padding: 10px;font-size: larger;width: 100%;">
               
                <tr>
                    <td style="text-align: right;padding-right: 20px;">User Name:</td>
                    <td>
                        <asp:TextBox ID="txtUsername" runat="server" /><span style="color: red">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Required" ControlToValidate="txtUsername" runat="server" /></td>
                </tr>
                <tr >
                    <td style="text-align: right;padding-right: 20px;">Password:</td>
                    <td>
                        <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" /><span style="color: red">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Required" ControlToValidate="txtPassword" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td style="text-align: right;padding-right: 20px;">Confirm Password:</td>
                    <td>
                        <asp:TextBox ID="txtConfirmpassword" TextMode="Password" runat="server" /><span style="color: red">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Required" ControlToValidate="txtConfirmpassword" runat="server" />
                    </td>
                </tr>
                <tr >
                    <td style="text-align: right;padding-right: 20px;">Security Question:</td>
                    <td>
                        <asp:TextBox ID="txtQuestion" runat="server" /><span style="color: red">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ErrorMessage="Required" ControlToValidate="txtQuestion" runat="server" />
                    </td>

                </tr>
                <tr >
                    <td style="text-align: right;padding-right: 20px;">Answer:</td>
                    <td>
                        <asp:TextBox ID="txtAnswer" runat="server" /><span style="color: red">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ErrorMessage="Required" ControlToValidate="txtAnswer" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2"><h2>Group Details</h2></td>
                </tr>
                <tr>
                    <td style="text-align: right;padding-right: 20px;">Group:
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlGroup" runat="server" DataValueField="GroupID" DataTextField="GroupName">
                            <asp:ListItem Text="--Select--" Value="0" />
                        </asp:DropDownList>
                        <span style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2"><h2>Area Details</h2></td>
                </tr>
                <tr>
                    <td style="text-align: right;padding-right: 20px;">User Type:
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlUserType" AutoPostBack="true" OnSelectedIndexChanged="ddlUserType_SelectedIndexChanged" runat="server">
                            <asp:ListItem Text="--Select--" Value="0" />
                        </asp:DropDownList>
                        <span style="color: red">*</span>
                    </td>
                </tr>
                <tr id="trDivision" runat="server">
                    <td style="text-align: right;padding-right: 20px;">Division:
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlDivision" AutoPostBack="true" OnSelectedIndexChanged="ddlDivision_SelectedIndexChanged" runat="server">
                            <asp:ListItem Text="--Select--" Value="0" />
                        </asp:DropDownList>
                        <span style="color: red">*</span>
                    </td>
                </tr>
                <tr id="trSubDivision" runat="server">
                    <td style="text-align: right;padding-right: 20px;">Sub Division:
                    </td>
                    <td align="left">
                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlSubDivision_SelectedIndexChanged" ID="ddlSubDivision" runat="server">
                            <asp:ListItem Text="--Select--" Value="0" />
                        </asp:DropDownList>
                        <span style="color: red">*</span>
                    </td>
                </tr>
                <tr id="trSection" runat="server">
                    <td style="text-align: right;padding-right: 20px;">Section:
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlSection" runat="server">
                            <asp:ListItem Text="--Select--" Value="0" />
                        </asp:DropDownList>
                        <span style="color: red">*</span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td colspan="2"></td>
                </tr>
                 <tr>
                     <td></td>
                    <td>
                        <asp:Label style="color:red" ID="lblresult" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                 <tr>
                     <td></td>
                    <td>
                        <asp:Button CssClass="btn" ID="btnSave" Text="Save" CausesValidation="true" runat="server" OnClick="btnSave_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
</asp:Content>

