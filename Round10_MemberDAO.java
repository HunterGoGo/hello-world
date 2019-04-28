package com.cho.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.cho.dto.Round10_MemberDTO;

public class Round10_MemberDAO {
	private static Connection conn = null;
	
	Logger logger = Logger.getLogger(Round10_MemberDAO.class.getName());
	
	public Round10_MemberDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Error! : " + e.getLocalizedMessage());
		}
		
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sample?useSSL=false", "sample", "sample1234");
		} catch (SQLException e) {
			// System.out.println("Connetion Error! : " + e.getLocalizedMessage());
			logger.log(Level.INFO, "에러, {0}", e.toString());
			// e.printStackTrace();
		}
	}
	
	public boolean insertMember(Round10_MemberDTO dto) {
		String sqlQuery = "insert into sample21 values (?, ?, ?, ?)";
		boolean checkSuccess = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sqlQuery);
			// pstmt.setInt(1, dto.getNo());
			pstmt.setInt(1, selectMaxNo());
			pstmt.setString(2, dto.getName());
			pstmt.setDate(3, dto.getBirthday());
			pstmt.setString(4, dto.getAddress());
			
			int count = pstmt.executeUpdate();
			if (count < 1) {
				System.out.println("Member Insert fail!");
				checkSuccess = false;
			} else {
				checkSuccess = true;
			}
			pstmt.close();
		} catch (SQLException e) {
			System.out.println("Member Insert Error! :" + e.getLocalizedMessage());
			checkSuccess = false;
		} finally {
			try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return checkSuccess;
	}
	
	public List<Round10_MemberDTO> selectList(Round10_MemberDTO dto) {
		List<Round10_MemberDTO> list = new ArrayList<>();
		String sqlQuery = "select no, name, address, birthday from sample21";
		try {
			PreparedStatement  pstmt = null;
			if (dto.getName() != null && !dto.getName().isEmpty()) {
				sqlQuery += " where name like concat('%',?,'%')";
				sqlQuery += " order by no desc, no limit ? , ?";
				pstmt = conn.prepareStatement(sqlQuery);
				pstmt.setString(1, dto.getName());
				pstmt.setInt(2, dto.getStart());
				pstmt.setInt(3, dto.getEnd());
			} else if (dto.getAddress() != null && !dto.getAddress().isEmpty()) {
				sqlQuery += " where address like concat('%',?,'%')";
				sqlQuery += " order by no desc, no limit ? , ?";
				pstmt = conn.prepareStatement(sqlQuery);
				pstmt.setString(1, dto.getAddress());
				pstmt.setInt(2, dto.getStart());
				pstmt.setInt(3, dto.getEnd());
			} else {
				sqlQuery += " order by no desc, no limit ? , ?";
				pstmt = conn.prepareStatement(sqlQuery);
				pstmt.setInt(1, dto.getStart());
				pstmt.setInt(2, dto.getEnd());
			}
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Round10_MemberDTO memberDTO = new Round10_MemberDTO();
				memberDTO.setNo(rs.getInt("no"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setBirthday(rs.getDate("birthday"));
				memberDTO.setAddress(rs.getString("address"));
				list.add(memberDTO);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println("Member List Error! :" + e.getLocalizedMessage());
		} finally {
			try {if (conn != null) conn.close();} catch (SQLException e) {e.printStackTrace();}
		}
		return list;
	}
	
	public int selectMaxNo() {
		String sqlQuery = "select max(coalesce(no,0)) + 1 no from sample21";
		int maxNo = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sqlQuery);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				maxNo = rs.getInt("no"); 
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println("Select Max No Error! :" + e.getLocalizedMessage());
		}
		return maxNo;
	}
	
	public int getTotalCount(Round10_MemberDTO dto) {
		String sqlQuery = "select count(*) count from sample21";
		int count = 0;
		try {
			PreparedStatement  pstmt = null;
			if (dto.getName() != null && !dto.getName().isEmpty()) {
				sqlQuery += " where name like concat('%',?,'%')";
				pstmt = conn.prepareStatement(sqlQuery);
				pstmt.setString(1, dto.getName());
			} else if (dto.getAddress() != null && !dto.getAddress().isEmpty()) {
				sqlQuery += " where address like concat('%',?,'%')";
				pstmt = conn.prepareStatement(sqlQuery);
				pstmt.setString(1, dto.getAddress());
			} else {
				pstmt = conn.prepareStatement(sqlQuery);
			}
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count"); 
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			System.out.println("Get Total Count Error! :" + e.getLocalizedMessage());
		}
		return count;
	}
}
