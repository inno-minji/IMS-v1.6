<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript" src="<c:url value='/js/core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/sha256.min.js'/>"></script>
<script>
function memberUp(){
	if(chkIns()){
		if($("#mesUserName").val() == ""){
			modal1("이름을 입력하세요.", "#mesUserName");
			return false;
		}
		
		modal3("저장하시겠습니까?", function(){
			$('#mloader').show();
			document.writeForm.action = "/mes/kw_user_u.do";
			document.writeForm.submit();
		});
	}
}

function delete_go(){
	modal3("사용자를 삭제하시겠습니까?", function(){
		$('#mloader').show();
		document.writeForm.action = "/mes/kw_user_d.do";
		document.writeForm.submit();
	});
}
function cancle(){
	$('#mloader').show();
	document.writeForm.action = "/mes/user/kw_user_lf.do";
	document.writeForm.submit();
}

function chkIns(){
	return true;
}

function checkPassword(password){	
    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$/.test(password)){            
        modal1('비밀번호는 숫자+영문자+특수문자 조합으로 9자리 이상 사용해야 합니다.', "#password");
        return false;
    }    
    var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    if(checkNumber <0 || checkEnglish <0){
    	modal1("비밀번호는 숫자와 영문자를 혼용하여야 합니다.", "#password");
        return false;
    }
    if(/(\w)\1\1\1/.test(password)){
    	modal1('비밀번호는 같은 문자를 4번 이상 사용하실 수 없습니다.', "#password");
        return false;
    }
        
   /*  if(password.search(id) > -1){
        alert("비밀번호에 아이디가 포함되었습니다.");
        $('#password').val('').focus();
        return false;
    } */
    return true;
}

function updatePwd_go(){
	var mesMemberPassword = $('#mesMemberPassword').val();
	var chPassword = $('#chPassword').val();
	var chPassword2 = $('#chPassword2').val();
		
	if(mesMemberPassword == ""){
		modal1("현재 비밀번호를 입력하세요.", "#mesMemberPassword");
		return false;
	}
	
	if(chPassword == ""){
		modal1("변경 비밀번호를 입력하세요.", "#chPassword");
		return false;
	}
	
	if(chPassword2 == ""){
		modal1("비밀번호 확인을 입력하세요.", "#chPassword2");
		return false;
	}
	
	if(checkPassword(chPassword) == false){
		return;	
	}
	
 	if(chPassword != chPassword2){
 		modal1("변경할 비밀번호 일치하지 않습니다.");
 		$('#chPassword2').val("");
		return false;
	}else{

		var shMemberNum = $('#mesUserKey').val();
		var mesMemberPassword = CryptoJS.SHA256($('#mesMemberPassword').val()).toString();
		var chPassword2 = CryptoJS.SHA256($('#chPassword2').val()).toString();
	
		
		$.ajax({
			method : "post",
			url : "/mes/user/userInfoPwd_u.do",
			dataType : "json",
			data : {"mesUserKey":shMemberNum, "chPassword2":chPassword2, "mesMemberPassword":mesMemberPassword},
			success : function(msg){
				
				var idx = msg.result.idx;
				var message = msg.result.message;
				
				if(idx == 0){
					//비밀번호 변경 오류
					modal1(message);
					$('#mesMemberPassword').focus();
					return false;
				}else{
					modal1(message);
					$("#mesMemberPassword").val("");
					$("#chPassword").val("");
					$("#chPassword2").val("");
				}
			}
		});
	}
}

