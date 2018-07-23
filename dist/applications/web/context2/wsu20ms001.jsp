<%@ page contentType="text/html; charset=EUC-KR" language="java"%>
<%
/**
 * @author Ho-Jin Seo
 * @version 1.0 2008.09.25
 */
%>
<html>
<head>
<%@ include file="./com00in000.jsp" %>
<%@ include file="./com00in003.jsp" %>
<title><%=_i18n.get("global.page.title")%></title>
<!-- script type="text/javascript" src="js/dhtmlHistory.js"> </script-->
<script language="JavaScript" type="text/JavaScript">
<!--
function initialize() {
	getUserList();
	getParty();
}

function detail(obid) {
   location = "wsu21ms001.jsp?obid=" + obid;
}

function showList(originalRequest) {
   	//closeInfo();

	var res = eval("(" + originalRequest.responseText + ")");

	var operations = "";
	var performers = "";
	var body = "";
	body = getHeader();

	var num = 0;
	var auth_type = "";
	for (var i=0; i<res.user.length; i++) {
		if (res.user[i].mine == "0")
			auth_type = "<%=_i18n.get("global.user.auth.recv")%>";
		else
			auth_type = "<%=_i18n.get("global.user.auth.send")%>";

		body += '<tr>';
		body += '<input type=hidden name="userObid' + i + '" id="userObid' + i + '" value="' + res.user[i].obid + '">';
		body += '<td class="ResultData" align="left"><a href="javascript:detail(\'' + res.user[i].obid + '\')"><font class="blue-text03">' + res.user[i].id + '</font></a></td>';
//		body += '<td class="ResultData" align="center">' + auth_type + '</td>';
//		body += '<td class="ResultData" align="center">' + res.user[i].party_id + '</td>';
		body += '<td class="ResultData" align="left">' + res.user[i].description + '</td>';
		body += '<td class="ResultLastData" align="center"><input type="checkbox" name="checkIndex" value="' + i + '"></td>';
		body += '</tr>';
	}

	if (res.user.length == 0) {
		body += '<tr>';
		body += '<td class="ResultData" colspan="3" align="center"><%= _i18n.get("wsu20ms001.notfound")%></td></tr>';
	}

	body += "</table>";
	$('listContent').innerHTML = body;

	$('row_size').innerHTML = res.user.length;
	$('pagelist').innerHTML = res.pagelist;
}
function getHeader() {
	var body = "";
	body += '<table class="TableLayout" >';
	body += '  <COLGROUP>';
	body += '  <COL span="1" style="width:15%;">';
//	body += '  <COL span="1" style="width:15%;">';
//	body += '  <COL span="1" style="width:15%;">';
	body += '  <COL span="1" style="width:80%;">';
	body += '  <COL span="1" width="30" align="center">';
	body += '  </COLGROUP>';
	body += '<tr>';
	body += '<td class="ResultHeader"><%=_i18n.get("global.user.id")%></td>';
//	body += '<td class="ResultHeader"><%=_i18n.get("global.user.auth.type")%></td>';
//	body += '<td class="ResultHeader"><%=_i18n.get("global.user.party")%></td>';
	body += '<td class="ResultHeader"><%=_i18n.get("global.user.description")%></td>';
	body += '<td class="ResultLastHeader"><input type="checkbox" name="allChkBtn" id="allChkBtn" onClick="javascript:mainAllCheck()" ></td>';
	body += '</tr>';

	return body;
}

function getUserList() {

	var body = getHeader();
	body += '<tr>';
	body += '<td class="ResultData" colspan="3" align="center"><%=_i18n.get("global.processing") %></td>';
	body += '</tr>';
	body += '</table>';
	$('listContent').innerHTML = body;

	var params = Form.serialize(document.form1);
	//openInfo('<%=_i18n.get("global.processing") %>');
	var opt = {
		method: 'post',
		parameters: params,
		onSuccess: showList,
	    on404: function(t) {
	    	//closeInfo();
        	$('messageDisplay').innerHTML = '<%=_i18n.get("err00zz404.message") %>';
        //	showError('<%=_i18n.get("err00zz404.message") %>', null, null, null);
	    },
	    onFailure: function(t) {
	    	//closeInfo();
        	$('messageDisplay').innerHTML = '<%=_i18n.get("global.error.retry") %>';
        	//showErrorPopup(t.responseText, null, null, null);
	    }
	}
	var myAjax = new Ajax.Request("./wsu20ac001.jsp", opt);

}
function searchList(page) {
	$('curPage').value = page;
	getUserList();
}

function mainAllCheck() {
	var inputs     = document.getElementsByTagName('input');
	var checkboxes = new Array();
	var count = 0;
	for (var i = 0; i < inputs.length; i++) {
	   if (inputs[i].type == 'checkbox' && inputs[i].name != 'allChkBtn') {
		   checkboxes[count++] = inputs[i];
	   }
	}
	for (var i = 0; i < checkboxes.length; i++) {
	   checkboxes[i].checked = document.all.allChkBtn.checked;
	}
}

function deleteOkFunction() {
	Windows.closeAllModalWindows();

	var params = Form.serialize(document.form1);
	var opt = {
		method: 'get',
		parameters: params,
		onSuccess: function(t) {
			$('messageDisplay').innerHTML = '<img src="images/bu_query.gif" align="absmiddle" > <%= _i18n.get("wsu20ms001.operation.delete") %>';
			searchList(1);
		},
	    on404: function(t) {
        	$('messageDisplay').innerHTML = '<img src="images/bu_query.gif" align="absmiddle" > <%=_i18n.get("err00zz404.message") %>';
        //	showError('<%=_i18n.get("err00zz404.message") %>', null, null, null);
	    },
	    onFailure: function(t) {
        	$('messageDisplay').innerHTML = '<img src="images/bu_query.gif" align="absmiddle" > <%=_i18n.get("global.error.retry") %>';
        	showErrorPopup(t.responseText, null, null, null);
	    }
	}
	var myAjax = new Ajax.Request("./wsu40ac001.jsp", opt);
}

