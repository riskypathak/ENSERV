<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <title>jQuery UI Tabs - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
      $(function () {
          $("#tabs").tabs();
      });
  </script>
     <style type="text/css">
      .accordian {
          width:auto;
      }
     .accordionHeader {
		border: 1px solid #2F4F4F;       
		font-family: Arial, Sans-Serif;
		font-size: 10px;
		font-weight: bold;
		padding: 1px;
		margin-top: 1px;
		cursor: pointer;
        color:black;       
        background-image:url(images/top_border.gif);       
        background-size:inherit;
        border-bottom:1px solid #666;
	}
	.accordionHeaderSelected {
		border: 1px solid #2F4F4F;
		background-color: #FFFFFF;       
		font-family: Arial, Sans-Serif;
		font-size: 12px;
		font-weight: bold;
		padding: 0px;
		margin-top: 0px;
		cursor: pointer;
        color:black;
	}
	.accordionContent {
		background-color: #D3DEEF;
		border: 1px dashed #2F4F4F;
		border-top: none;
		padding: 1px;
		padding-top: 4px;
	}
  </style>

</head>
<body>
 
<div id="tabs" style="height:20px" >
  <ul style="height:20px">
    <li class="accordionHeader" ><a href="#tabs-1">Nunc tincidunt</a></li>
    <li class="accordionHeader"><a href="#tabs-2">Proin dolor</a></li>
    <li class="accordionHeader"><a href="#tabs-3">AeAenean lacinia</a></li>
  </ul>

  <div id="tabs-1" style="background-color:#D3DEEF">
    
  </div>
  <div id="tabs-2" style="background-color:#D3DEEF">
    
  </div>
  <div id="tabs-3" style="background-color:#D3DEEF;">
   </div>
    </div>
    </body>
    </html>