function generatePassword(length) {
    // 비밀번호에 사용할 문자들 정의
    const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
    const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    const specialChars = '!@#$';

    // 모든 문자 조합
    const allChars = lowerCase + upperCase + numbers + specialChars;

    // 결과를 저장할 변수
    let password = '';

    // 각 문자 유형을 최소 1개씩 추가 (안전한 비밀번호 보장을 위해)
    password += lowerCase[Math.floor(Math.random() * lowerCase.length)];
    password += upperCase[Math.floor(Math.random() * upperCase.length)];
    password += numbers[Math.floor(Math.random() * numbers.length)];
    password += specialChars[Math.floor(Math.random() * specialChars.length)];

    // 나머지 길이만큼 랜덤으로 채우기
    for (let i = password.length; i < length; i++) {
        password += allChars[Math.floor(Math.random() * allChars.length)];
    }

    // 비밀번호를 무작위로 섞기
    password = password.split('').sort(() => Math.random() - 0.5).join('');

    return password;
}

function updateNewPwd_go(){
	var mesUserKey = $('#mesUserKey').val();
	var str = generatePassword(8);
	modal3('비밀번호를 초기화 하시겠습니까? \n변경될 비밀번호는 '+str+' 입니다.\n', function() {
		navigator.clipboard.writeText(str)
        .then(() => {
          	modal1("비밀번호가 복사되었습니다.");
          
	          $.ajax({
	  			type : "post",
	  			url : "/mes/user/setPass.do",
	  			data : {"mesUserKey": mesUserKey , "mesUserPassword" : str},
	  			dataType : "json",
	  			async : false,
	  			cache : false,
	  			success : function(){
	  				window.location.reload();
	  			}
	  		});
        });
	});
}

//비밀번호 안정성
function passwordResultCheck(){
	var pw = $("#chPassword").val();
	
	if(/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(pw)){
		$("#passwordResult").text("안전");
	}else if(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/.test(pw)){
		$("#passwordResult").text("약함");
	}else{
		$("#passwordResult").text("사용할 수 없는 비밀번호");
	}
	
	var check = $("#chPassword2").val();
	if(check != ""){
		samePassword();
	}
}
function onlyNumber() { /* 문자입력 제한 */
	if ((event.keyCode < 48) || (event.keyCode > 57))
		event.returnValue = false;
}
// 비밀번호 확인
function samePassword(){
	var pw = $("#chPassword").val();
	var check = $("#chPassword2").val();
	
	if(pw == check){
		$("#passwordCheck").text("일치");
	}else{
		$("#passwordCheck").text("일치하지 않습니다.");
	}
}
function autChange(obj){
  //mesUserAuthModifyFlag
	if(obj.value == 'T'){
		obj.value = 'F';
	}else{
		obj.value = 'T';
	}
	
	
}
</script>
<style type="text/css">
.switch {
  position: relative;
  display: inline-block;
  width: 30px;
  height: 17px;
  vertical-align: middle;
  margin-right: 12px;
}

.switch input { 
  opacity: 0;
  width: 30px !important;
  height: 17px !important;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #E3E3E3;
  -webkit-transition: .4s;
  transition: .4s;
  border-radius: 50px;
}

.slider:before {
  position: absolute;
  content: "";
  height: 13px;
  width: 13px;
  left: 2px;
  bottom: 2px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
  border-radius: 50px;
}

.checkbox:checked + .slider {
  background-color: var(--primary);
}

.checkbox:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

