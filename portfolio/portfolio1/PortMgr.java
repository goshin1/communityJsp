package portfolio1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.ServletRequest;

public class PortMgr {
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "C:/Users/gci91/eclipse-workspace/portfolio1/src/main/webapp/fileupload";
	private static final String ENCTYPE = "utf-8";
	private static int MAXSIZE = 5*1024*1024;
	
	public PortMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public Vector<BoardBean> getBoardList(String keyWord){
		Vector<BoardBean> v = new Vector<BoardBean>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			if(keyWord.equals("") || keyWord == null) {
				sql = "select * from boards order by num desc";
			} else {
				sql = "select * from boards where content like '%" + keyWord + "%' or subject like '%" + keyWord + "%' order by num desc";
			}
			con = pool.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int num = rs.getInt("num");
				String writer = rs.getString("writer");
				String subject = rs.getString("subject");
				String content = rs.getString("content");
				String file_name = rs.getString("file_name");
				int file_size = rs.getInt("file_size");
				int views = rs.getInt("views");
				int review = rs.getInt("review");
				String write_date = rs.getString("write_date");
				
				BoardBean bean = new BoardBean();
				bean.setNum(num);
				bean.setWriter(writer);
				bean.setSubject(subject);
				bean.setContent(content);
				bean.setFile_name(file_name);
				bean.setFile_size(file_size);
				bean.setViews(views);
				bean.setReview(review);
				bean.setWrite_date(write_date);
				v.add(bean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, stmt, rs);
		}
		
		return v;
	}
	
	public int getBoardCount() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			String sql = "select count(num) num from boards";
			con = pool.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next())
				count = rs.getInt("num");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, stmt, rs);
		}
		return count;
	}
	
	public BoardBean portContent(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardBean bean = null;
		try {
			bean = new BoardBean();
			String sql = "select * from boards where num = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(num);
				bean.setWriter(rs.getString("writer"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setFile_name(rs.getString("file_name"));
				bean.setFile_size(rs.getInt("file_size"));
				bean.setViews(rs.getInt("views"));
				bean.setReview(rs.getInt("review"));
				bean.setWrite_date(rs.getString("write_date"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return bean;
	}
	
	
	public void increaseView(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update boards set views = views + 1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 게시글 작성
	public int insertBoard(String writer, String subject, String content, String filename, int file_size) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		int res = -1;
		try {
			con = pool.getConnection();
			sql = "insert boards(writer, subject, content, file_name, file_size, views, review) values(?, ?, ?, ?, ?, 0, 0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, subject);
			pstmt.setString(3, content);
			pstmt.setString(4, filename);
			pstmt.setInt(5, file_size);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "select max(num) from boards";
			pstmt2 = con.prepareStatement(sql);
			rs = pstmt2.executeQuery();
			if(rs.next()) {
				res = rs.getInt(1);
			}
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt2);
		}
		return res;
	}
	
	// 게시글 작성
	public int deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int res = 0;
		try {
			String sql = "delete from boards where num = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			res = pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return res;
	}
	
	public void insertComment(int num, String comment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		
	}
	
	
	// 로그인
	public String login(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select count(*) count from members where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getInt(1) == 1){
				System.out.println("Sucess");
				return id;
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return "login_fall";
		
	}
	
	
	public String sign(String id, String pwd, String name, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select count(*) from members where id = ? or email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getInt(1) > 0) {
				return "overlap";
			}
			sql = "insert members values(?, ?, ?, ?)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setString(1, id);
			pstmt2.setString(2, pwd);
			pstmt2.setString(3, name);
			pstmt2.setString(4, email);
			pstmt2.executeUpdate();
			return "sucess";
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return "fall";
	}
	
	
	
	public void startPort() {
		Connection con = null;
		Statement stmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			stmt = con.createStatement();
			for(int i = 0; i < 150; i++) {
				sql = "insert boards(writer, subject, content, file_name, file_size, views, review) values('1111', '테스트"+i+"', 'content"+i+"','', 0, 0, 0)";
				int check = stmt.executeUpdate(sql);
				if (check != 0)
					System.out.println("start sucess!");
				else
					System.out.println("start fall");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, stmt);
		}
	}
	
	public static void main(String[] args) {
		
	}
	
}
