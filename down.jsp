<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="java.io.*,java.net.*" %><%
	request.setCharacterEncoding("UTF-8");
	String fileName = request.getParameter("fileName");
	// 파일생성
	if (fileName == null) {
		fileName = "text.txt";
	}

	File objFile = new File(fileName + ".txt");
	
	if (objFile.exists())
		objFile.delete();
	
	if (objFile.createNewFile()) {
		BufferedWriter objBW = new BufferedWriter(new FileWriter(objFile));
		objBW.write("Hello File\r\n");
		objBW.close();
	}
	
	// 파일 다운로드
	// response.setContentType("application/x-msdownload");
	response.reset();
	response.setContentType("application/octet-stream");
	
	// String strFileName = URLEncoder.encode(new String(objFile.getName().getBytes("8859_1"), "euc-kr"), "UTF-8");
	String strFileName = URLEncoder.encode(new String(objFile.getName().getBytes("8859_1"), "UTF-8"), "UTF-8");
	response.setHeader("Content-Disposition", "attachment;filename=" + strFileName + ";");
	
	int nRead = 0;
	byte btReadByte[] = new byte[(int) objFile.length()];
	
	if (objFile.length() > 0 && objFile.isFile()) {
		BufferedInputStream objBIS = new BufferedInputStream(new FileInputStream(objFile));
		BufferedOutputStream objBOS = new BufferedOutputStream(response.getOutputStream());
	
		while ((nRead = objBIS.read(btReadByte)) != -1)
			objBOS.write(btReadByte, 0, nRead);
	
		objBOS.flush();
		objBOS.close();
		objBIS.close();
	}
%>