.checkbox:checked + .slider:before {
  -webkit-transform: translateX(13px);
  -ms-transform: translateX(13px);
  transform: translateX(13px);
}
</style>
<form name="writeForm" id="writeForm">		
	<input type="hidden" name="mesUserKey" id="mesUserKey" value="${mesUserInfo.mesUserKey}" />
	<input type="hidden" name="searchType" id="searchType" value="<c:out value='${mesUserVO.searchType}'/>">
	<input type="hidden" name="searchWord" id="searchWord" value="<c:out value='${mesUserVO.searchWord}'/>">
	<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value='${mesUserVO.pageIndex}'/>">
	<input type="hidden" name="recordCountPerPage" id="recordCountPerPage" value="<c:out value='${mesUserVO.recordCountPerPage}'/>">
	
	<div class="content_top">
		<div class="content_tit">
			<h2>사용자정보 수정</h2>
		</div>
	</div>
		
	<div class="normal_table row">
		<table>
			<tbody>
				<tr>
					<th>I D</th>
					<td>${mesUserInfo.mesUserId}</td>
					<th><span style="color: red">* </span>이 름</th>
					<td><input type="text" id="mesUserName" name="mesUserName" maxLength="20" style="width:100%;" value="${mesUserInfo.mesUserName }" /></td>
				</tr>
				<tr>
					<th>비밀번호 변경</th>
					<td colspan="3">
						현재 비밀번호 : <input type="password" id="mesMemberPassword" name="mesMemberPassword" value="" style="width:300px;" /><br/>
						변경 비밀번호 : <input type="password" id="chPassword" name="chPassword" value="" style="width:300px; margin: 8px 0;" maxlength="20" onblur="passwordResultCheck();" />
						비밀번호안전도 : <span id="passwordResult"></span>(숫자, 영문, 특수문자조합 9자리이상 가능 )<br/>
						변경 비밀번호 확인: <input type="password" id="chPassword2" name="chPassword2" value="" style="width:300px;"  maxlength="20" onblur="samePassword();" />
              			<span id="passwordCheck"></span>
						<a class="form_btn bg" onclick="updatePwd_go()"> 
              				변경하기
              			</a>
						<a class="form_btn bg" onclick="updateNewPwd_go()"> 
              				초기화
              			</a>
						<!-- <input type="button" name="btn_01" value="비밀번호 변경" class="list_btn" onclick="updatePwd_go();"> -->
					</td>
				</tr>	
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="mesUserBirthday" maxLength="8" onkeypress="onlyNumber();" value="${mesUserInfo.mesUserBirthday}" style="width: 150px;"/>
						<span class="mr20">(Ex:19220125)</span>
						<label class="inp_radio">
							<input type="radio" name="mesUserBirthdayFlag" value="T" <c:if test="${mesUserInfo.mesUserBirthdayFlag eq 'T'}">checked</c:if>>
							<i></i>
							<span>양력 </span>
						</label>
						<label class="inp_radio">
							<input type="radio" name="mesUserBirthdayFlag" value="F" value="T" <c:if test="${mesUserInfo.mesUserBirthdayFlag eq 'F'}">checked</c:if>>
							<i></i>
							<span>음력 </span>
						</label>
					</td>
					<th>이메일</th>
					<td><input type="text" name="mesUserEmail" maxLength="100" style="width:100%;" value="${mesUserInfo.mesUserEmail}"/></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td colspan="3"><input type="text" name="mesUserTelephone1" maxLength="3" onkeypress="onlyNumber();" 
							style="ime-mode: disabled;width: 15% !important;"  value="${mesUserInfo.mesUserTelephone1}" /> - 
						<input type="text" name="mesUserTelephone2"  maxLength="4" onkeypress="onlyNumber();"
							style="ime-mode: disabled;width:15% !important;"  value="${mesUserInfo.mesUserTelephone2}"/> - 
						<input type="text" name="mesUserTelephone3" maxLength="4" onkeypress="onlyNumber();"
							style="ime-mode: disabled;width:15% !important;"  value="${mesUserInfo.mesUserTelephone3}"/></td>
				</tr>
				<tr>
					<th scope="row">휴대전화</th>
					<td colspan="3"><input type="text" name="mesUserMobile1" maxLength="3" onkeypress="onlyNumber();"
							style="ime-mode: disabled;width:15% !important;" value="${mesUserInfo.mesUserMobile1}"/> - 
						<input type="text" name="mesUserMobile2" maxLength="4" onkeypress="onlyNumber();"
							style="ime-mode: disabled;width: 15% !important;" value="${mesUserInfo.mesUserMobile2}"/> - 
						<input type="text" name="mesUserMobile3" maxLength="4" onkeypress="onlyNumber();"
							style="ime-mode: disabled;width:15% !important;" value="${mesUserInfo.mesUserMobile3}"/>
					</td>
				</tr>
				<tr>
					<%-- 
					<th>사업 부문</th>
					<td>
						<select name="kSectorKey">
								<c:forEach var="item" items="${sectorList}">
									<option value="<c:out value='${item.kSectorKey}' />" 
									 <c:if test="${item.kSectorKey eq mesUserInfo.kSectorKey}">selected="selected="</c:if>><c:out value="${item.kSectorName}" /></option>
								</c:forEach>
						</select>
					</td>
					 --%>
					<th>상 태</th>
					<td colspan="3">
						<select name="kSectorKey" style="display: none;">
								<c:forEach var="item" items="${sectorList}">
									<option value="<c:out value='${item.kSectorKey}' />" 
									 <c:if test="${item.kSectorKey eq mesUserInfo.kSectorKey}">selected="selected="</c:if>><c:out value="${item.kSectorName}" /></option>
								</c:forEach>
						</select>
						<select name="mesUserStateFlag">
							<option value="1" <c:if test="${mesUserInfo.mesUserStateFlag eq '1'}">selected="selected="</c:if>>재직</option>
							<option value="2" <c:if test="${mesUserInfo.mesUserStateFlag eq '2'}">selected="selected="</c:if>>퇴직</option>
							<option value="3" <c:if test="${mesUserInfo.mesUserStateFlag eq '3'}">selected="selected="</c:if>>휴가</option>
							<option value="4" <c:if test="${mesUserInfo.mesUserStateFlag eq '4'}">selected="selected="</c:if>>파견</option>
						</select>
					</td>
				</tr>	
				<tr>
					<th>부 서</th>
					<td>
						<select name="kPositionKey">
							<c:forEach var="positionList" items="${positionList}">
								<option value="${positionList.kPositionKey }" <c:if test="${mesUserInfo.kPositionKey eq positionList.kPositionKey}">selected="selected="</c:if>>${positionList.kPositionName }</option>
							</c:forEach>
						</select>
					</td>
					<th>직 급</th>
					<td><select name="kClassKey" style="width: 150px;">
							<option value="" selected>직급선택</option>
							<c:forEach var="item" items="${classList}">
								<option value="<c:out value='${item.kClassKey}' />"  <c:if test="${item.kClassKey eq mesUserInfo.kClassKey}">selected="selected="</c:if>>
									<c:out value="${item.kClassName}" />
								</option>
							</c:forEach>
					</select>
					 <span class="ml5">*직급은 권한과 관련없습니다.</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>	
				
	<div class="normal_table row" > 
