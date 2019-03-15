<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="java.net.*,java.io.*"%><%
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

	String filePath = objFile.getName();

	try{
	 	// 다운받을 파일을 불러옴
		File file = new File(filePath);
		byte b[] = new byte[4096];
		
		// page의 ContentType등을 동적으로 바꾸기 위해 초기화시킴
		response.reset();
		response.setContentType("application/octet-stream");
		
		// 한글 인코딩
		//String Encoding = new String(fileName.getBytes("UTF-8"), "8859_1");
		String strFileName = URLEncoder.encode(new String(objFile.getName().getBytes("8859_1"), "UTF-8"), "UTF-8");
		// 파일 링크를 클릭했을 때 다운로드 저장 화면이 출력되게 처리하는 부분
		// response.setHeader("Content-Disposition", "attachment; filename = " + Encoding);
		response.setHeader("Content-Disposition", "attachment; filename = " + strFileName);
		
		// 파일의 세부 정보를 읽어오기 위해서 선언
		FileInputStream in = new FileInputStream(filePath);
		
		// 파일에서 읽어온 세부 정보를 저장하는 파일에 써주기 위해서 선언
		ServletOutputStream out2 = response.getOutputStream();
		
		int numRead;
		// 바이트 배열 b의 0번 부터 numRead번 까지 파일에 써줌 (출력)
		while((numRead = in.read(b, 0, b.length)) != -1){
			out2.write(b, 0, numRead);
		}
		
		out2.flush();
		out2.close();
		in.close();
	} catch(Exception e){
	}
 %>