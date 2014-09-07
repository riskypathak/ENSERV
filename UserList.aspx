<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMasterforRegulisation.master" AutoEventWireup="true" CodeFile="UserList.aspx.cs" Inherits="Site_UserList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <fieldset style="padding:20px">
        <legend style="font-size: large;">User List</legend>
        <asp:Repeater runat="server" ID="rptUserList">
        <HeaderTemplate>

            <table class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>User Name</th>
                        <th>Security Question</th>
                        <th>Answer</th>
                        <th>Group</th>
                       <th>Action</th>
                    </tr>
                </thead>
                <tbody>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%#Eval("UserName")%></td>
                <td><%#Eval("Question")%></td>
                <td><%#Eval("Answer")%></td>
                <td><%#Eval("groupname")%></td>
                <td><a href="CreateUser.aspx?Id=<%#Eval("UserId") %>">Edit User</a></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </tbody> </table>
        </FooterTemplate>
    </asp:Repeater>
    </fieldset>
    
   <%-- <link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/jqueryui/dataTables.jqueryui.css" rel="stylesheet" />
   
   
    <script src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
    <script src="http://cdn.datatables.net/plug-ins/725b2a2115b/integration/jqueryui/dataTables.jqueryui.js"></script>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".display").dataTable();
        });
    </script>

</asp:Content>


