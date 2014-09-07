<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="CSVUploadEngine.aspx.cs" Inherits="CSVUploadEngine" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="CSS/ThemeBlue.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form runat="server">
        <asp:ScriptManager ID="scriptManager" runat="server" />
        <script type="text/javascript">
            function pageLoad(sender, args) {
                //Register the form and upload elements
                window.parent.register(
                    $get('<%= this.Form.ClientID %>'),
                $get('<%= this.fileUpload.ClientID %>')
            );
        }
        </script>
        <asp:FileUpload ID="fileUpload" runat="server" />
    </form>
</body>
</html>

