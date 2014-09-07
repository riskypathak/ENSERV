<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMasterforRegulisation.master" AutoEventWireup="true" CodeFile="AreaMapping.aspx.cs" Inherits="Site_AreaMapping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td>User:</td>
            <td>
                <asp:DropDownList runat="server">
                    <asp:ListItem Text="User1" />
                    <asp:ListItem Text="User2" />
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td>
                privileges:
            </td>
            <td>
                <asp:DropDownList runat="server">
                    <asp:ListItem Text="Area1" />
                    <asp:ListItem Text="Area2" />
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>

