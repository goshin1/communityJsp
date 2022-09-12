<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style/jobs_write.css" type="text/css" rel="stylesheet">
    <title>Jobs_Write</title>
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
                    <!-- 메뉴 내용은 데이터베이스에 각각 읽는 것으로 만들기 -->
                    <!-- 직무 테이블을 만들어 그 내용을 li태그로 작성 -->
                    <div class="option_box">
                        직무
                        <ul class="main_option">
                            <li><label for="job1"><input type="checkbox" name="job" id="job1" value="프론트개발">프론트개발</label></li>
                            <li><label for="job2"><input type="checkbox" name="job" id="job2" value="백엔드개발">백앤드개발</label></li>
                            <li><label for="job3"><input type="checkbox" name="job" id="job3" value="웹프로그래머">웹프로그래머</label></li>
                            <li><label for="job4"><input type="checkbox" name="job" id="job4" value="시스템프로그래머">시스템프로그래머</label></li>
                        </ul>
                    </div>

                    <div class="option_box">
                        학위
                        <ul class="main_option">
                            <li><label for="deg1"><input type="checkbox" name="deg" id="deg1" value="고졸">고졸</label></li>
                            <li><label for="deg2"><input type="checkbox" name="deg" id="deg2" value="2,3년제학사">2,3년제 학사</label></li>
                            <li><label for="deg3"><input type="checkbox" name="deg" id="deg3" value="4년제 학사">4년제 학사</label></li>
                            <li><label for="deg4"><input type="checkbox" name="deg" id="deg4" value="석사">석사</label></li>
                            <li><label for="deg5"><input type="checkbox" name="deg" id="deg5" value="학사">학사</label></li>
                        </ul>
                    </div>

                    <div class="option_box">
                        경력
                        <ul class="main_option">
                            <li><label for="exp1"><input type="checkbox" name="exp" id="exp1" value="무관">무관</label></li>
                            <li><label for="exp2"><input type="checkbox" name="exp" id="exp2" value="신입">신입</label></li>
                            <li><label for="exp3"><input type="checkbox" name="exp" id="exp3" value="1년이상">1년이상</label></li>
                            <li><label for="exp4"><input type="checkbox" name="exp" id="exp4" value="2년이상">2년이상</label></li>
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
            <form id="write" action="post" >
                <input type="text" name="title" placeholder="제목을 입력해주세요.">

                <div id="write_body">
                    <div>
                        <input type="button" value="&nbsp">
                    </div>
                    <textarea name="content"></textarea>
                </div>
                <input type="submit" value="작성">
            </form>
        </div>
        <aside id="aside_second">
            광고
        </aside>
    </div>
    <script>
        let checks = document.getElementsByTagName("input");
        let searchs = "";
        for(let j = 0; j < checks.length; j++){
            if (checks[j].type == "checkbox"){
                checks[j].addEventListener("click", function(){
                    if (searchs.includes(checks[j].value) == false){
                        searchs += (checks[j].value + ",");
                        let par = checks[j].parentElement;
                        par.style.backgroundColor = "#404040";
                        par.style.color = "#ffffff";
                        par.style.transition = "all 0.2s";
                    }
                    else{
                        searchs = searchs.replace(checks[j].value + ",", "");
                        let par = checks[j].parentElement;
                        par.style.backgroundColor = "#ffffff";
                        par.style.color = "#000000";
                        par.style.transition = "all 0.2s";
                    }
                });
            }
        }

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

       // submit말고 button타입으로 변경 뒤 클릭시 action주소를 search&name='name'이런식으로
       // get방식으로 검색어를 전달하도록 변경 그래서 각 파트별로 지역, 직무, 경력 을 보낸다.
        function check_area(n){
            for(let i = 0; i < areas.length; i++){
                if (n != i){
                    areas[i].style.color = "#000000";
                }
            }
        }



        for(let i = 0; i < areas.length; i ++){
            areas[i].style.color = "#000000";
            areas[i].addEventListener("click", function(){
                let detail = document.getElementById("detail_area");
                if(this.style.color == "rgb(0, 0, 0)"){
                    this.style.color = "#00B9FF";
                    check_area(i);
                    detail.innerHTML = "";
                    detail.innerHTML = "<ul>";
                    for(let j = 0; j < sub_area[i].length; j++){
                        detail.innerHTML += '<li><label for="area'+j+'"><input type="checkbox" class="sel_area" name="area" id="area'+j+'" value="'+sub_area[i][j]+'">'+sub_area[i][j]+'</label></li>';
                    }
                    detail.innerHTML += "</ul>";
                    let sel_areas = document.getElementsByClassName("sel_area");
                    for (let k = 0; k < sel_areas.length; k++){
                        sel_areas[k].addEventListener("click", function(){
                            if(this.parentElement.parentElement.style.backgroundColor == "rgb(64, 64, 64)"){
                                this.parentElement.parentElement.style.backgroundColor = "#ffffff";
                                this.parentElement.style.color = "#000000";
                                searchs = searchs.replace(areas[i].innerHTML + " " + sel_areas[k].value + ",", "");    
                            }
                            else{
                                this.parentElement.parentElement.style.backgroundColor = "#404040";
                                this.parentElement.style.color = "#ffffff";
                                searchs += areas[i].innerHTML + " " + sel_areas[k].value + ",";
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

        
        document.getElementById("job_search").addEventListener("click", function(){
            searchs = searchs.substr(0, searchs.length - 1);
            alert(searchs);
        });


    </script>
</body>
</html>