function deleteUser() {
	var check_index = getSelectedId_Index();
	if(check_index == null || check_index == '') {
		msg = "<%=_i18n.get("wsu20ms001.non.selected")%>";
		openAlert(msg, "<%=_i18n.get("global.alert")%>", "<%=_i18n.get("global.ok")%>");
	} else {
		msg = "<%=_i18n.get("wsu20ms001.delete.confirm")%>";
		openConfirm(msg, deleteOkFunction, null, "<%=_i18n.get("global.warning")%>");
	}
}

function createUser() {
	location.href = "wsu10ms001.jsp";
}

function getSelectedId_Index() {
   var inputs = document.getElementsByTagName('input');
   var id_Index = "" ;
   var selCnt = 0;
   for (var i = 0; i < inputs.length; i++) {
	  if (inputs[i].type == 'checkbox' && inputs[i].checked==true && inputs[i].name != 'allChkBtn')
	  {
		  id_Index = inputs[i].value;
		  selCnt++;
	  }
   }
   return id_Index;
}

function searchUser(page) {
	$('curPage').value = page;

	var params = Form.serialize(document.form1);
	getUserList();
}

function displayPartyList(originalRequest) {
	var res = eval("(" + originalRequest.responseText + ")");
	var operations = "";
	var performers = "";
	var body = "";

	$('partyid').length = 0;
	$('partyid').options[0] = new Option("<%= _i18n.get("global.all") %>","");
	for (var i=0; i<res.party.length; i++) {
		$('partyid').options[i+1] = new Option(res.party[i].partyid,res.party[i].obid);
	}
	$('partyid').options[0].selected = true;
}

function getParty() {

	var params = Form.serialize(document.form1);
	var opt = {
		method: 'post',
		parameters: params,
		asynchronous : false,
		onSuccess: displayPartyList,
	    on404: function(t) {
        	$('messageDisplay').innerHTML = '<img src="images/bu_query.gif" align="absmiddle" ><%=_i18n.get("err00zz404.message") %>';
        //	showError('<%=_i18n.get("err00zz404.message") %>', null, null, null);
	    },
	    onFailure: function(t) {
        	$('messageDisplay').innerHTML = '<img src="images/bu_query.gif" align="absmiddle" ><%=_i18n.get("global.error.retry") %>';
        	showErrorPopup(t.responseText, null, null, null);
	    }
	}
	var myAjax = new Ajax.Request("./wsu20ac003.jsp", opt);

}
window.onload = initialize;

//-->
</script>
</head>

<body>
<form name="form1" method="POST">
<input type="hidden" name="curPage" id="curPage" value="1">
<table class="TableLayout">
  <tr>
    <td width="180" class="Title" ><img src="images/bu_tit.gif" ><%=_i18n.get("menu.wsuser.list")%></td>
    <td width="580" class="MessageDisplay" ><div id=messageDisplay></div></td>
  </tr>
  <tr>
    <td colspan="2" height="6"></td>
  </tr>
</table>
<!--SelectTable ���� -->
<table class="SearchTable"  >
  <tr>
    <td style="padding:10px"><table>
        <tr>
          <td width="95"><img src="images/bu_search.gif" ><%=_i18n.get("global.user.id")%></td>
          <td width="250"><input name="username" id="username" type="text" class="FormText" size="32"></td>
          <td width="95"><img src="images/bu_search.gif" ><%= _i18n.get("global.user.party") %></td>
          <td width="250"><select name="partyid" id="partyid" class="FormSelect" style="width:187;">
              <option value=""><%= _i18n.get("global.all") %>&nbsp;&nbsp;&nbsp;&nbsp;</option>
            </select></td>
          <td align="right"><a href="javascript:searchUser(1);"><img src="images/btn_go.gif" border="0" ></a></td>
        </tr>
      </table></td>
  </tr>
</table>
<!-- ��Ż���̺� -->
<table class="TotalTable" >
  <tr>
    <td align="left">[ <%= _i18n.get("global.search") %> : <span id="row_size"></span> <%= _i18n.get("global.case") %> ]
            <select name="page_Cnt" id="page_Cnt" size="1" class="selectfield" onChange="javascript:searchMessage(1)">
	            <option value="5">5</option>
	            <option value="10" selected>10</option>
	            <option value="15">15</option>
	            <option value="20">20</option>
            </select>
            <span><%= _i18n.get("global.pages") %>
            <select name="item_Cnt" id="item_Cnt" size="1" class="selectfield" onChange="javascript:searchMessage(1)">
	            <option value="5">5</option>
	            <option value="10" selected>10</option>
	            <option value="20">20</option>
	            <option value="30">30</option>
	            <option value="50">50</option>
	            <option value="100">100</option>
            </select>
            <%= _i18n.get("global.rows") %></span>
    </td>
    <td width="300" align="right"> <a href="javascript:deleteUser()"><img src="images/btn_delete.gif" border="0" /></a></td>
  </tr>
</table>
<!-- ��� ��� ���̺� �ڵ� ����-->
<div id="listContent"></div>
</form>
<!--naiigation-->
<table class="PageNavigationTable" >
  <tr>
    <td align="right"><a href="javascript:createUser()"><img src="images/btn_create.gif" border="0" /></a></td>
  </tr>
  <tr>
    <td height="34" align="center">
      <table cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td><span id="pagelist"></span></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>