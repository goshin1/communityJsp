<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="portfolio1.*" %>
<% 
	final String SAVEFOLDER = "./fileupload";
	request.setCharacterEncoding("utf-8");
	PortMgr pMgr = new PortMgr();
	
	int num = Integer.parseInt(request.getParameter("num"));
	
	JobBoardBean bean = pMgr.portJobContent(num);
	String filename = bean.getFile_name();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style/jobs_modify.css?ver=1" type="text/css" rel="stylesheet">
    <title>Modify</title>
    <script>
    	
    </script>
</head>
<body>
	<%@include file="header.jsp"%>

    <div id="content">
        <aside id="aside_first">
            광고
        </aside>
        <div id="notice">
            <div id="main_post">
                <form method="get" action="">
                    <div class="option_box">
                        직무
                        <ul class="main_option">
                            <li><label for="job1"><input type="radio" name="job" id="job1" value="프론트엔드개발">프론트엔드개발</label></li>
                            <li><label for="job2"><input type="radio" name="job" id="job2" value="백엔드개발">백엔드개발</label></li>
                            <li><label for="job3"><input type="radio" name="job" id="job3" value="웹프로그래머">웹프로그래머</label></li>
                            <li><label for="job4"><input type="radio" name="job" id="job4" value="시스템프로그래머">시스템프로그래머</label></li>
                            <li><label for="job5"><input type="radio" name="job" id="job5" value="모바일개발">모바일개발</label></li>
                            <li><label for="job6"><input type="radio" name="job" id="job6" value="풀스택개발">풀스택개발</label></li>
                            <li><label for="job7"><input type="radio" name="job" id="job7" value="임베디드개발">임베디드개발</label></li>
                            <li><label for="job8"><input type="radio" name="job" id="job8" value="PC어플리케이션개발">PC어플리케이션개발</label></li>
                            <li><label for="job9"><input type="radio" name="job" id="job9" value="DBA">DBA</label></li>
                            <li><label for="job10"><input type="radio" name="job" id="job10" value="TA">TA</label></li>
                            <li><label for="job11"><input type="radio" name="job" id="job11" value="AA">AA</label></li>
                            <li><label for="job12"><input type="radio" name="job" id="job12" value="기타개발">기타개발</label></li>
                            <li><label for="job13"><input type="radio" name="job" id="job13" value="퍼블리셔">퍼블리셔</label></li>
                            <li><label for="job14"><input type="radio" name="job" id="job14" value="QA">QA</label></li>
                        </ul>
                    </div>

                    <div class="option_box">
                        학위
                        <ul class="main_option">
                            <li><label for="deg1"><input type="radio" name="deg" id="deg1" value="고졸">고졸</label></li>
                            <li><label for="deg2"><input type="radio" name="deg" id="deg2" value="2/3년제학사">2/3년제 학사</label></li>
                            <li><label for="deg3"><input type="radio" name="deg" id="deg3" value="4년제 학사">4년제 학사</label></li>
                            <li><label for="deg4"><input type="radio" name="deg" id="deg4" value="석사">석사</label></li>
                            <li><label for="deg5"><input type="radio" name="deg" id="deg5" value="학사">학사</label></li>
                        </ul>
                    </div>

                    <div class="option_box">
                        경력
                        <ul class="main_option">
                            <li><label for="exp1"><input type="radio" name="exp" id="exp1" value="무관">무관</label></li>
                            <li><label for="exp2"><input type="radio" name="exp" id="exp2" value="신입">신입</label></li>
                            <li><label for="exp3"><input type="radio" name="exp" id="exp3" value="1년이상">1년이상</label></li>
                            <li><label for="exp4"><input type="radio" name="exp" id="exp4" value="2년이상">2년이상</label></li>
                        </ul>
                    </div>

                    <div class="option_box">
                        지역
                        <ul id="main_area" class="main_option">
                            <li>서울</li>
                            <li>경기</li>
                            <li>인천</li>
                            <li>대구</li>
                            <li>부산</li>
                            <li>광주</li>
                            <li>대전</li>
                            <li>울산</li>
                            <li>세종</li>
                            <li>강원</li>
                            <li>경남</li>
                            <li>경북</li>
                            <li>전남</li>
                            <li>전북</li>
                            <li>충남</li>
                            <li>충북</li>
                            <li>제주</li>
                        </ul>
                    </div>

                    <div id="detail_area" class="option_box">
                        
                    </div>
                    
                </form>
            </div>
            <form name="jobBoard" id="write" method="post" action="jobs_modifyChain.jsp?num=<%=num %>" enctype="multipart/form-data">
                <input type="text" name="title" placeholder=" 제목을 입력해주세요." value="<%=bean.getSubject()%>">
				<input type="text" name="company" placeholder=" 회사명을 입력해주세요." value="<%=bean.getCompany()%>">
                <div id="write_body">
                	<textarea name="content"><%=bean.getContent() %></textarea>
                	<div>
                        <input type="file" multiple="multiple" onchange="createList(this)" name="fileobj" accept=".jpg, .jpeg, .png, .webp"> 이미지는 최대 5개까지 업로드 가능합니다.
                    </div>
                </div>
                <input type="button" value="작성" id="job_write">
                <input type="hidden" name="file_list" value="<%=bean.getFile_name()%>">
                
                <input type="hidden" name="sJob">
                <input type="hidden" name="sDeg">
                <input type="hidden" name="sExp">
                <input type="hidden" name="sBArea">
                <input type="hidden" name="sSArea">

            </form>
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div>
    <script>
 // 직무 경력 학위
    let searchType = [0,0,0,0,0];
    let radios = ["job","deg","exp"];
    
 // 지역 선택
    let main_area = document.getElementById("main_area");
    let areas = main_area.children;
    let sub_area = [['강남구','강동구','강북구','강서구','관악구','광진구','구로구',
                        '금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구',
                        '서초구','성동구','성북구','송파구','양천구','영등포구','용산구',
                        '은평구','종로구','중구','중랑구'],
                    ['가평군','고양시 덕양구','고양시 일산동구','고양시 일산서구',
                        '과천시','광명시','광주시','구리시','군포시','김포시','남양주시',
                        '동두천시','부천시','성남시 분당구','성남시 수정구','성남시 중원구',
                        '수원시 권선구','수원시 영통구','수원시 장안구','수원시 팔달구',
                        '시흥시','안산시 단원구','안산시 상록구','안양시 동안구',
                        '안양시 만안구','양주시','양평군','여주시','연천군','오산시',
                        '용인시 기흥구','용인시 수지구','용인시 처인구','의왕시','의정부시',
                        '이천시','파주시','평택시','포천시','하남시','화성시'],
                    ['강화군','계양구','남동구','동구','미추홀구','부평구','서구',
                        '연수구','옹진군','중구'],
                    ['남구','달서구','동구','북구','서구','수성구','중구','달성군'],
                    ['강서구','금정구','기장군','남구','동구','동래구','부산진구','북구','사상구',
                        '사하구','서구','수영구','연제구','영도구','중구','해운대구'],
                    ['광산구','남구','동구','북구','서구'],
                    ['대덕구','동구','서구','유성구','중구'],
                    ['남구','동구','북구','울주군','중구'],
                    ['가람동','고운동','금남면','나성동','다정동','대평동','도담동','반곡동',
                        '보람동','부강면','산울동','새롬동','소담동','소정면','아름동','어진동','연기면','연동면',
                        '장군면','전동면','전의면','조치원읍','종촌동','집현동','한솔동','합강동','해밀동'],
                    ['강릉시','동해시','삼척시','속초시','원주시','춘천시','태백시','고성군','양구군',
                        '양양군','영월군','인제군','정선군','철원군','평창군','홍천군','화천군','횡성군'],
                    ['거제시','거창군','고성군','김해시','남해군','밀양시','사천시','산청군',
                        '양산시','의령군','진주시','창녕군','창원시','창원시 마산합포구','창원시 마산회원구',
                        '창원시 성산구','창원시 의창구','창원시 진해구','통영시','하동군','함안군','함양군','합천군'],
                    ['경산시','경주시','고령군','구미시','군위군','김천시','문경시','봉화군','상주시',
                        '성주군','안동시','영덕군','영양군','영주시','영천시','예천군','울릉군','울진군','의성군','청도군',
                        '청송군','칠곡군','포항시 남구','포항시 북구'],
                    ['강진군','고흥군','곡성군','광양시','구례군','나주시','담양군','목포시',
                        '무안군','보성군','순천시','신안군','여수시','영광군','영암군','완도군','장성군',
                        '장흥군','진도군','함평군','해남군','화순군'],
                    ['고창군','군산시','김제시','남원시','무주군','부안군','순창군','완주군',
                        '익산시','임실군','장수군','전주시 덕진구','전주시 완산구','정읍시','진안군'],
                    ['계룡시','공주시','금산군','논산시','당진시','보령시','부여군','서산시',
                        '서천군','아산시','예산군','천안시 동남구','천안시 서북구','청양군','태안군','홍성군'],
                    ['괴산군','단양군','보은군','영동군','옥천군','음성군','제천시','증평군','진천군',
                        '청원군','청주시 상당구','청주시 서원구','청주시 청원구','청주시 흥덕구','충주시'],
                    ['제주시','서귀포시']];
  
    
    window.onload = function(e){
		let selects = [
			'<%=bean.getJob()%>',
			'<%=bean.getDegree()%>',
			'<%=bean.getExp()%>',
			'<%=bean.getMain_area()%>',
			'<%=bean.getSub_area()%>'
		];

	    for(let i = 0; i < radios.length; i++){
	        let selRadio = document.getElementsByName(radios[i]);
	        for(let j = 0; j < selRadio.length; j++){
	        	if (selRadio[j].value  == selects[i]){
                	selRadio[j].checked = true;
                    let par = selRadio[j].parentElement;
                    par.style.backgroundColor = "#404040";
                    par.style.color = "#ffffff";
                    par.style.transition = "all 0.2s";
                }
	        }
	    }
	    
	    let area_idx = 0;
	    for(let i = 0; i < areas.length; i ++){
	        areas[i].style.color = "#000000";
	        if(areas[i].innerHTML == selects[3]){
	        	area_idx = i;
	            let detail = document.getElementById("detail_area");
	            if(areas[i].style.color == "rgb(0, 0, 0)"){
	            	areas[i].style.color = "#00B9FF";
	                check_area(i);
	                detail.innerHTML = "";
	                detail.innerHTML = "<ul>";
	                for(let j = 0; j < sub_area[i].length; j++){
	                    detail.innerHTML += '<li><label for="area'+j+'"><input type="radio" class="sel_area" name="area" id="area'+j+'" value="'+sub_area[i][j]+'">'+sub_area[i][j]+'</label></li>';
	                }
	                detail.innerHTML += "</ul>";
	                
	                
	                let sel_areas = document.getElementsByClassName("sel_area");
	                for (let k = 0; k < sel_areas.length; k++){
	                	let select = document.getElementsByClassName("sel_area");
                    	try{
                    		for(let j = 0; select.length; j++){
                        		if(select[j].value == selects[4]){
                        			select[j].checked = true;
                        			select[j].parentElement.parentElement.style.backgroundColor = "#404040";
                        			select[j].parentElement.style.color = "#ffffff";
                        		}
                        	}
                    	}catch(e){
                    		console.log(e);
                    	}
	                    
                    	sel_areas[k].addEventListener("click", function(){
                        	let select = document.getElementsByClassName("sel_area");
                        	
                        	try{
                        		for(let j = 0; select.length; j++){
                            		if(select[j].checked === true){
                            			select[j].parentElement.parentElement.style.backgroundColor = "#404040";
                            			select[j].parentElement.style.color = "#ffffff";
                            		} else {
                            			select[j].parentElement.parentElement.style.backgroundColor = "#ffffff";
                            			select[j].parentElement.style.color = "#000000";
                            		}
                            	}
                        	}catch(e){
                        		console.log(e);
                        	}
                        	
                        });
                    	
	                }
	                
	                
	                
	            }
	            else{
	                this.style.color = "#000000";
	                detail.innerHTML = "";
	            }

	        }
	    }
	}

    for(let i = 0; i < radios.length; i++){
        let selRadio = document.getElementsByName(radios[i]);
        for(let j = 0; j < selRadio.length; j++){
        	selRadio[j].addEventListener("click", function(){
	        	try{
	        		for(let k = 0; selRadio.length; k++){
		                if (selRadio[k].checked  === true){
		                    let par = selRadio[k].parentElement;
		                    par.style.backgroundColor = "#404040";
		                    par.style.color = "#ffffff";
		                    par.style.transition = "all 0.2s";
		                }
		                else{
		                    let par = selRadio[k].parentElement;
		                    par.style.backgroundColor = "#ffffff";
		                    par.style.color = "#000000";
		                    par.style.transition = "all 0.2s";
		                }
		    		}
	        	}catch(e){
	        		console.log(e);
	        	}	
	        });
        }
    }
    
    

   // submit말고 button타입으로 변경 뒤 클릭시 action주소를 search&name='name'이런식으로
   // get방식으로 검색어를 전달하도록 변경 그래서 각 파트별로 지역, 직무, 경력 을 보낸다.
    function check_area(n){
        for(let i = 0; i < areas.length; i++){
            if (n != i){
                areas[i].style.color = "#000000";
            }
        }
    }


	let area_idx = 0;
    for(let i = 0; i < areas.length; i ++){
        areas[i].style.color = "#000000";
        areas[i].addEventListener("click", function(){
        	area_idx = i;
            let detail = document.getElementById("detail_area");
            if(this.style.color == "rgb(0, 0, 0)"){
                this.style.color = "#00B9FF";
                check_area(i);
                detail.innerHTML = "";
                detail.innerHTML = "<ul>";
                for(let j = 0; j < sub_area[i].length; j++){
                    detail.innerHTML += '<li><label for="area'+j+'"><input type="radio" class="sel_area" name="area" id="area'+j+'" value="'+sub_area[i][j]+'">'+sub_area[i][j]+'</label></li>';
                }
                detail.innerHTML += "</ul>";
                
                
                let sel_areas = document.getElementsByClassName("sel_area");
                for (let k = 0; k < sel_areas.length; k++){
                    sel_areas[k].addEventListener("click", function(){
                    	let select = document.getElementsByClassName("sel_area");
                    	
                    	try{
                    		for(let j = 0; select.length; j++){
                        		if(select[j].checked === true){
                        			select[j].parentElement.parentElement.style.backgroundColor = "#404040";
                        			select[j].parentElement.style.color = "#ffffff";
                        		} else {
                        			select[j].parentElement.parentElement.style.backgroundColor = "#ffffff";
                        			select[j].parentElement.style.color = "#000000";
                        		}
                        	}
                    	}catch(e){
                    		console.log(e);
                    	}
                    	
                    });
                    
                }
                
                
                
            }
            else{
                this.style.color = "#000000";
                detail.innerHTML = "";
            }

        })
    }
    
   	let testArray = ["","","","",""];
   	
    document.getElementById("job_write").addEventListener("click", function(){
    	for(let i = 0; i < radios.length; i++){
    		let boxs = document.getElementsByName(radios[i]);
    		let idx = 0;
	        for(let j = 0; j < boxs.length; j++){
	        	if(boxs[j].checked == true){
	        		searchType[i] = 1;
	        		testArray[i] = boxs[j].value;
	        		
	        	}
	        }
    	}
    	
    	
    	let dArea = document.getElementsByClassName("sel_area");
    	let s_idx = 0;
    	
    	for(let i = 0; i < dArea.length; i++){
    		if(dArea[i].checked == true){
    			searchType[3] = 1;
    			searchType[4] = s_idx + 1;
    			testArray[3] = areas[area_idx].innerHTML;
    			testArray[4] = dArea[i].value;
    			s_idx++;
    		}
    		
    	}
    	
    	let message = ["직무를 선택 해주세요.", "희망 학력을 선택해주세요.", "희망 경력을 선택해주세요.", "지역을 선택헤주세요."];
    	for(let i = 0; i < searchType.length; i++){
    		if(searchType[i] == '0'){
    			alert(message[i]);
    			return;
    		}
    	}
    	
    	if(document.jobBoard.title.value == ""){
			alert("제목을 입력해주세요.");
			return;
		}
		if(document.jobBoard.content.value == ""){
			alert("내용을 입력해주세요.");
			return;
		}
    	
    	document.jobBoard.sJob.value = testArray[0];
    	document.jobBoard.sDeg.value = testArray[1];
    	document.jobBoard.sExp.value = testArray[2];
    	document.jobBoard.sBArea.value = testArray[3];
    	document.jobBoard.sSArea.value = testArray[4];
    	
    	document.jobBoard.submit();
    });
    
    function createList(obj){
		if(obj.files.length > 5){
			alert("파일은 최대 5개까지 가능합니다.");
			obj.value = "";
		}
		
		var list = document.jobBoard.fileobj.files;
		var res = list[0].name;
		for(var i = 1; i < list.length; i++){
			res += ","+list[i].name;
		}
		
		document.jobBoard.file_list.value = res;
	}

    </script>
</body>
</html>