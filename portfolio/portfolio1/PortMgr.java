package portfolio1;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;
import java.util.Arrays;
import java.time.LocalDate;

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
	

	// 관리자 계정 확인
	public boolean checkManager(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean b = false;
		try {
			String sql = "select * from manager where manager = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				b = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return b;
	}
	
	
	// 신고 된 회원 정지일자 작성
	public void setStopDate(String writer, String date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into problem_members values(?, ?)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, date);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 정지 일자가 끝난 회원 삭제
	public void deleteStopDate(String date) {
		Connection con = null;
		Statement stmt = null;
		try {
			String sql = "delete from problem_members where report_date like '"+date+"%'";
			con = pool.createConnection();
			stmt= con.createStatement();
			stmt.executeUpdate(sql);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, stmt);
		}
	}
	
	
	// 게시글 작성자 조회
	public String selectWriter(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String writer = null;
		try {
			String sql = "select * from boards where num = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next())
				writer = rs.getString("writer");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return writer;
	}
	
	
	// 게시글 신고
	public void insertReportBoard(int rNum, int boardType, String reportType, String comment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into report_boards(rNum, boardType, reportType, comment) values(?, ?, ?, ?)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, rNum);
			pstmt.setInt(2, boardType);
			pstmt.setString(3, reportType);
			pstmt.setString(4, comment);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 신고 게시판 글 가져오기
	public Vector<ReportBean> getReportBoardList(){
		Vector<ReportBean> v = new Vector<ReportBean>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from report_boards order by num desc";
			con = pool.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ReportBean bean = new ReportBean();
				bean.setNum(rs.getInt("num"));
				bean.setrNum(rs.getInt("rNum"));
				bean.setBoardType(rs.getInt("boardType"));
				bean.setReportType(rs.getString("reportType"));
				bean.setComment(rs.getString("comment"));
				bean.setWrite_date(rs.getString("write_date"));;
				v.add(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, stmt, rs);
		}		
		return v;
	}
	
	// 신고당한 게시글 내역 삭제
	public void deleteReport(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from report_boards where num = ?";
			con = pool.createConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 채용 게시판 글 가져오기
	public Vector<JobBoardBean> getJobBoardList(String[] searchTypes, String[] jobs, String[] degs, String[] exps, String bArea, String[] sArea){
		Vector<JobBoardBean> v = new Vector<JobBoardBean>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			sql = "select * from job_boards ";
			if(Arrays.asList(searchTypes).contains("1")) {
				sql = "select * from job_boards where ";
				// 직무 
				if(!searchTypes[0].equals("0")) {
					if(sql.length() > 31)
						sql += " and ";
					sql += "job in (";
					for(int i = 0; i < jobs.length - 1; i++) {
						sql += "'"+jobs[i]+"', ";
					}
					sql += " '"+jobs[jobs.length - 1] + "')";
				}
				
				// 학위
				if(!searchTypes[1].equals("0")) {
					if(sql.length() > 31)
						sql += " and ";
					sql += "degree in (";
					for(int i = 0; i < degs.length - 1; i++) {
						sql += "'"+degs[i]+"', ";
					}
					sql += " '"+degs[degs.length - 1] + "')";
				}
				
				// 경력
				if(!searchTypes[2].equals("0")) {
					if(sql.length() > 31)
						sql += " and ";
					sql += "exp in (";
					for(int i = 0; i < exps.length - 1; i++) {
						sql += "'"+degs[i]+"', ";
					}
					sql += " '"+exps[exps.length - 1] + "')";
				}
				
				// 지역 검색
				if(!searchTypes[3].equals("0")) {
					if(sql.length() > 31)
						sql += " and ";
					sql += "main_area = '"+bArea+"' and sub_area in (";
					for(int i = 0; i < sArea.length - 1; i++) {
						sql += "'"+sArea[i]+"', ";
					}
					sql += " '"+sArea[sArea.length - 1] + "')";
				}
				
				
				
				
			}
			sql += " order by num desc";
			con = pool.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				JobBoardBean jBean = new JobBoardBean();
				jBean.setNum(rs.getInt("num"));
				jBean.setJob(rs.getString("job"));
				jBean.setDegree(rs.getString("degree"));
				jBean.setExp(rs.getString("exp"));
				jBean.setMain_area(rs.getString("main_area"));
				jBean.setSub_area(rs.getString("sub_area"));
				jBean.setCompany(rs.getString("company"));
				jBean.setWriter(rs.getString("writer"));
				jBean.setSubject(rs.getString("subject"));
				jBean.setContent(rs.getString("content"));
				jBean.setFile_name(rs.getString("file_name"));
				jBean.setFile_size(rs.getInt("file_size"));
				jBean.setWrite_date(rs.getString("write_date"));
				v.add(jBean);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, stmt, rs);
		}
		return v;
	}
	
	// 채용 게시글 작성
	public int insertJobBoard(String job, String deg, String exp, String bArea, String sArea, String company, String writer, String subject, String content, String file_name, int file_size) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		int res = -1;
		try {
			con = pool.getConnection();
			sql = "insert into job_boards(job, degree, exp, main_area, sub_area, company, writer, subject, content, file_name, file_size) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, job);
			pstmt.setString(2, deg);
			pstmt.setString(3, exp);
			pstmt.setString(4, bArea);
			pstmt.setString(5, sArea);
			pstmt.setString(6, company);
			pstmt.setString(7, writer);
			pstmt.setString(8, subject);
			pstmt.setString(9, content);
			pstmt.setString(10, file_name);
			pstmt.setInt(11, file_size);
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
	
	// 채용 게시글 읽어오기
	public JobBoardBean portJobContent(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		JobBoardBean bean = null;
		try {
			bean = new JobBoardBean();
			String sql = "select * from job_boards where num = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setJob(rs.getString("job"));
				bean.setDegree(rs.getString("degree"));
				bean.setExp(rs.getString("exp"));
				bean.setMain_area(rs.getString("main_area"));
				bean.setSub_area(rs.getString("sub_area"));
				bean.setCompany(rs.getString("company"));
				bean.setWriter(rs.getString("writer"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setFile_name(rs.getString("file_name"));
				bean.setFile_size(rs.getInt("file_size"));
				bean.setWrite_date(rs.getString("write_date"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return bean;
	}

	// 채용 게시글 수정
	public int modifyJobBoard(int num, String job, String deg, String exp, String bArea, String sArea, String company, String writer, String subject, String content, String file_name, int file_size) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int res = -1;
		try {
			String sql = "update job_boards set job=?, degree=?, exp=?, main_area=?, sub_area=?, company=?, subject=?, content=?, file_name=?, file_size=? where num=? and writer=?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, job);
			pstmt.setString(2, deg);
			pstmt.setString(3, exp);
			pstmt.setString(4, bArea);
			pstmt.setString(5, sArea);
			pstmt.setString(6, company);
			pstmt.setString(7, subject);
			pstmt.setString(8, content);
			pstmt.setString(9, file_name);
			pstmt.setInt(10, file_size);
			pstmt.setInt(11, num);
			pstmt.setString(12, writer);
			res = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return res;
	}
	
	// 채용 게시글 삭제
	public int deleteJobBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int res = -1;
		try {
			String sql = "delete from job_boards where num = ?";
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
	
	
	
	// 게시글 목록 가져오기
	public Vector<BoardBean> getBoardList(String keyWord, int menu_type){
		Vector<BoardBean> v = new Vector<BoardBean>();
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			if(keyWord == null) {
				sql = "select * from boards memu_type = "+menu_type+" order by num desc";
			} else {
				sql = "select * from (select * from boards as b2 where menu_type = "+menu_type+") as b1 where content like '%" + keyWord + "%' or subject like '%" + keyWord + "%' order by num desc";
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
	
	// 전체 페이지 수 가져오기
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
	
	// 조회수 증가
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
	public int insertBoard(String writer, String subject, String content, String file_name, int file_size, int menu_type) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		int res = -1;
		try {
			con = pool.getConnection();
			sql = "insert into boards(writer, subject, content, file_name, file_size, views, review, menu_type) values(?, ?, ?, ?, ?, 0, 0, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, writer);
			pstmt.setString(2, subject);
			pstmt.setString(3, content);
			pstmt.setString(4, file_name);
			pstmt.setInt(5, file_size);
			pstmt.setInt(6, menu_type);
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
	
	// 게시글 수정
	public int modifyBoard(int num, String writer, String subject, String content, String file_name, int file_size) {
		Connection con = null;		PreparedStatement pstmt = null;
		int res = -1;
		try {
			String sql = "update boards set subject=?, content=?, file_name=?, file_size=? where num = ? and writer = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, file_name);
			pstmt.setInt(4, file_size);
			pstmt.setInt(5, num);
			pstmt.setString(6, writer);
			res = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return res;
	}
			
	
	// 게시글 삭제
	public int deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int res = 0;
		try {
			deleteCommentList(num);
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
	
	// 가장 인기 있는 게시글
	public BoardBean popularBoard(int menu_type) {
		BoardBean bean = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * \r\n"
					+ "from boards\r\n"
					+ "where views = (select max(views) from boards where menu_type = ?);";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, menu_type);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
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
	
	
	// 게시글 댓글 목록 삭제하기
	public void deleteCommentList(int bNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from comment_boards where bNum = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bNum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 댓글 목록 불러오기
	public Vector<CommentBean> CommentList(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<CommentBean> v = new Vector<CommentBean>();
		try {
			String sql = "select * from comment_boards where bNum = ? order by cnum, ref, pos asc";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean cBean = new CommentBean();
				cBean.setcNum(rs.getInt("cNum"));
				cBean.setbNum(rs.getInt("bNum"));
				cBean.setcWriter(rs.getString("cWriter"));
				cBean.setComment(rs.getString("comment"));
				cBean.setRef(rs.getInt("ref"));
				cBean.setPos(rs.getInt("pos"));
				v.add(cBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return v;
	}
	
	// 댓글 별 답변 댓글 목록 불러오기
	public Vector<CommentBean> ReCommentList(int cnum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<CommentBean> v = new Vector<CommentBean>();
		try {
			String sql = "select * from comment_boards where ref = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean cBean = new CommentBean();
				cBean.setcNum(rs.getInt("cNum"));
				cBean.setbNum(rs.getInt("bNum"));
				cBean.setcWriter(rs.getString("cWriter"));
				cBean.setComment(rs.getString("comment"));
				cBean.setRef(rs.getInt("ref"));
				cBean.setPos(rs.getInt("pos"));
				v.add(cBean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return v;
	}
	
	
	// 일반 댓글 작성
	public void insertComment(int num, String writer, String comment, int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "insert into comment_boards(bNum, cWriter, comment, ref, pos) values(?, ?, ?, ?, ?)";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, writer);
			pstmt.setString(3, comment);
			pstmt.setInt(4, ref);
			pstmt.setInt(5, pos);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
	
	// 답변 댓글 작성
	public void insertRefComment(int num, String writer, String comment, int ref) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select max(pos) pos from comment_boards where ref = ?";
			con = pool.createConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
			int pos = rs.getInt("pos") + 1;
			insertComment(num, writer, comment, ref, pos);
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
	}
	
	
	// 댓글 삭제하기
	public int deleteComment(int cNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int res = 0;
		try {
			String sql = "delete from comment_boards where cNum = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cNum);
			res = pstmt.executeUpdate();
			decreaseReview(cNum);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return res;
	}
	
	// 댓글 수 증가
	public void increaseReview(int bNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "update boards set review = review + 1 where num = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bNum);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 댓글 수 감소
	public void decreaseReview(int bNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String sql = "update boards set review = review - 1 where num = ?";
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bNum);
			pstmt.executeUpdate();
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
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
				
				return id;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return "login_fall";
	}
	
	// 로그인 시 정지된 계정인지 확인
	public String problemMemberCheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from problem_members where writer = ?";
			con = pool.createConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String date = rs.getString("report_date").substring(0, 10);
				String now  = LocalDate.now().toString();
				if (now.equals(date)) {
					return "sucess";
				}
				return date;
			} else {
				return "sucess";
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		
		return "fall";
	}
	
	// 회원가입
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
			sql = "insert into members values(?, ?, ?, ?)";
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
				sql = "insert into boards(writer, subject, content, file_name, file_size, views, review) values('1111', '테스트"+i+"', 'content"+i+"','', 0, 0, 0)";
				int check = stmt.executeUpdate(sql);
				
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
