package naram.kim.recruit.model;

import java.sql.*;
import java.util.ArrayList;

public class RecruitmentDAO {
	
	private static RecruitmentDAO dao = new RecruitmentDAO();

	private RecruitmentDAO() {
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public static RecruitmentDAO getInstance() {
		if(dao == null) {
			dao = new RecruitmentDAO();
		}
		return dao;
	}
	
	String url = "jdbc:mysql://ec2-54-196-39-146.compute-1.amazonaws.com/Crawler";
	String user = "cloud";
	String upw = "1111";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public ArrayList<RecruitmentVO> listRecruitment(int from, int to) {
		
		ArrayList<RecruitmentVO> list = new ArrayList<>();
		
		String sql = "select * from re_info where id >= ? and id <= ?";
		
		try {
			
			conn = DriverManager.getConnection(url,user,upw);
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, from);
			pstmt.setInt(2, to);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				String company = rs.getString(2);
				String title = rs.getString(3);
				String titlelink = rs.getString(4);
				String site_name = rs.getString(5);
				String field1 = rs.getString(6);
				String field2 = rs.getString(7);
				String field3 = rs.getString(8);
				String career = rs.getString(9);
				String academic = rs.getString(10);
				String area = rs.getString(11);
				String workingcondition = rs.getString(12);
				String deadline = rs.getString(13);
				float star = rs.getFloat(14);
				
				RecruitmentVO vo = new RecruitmentVO(company, title, titlelink, site_name, field1,
						field2, field3, career, academic, area, workingcondition, deadline, star);
				
				list.add(vo);
			}
			
		} catch (Exception e) {
			 
			e.printStackTrace();
		
		} finally {
				
				try {
					
				if(conn != null) conn.close();
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				
			} catch (Exception e2) {
				
				e2.printStackTrace();
				
			}

		}
		
		return list;
	}
	
	public int listRecruitmentTotal() {
		
		String sql = "select count(id) from re_info";
		int count = 0;
		 
		
		try {
			
			conn = DriverManager.getConnection(url,user,upw);
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				
				count = rs.getInt(1);
				
			}
		} catch (Exception e) {
				 
				e.printStackTrace();
			
			} finally {
					
					try {
						
					if(conn != null) conn.close();
					if(pstmt != null) pstmt.close();
					if(rs != null) rs.close();
					
				} catch (Exception e2) {
					
					e2.printStackTrace();
					
				}

			}
			
			return count;		
	}
	
	public int searchRecruitmentTotal(String search) {
		
		String sql = "select count(*) from re_info where company like ? or title like ?";
		int count = 0;
		
		try {
			conn = DriverManager.getConnection(url,user,upw);
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
				 
				e.printStackTrace();
			
			} finally {
					
					try {
						
					if(conn != null) conn.close();
					if(pstmt != null) pstmt.close();
					if(rs != null) rs.close();
					
				} catch (Exception e2) {
					
					e2.printStackTrace();
					
				}

			}
			
			return count;		
	}
	
	public ArrayList<RecruitmentVO> searchRecruitment(String search, int begin) {
		
		ArrayList<RecruitmentVO> list = new ArrayList<>();
		
		String sql = "select * from re_info where company like ? or title like ? limit ?, 10";
		 
		
		try {
			conn = DriverManager.getConnection(url,user,upw);
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, "%"+search+"%");
			pstmt.setInt(3, begin);
			
			rs = pstmt.executeQuery(); 
			
			while(rs.next()) {
				
				String company = rs.getString(2);
				String title = rs.getString(3);
				String titlelink = rs.getString(4);
				String site_name = rs.getString(5);
				String field1 = rs.getString(6);
				String field2 = rs.getString(7);
				String field3 = rs.getString(8);
				String career = rs.getString(9);
				String academic = rs.getString(10);
				String area = rs.getString(11);
				String workingcondition = rs.getString(12);
				String deadline = rs.getString(13);
				float star = rs.getFloat(14);
				
				RecruitmentVO vo = new RecruitmentVO(company, title, titlelink, site_name, field1
						, field2, field3, career, academic, area, workingcondition, deadline, star);
				
				list.add(vo);
			}
		} catch (Exception e) {
				 
				e.printStackTrace();
			
			} finally {
					
					try {
						
					if(conn != null) conn.close();
					if(pstmt != null) pstmt.close();
					if(rs != null) rs.close();
					
				} catch (Exception e2) {
					
					e2.printStackTrace();
					
				}

			}
			
			return list;		
	}
	
}
