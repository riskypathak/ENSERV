<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMasterforRegulisation.master" AutoEventWireup="true" CodeFile="GroupPrivilgeMapping.aspx.cs" Inherits="GroupPrivilgeMapping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset style="margin: 0 auto; width: 50%; padding: 10px;">
        <legend style="font-size: large;">Group Privilege Mapping</legend>

        <div style="padding: 20px;">
            <table style="padding: 10px;font-size: larger;width: 100%;">
                <tr>
                    <td style="text-align: right;padding-right: 20px;"><span>User Group:</span></td>
                    <td>
                        <asp:DropDownList ID="ddlGroup" runat="server">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td style="text-align: right;padding-right: 20px;"><span>Privileges:</span></td>
                    <td>
                        <asp:ListBox ID="ddlPrivileges" style="width: 170px;margin-top: 10px;" SelectionMode="Multiple" runat="server">
                           
                        </asp:ListBox></td>
                </tr>
                <tr>
                    <td>

                    </td>
                    <td style="padding-top:10px">
                        <asp:Button ID="btnSave" CssClass="btn"  Text="Save" runat="server" OnClick="btnSave_Click" />
                    </td>
                </tr>
            </table>
            <asp:Label ID="lblMsg" style="color:Red;"  Text="Privileges Assigned Successfully" runat="server" />
        </div>
    </fieldset>
    

</asp:Content>