<!-- 	style="display: none;" -->
		<table>
			<tbody>
				<tr>
					<th>시스템 관리자 권한</th>
					<td colspan="3" >
						<label class="switch" >
							<input type="checkbox" class="checkbox" id="mesUserAuthModifyFlag" name="mesUserAuthModifyFlag" value="${mesUserInfo.mesUserAuthModifyFlag}" onchange="autChange(this);" <c:if test="${mesUserInfo.mesUserAuthModifyFlag eq 'T'}">checked</c:if>  >
							<span class="slider"></span>
						</label>
					   <span >
				 			※ 시스템 관리자 권한으로 메뉴 권한(읽기, 확정, 쓰기, 수정, 삭제)과 별개로 시스템 등록된 정보를 수정, 삭제 처리할 수 있습니다.
			 			</span>
					</td>
				</tr>
			</tbody>
		</table>		
	</div> 
	
	<div class="bottom_btn">
		<span class="mr20">비밀번호 변경시 "변경하기"버튼으로 반영하세요!</span>
		<c:if test="${staffVo.kStaffAuthModifyFlag eq 'T'}">
		<button type="button" class="form_btn active" onclick="memberUp();">저장</button>
		</c:if>
		<c:if test="${staffVo.kStaffAuthDelFlag eq 'T'}">
		<button type="button" class="form_btn bg" onclick="delete_go();">삭제</button>
		</c:if>
		<button type="button" class="form_btn" onclick="cancle();">목록</button>
	</div>
</form>