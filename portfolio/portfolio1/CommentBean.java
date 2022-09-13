package portfolio1;

public class CommentBean {
	private int cNum; // 댓글의 번호(기본키)
	private int bNum; // 댓글의 게시글(어떤 게시글의 댓글인지)
	private String cWriter;
	private String comment; // 댓글 
	private int ref; // 답글일 경우 어떤 댓글의 답글인지
	private int pos; // 답글일 경우 몇번째 답글인지
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	public String getcWriter() {
		return cWriter;
	}
	public void setcWriter(String cWriter) {
		this.cWriter = cWriter;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	
	
}
