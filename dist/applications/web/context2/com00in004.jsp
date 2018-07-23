<%
/**
 * check login session for popup window
 *
 * @author Ho-Jin Seo
 * @version 1.0
 */

   String session_status = (String)session.getAttribute("status"); 

	String session_errmsg = I18nStrings.getInstance().get("com00in003.login.msg");
   if(session_status==null) {
      out.println("<script>");
      out.println("  alert('" + session_errmsg + "');");
      out.println("  opener.open('ses00ms001.jsp', '_top');");
      out.println("  this.window.close();");
      out.println("</script>");
      return;
   }
   else if(session.getAttribute("passwd") == null) {
      out.println("<script>");
      out.println("  alert('" + session_errmsg + "');");
      out.println("  opener.open('ses00ms001.jsp', '_top')");
      out.println("  this.window.close();");
      out.println("</script>");
      return;
   }
   else{
      String session_userid = (String)session.getAttribute("userid");
      String session_passwd = (String)session.getAttribute("passwd");
      if(session_userid==null || session_passwd==null) {
         out.println("<script>");
         out.println("  alert('" + session_errmsg + "');");
      out.println("  opener.open('ses00ms001.jsp', '_top')");
      out.println("  this.window.close();");
         out.println("</script>");
         return;
      }   
	}
%>