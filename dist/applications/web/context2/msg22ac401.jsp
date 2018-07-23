<%@ page contentType="text/xml; charset=EUC-KR" language="java"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%@ page import="kr.co.bizframe.mxs.MxsEngine"%>
<%@ page import="kr.co.bizframe.mxs.dao.DAOFactory"%>
<%@ page import="kr.co.bizframe.mxs.common.QueryCondition"%>
<%@ page import="kr.co.bizframe.mxs.ebms3.model.Eb3Message"%>
<%@ page import="kr.co.bizframe.mxs.ebms3.parser.Eb3Parser"%>
<%@ page import="kr.co.bizframe.util.StringUtil"%>
<%
/**
 * 시그널 메시지 보기
 & @author Mi-Young Kim
 * @version 1.0 2008.09.03
 */
	String signalMsgObid = StringUtil.nullCheck(request.getParameter("obid"));
	if (!signalMsgObid.equals("")) {
		QueryCondition qc = new QueryCondition();
		qc.add("obid", signalMsgObid);
		Eb3Message msg = (Eb3Message)MxsEngine.getInstance().getObject("Eb3SignalMessage", qc, DAOFactory.EBMS3);
		Eb3Parser parser = new Eb3Parser();
		Eb3Message ebMsg = parser.createEbMessage(msg);
	    response.setContentType("text/xml; charset=utf-8");

		BufferedInputStream bis = bis = new BufferedInputStream(new ByteArrayInputStream(ebMsg.getHeaderContainer().getContent()));
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		int read = 0;
		try {
			byte[] buf = new byte[4096];

			while ((read = bis.read(buf)) != -1) {
			bos.write(buf,0,read);
			}
			bos.close();
			bis.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			if(bos != null) bos.close();
			if(bis != null) bis.close();
		}
	}
%>
