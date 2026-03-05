<%@ page contentType="text/html; charset=UTF-8" errorPage="/jsp/kw_error.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="/js/localjs/jquery1.12.4.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/sha256.min.js'/>"></script>

<script type="text/javascript">
/* 아이디중복체크 */
var idCheck = "F";
function checkStaffId() {
	var kStaffId = $.trim(document.getElementById("kStaffId").value);
	document.subfrm.kStaffId.value = kStaffId;
	if (kStaffId == "") {		/* 아이디 널값 체크 */
		alert("아이디를 입력하세요.");
		document.writeform.kStaffId.focus();
	} else {
		$.ajax({			/* 아이디 중복체크 */
			type : "post",
			dataType : "json",
			url : "<c:url value='/popup/kw_checkid.do'/>",
			data : $('#subfrm').serialize(),
			success : function(msg) { //응답이 성공 상태 코드를 반환하면 호출
				var resultFlag = msg.result.resultFlag;
				if (resultFlag == "T") {
					alert("사용 가능한 아이디 입니다.");
				} else {
					alert("중복된 아이디입니다.");
				}
				idCheck = resultFlag;
			},
			error : function(e) {
				alert('에러발생');
			}
		});
	}
}

function againCheckStaffId() {		/* 아이디 중복 체크 후 아이디를 변경하였을경우 다시 기본 값 셋팅 */
	idCheck = 'F';
}



function insert_reset()
{
	with (document.writeform)
	{
		reset();
		kStaffId.focus();
	}
}



var bbbb = true;
function insert_go()
{
    with (document.writeform)
    {
        if (kStaffId.value == "") {
            alert("아이디를 입력하세요.");
            kStaffId.focus();
            return;
        }
        if (kStaffName.value == "") {
            alert("이름을 입력하세요.");
            kStaffName.focus();
            return;
        }

        // 폼을 Ajax로 처리
        const formData = new FormData(document.writeform);
        fetch("/mes/myPage/kw_myPage_u.do", {
            method: "POST",
            body: formData
        }).then(response => {
            if (response.ok) {
                // 저장 성공 후 메인페이지로 이동
                window.location.href = "/mes/main.do";  // 실제 경로로 수정
            } else {
                alert("저장 실패: " + response.status);
            }
        }).catch(error => {
            alert("요청 중 오류 발생: " + error);
        });
    }
    
}

function windowPopup1(Key) {
// 	document.searchForm.kStaffKey.value = Key;
	var url = "/mes/staff/kw_staff_iuf.do?kParamImage=1&kStaffKey="+ Key;
	window.open(url, '', 'width=500, height=250');
}

function windowPopup2(Key) {
// 	document.searchForm.kStaffKey.value = Key;
	var url = "/mes/staff/kw_staff_iuf.do?kParamImage=2&kStaffKey="+ Key;
	window.open(url, '', 'width=500, height=250');
}


function updatePwd_go(){

	var mesMemberPassword = $('#mesMemberPassword').val();
	var chPassword = $('#chPassword').val();
	var chPassword2 = $('#chPassword2').val();
		
	if(mesMemberPassword == ""){
		alert("현재 비밀번호를 입력하세요.");
		$("#mesMemberPassword").focus();
		return false;
	}
	
	if(chPassword == ""){
		alert("변경 비밀번호를 입력하세요.");
		$("#chPassword").focus();
		return false;
	}
	
	if(chPassword2 == ""){
		alert("비밀번호 확인을 입력하세요.");
		$("#chPassword2").focus();
		return false;
	}
	
	if(checkPassword(chPassword) == false){
		return;	
	}
	
 	if(chPassword != chPassword2){
		alert("변경할 비밀번호 일치하지 않습니다. ");
		$('#chPassword').focus();
		return false;
	}else{

		var shMemberNum = $('#kStaffKey').val();
		var memberPassword = CryptoJS.SHA256($('#mesMemberPassword').val()).toString();
		var chPasswordChk = CryptoJS.SHA256($('#chPassword2').val()).toString();
	
		
		$.ajax({
			method : "post",
			url : "/mes/user/userInfoPwd_u.do",
			dataType : "json",
			data : {"mesUserKey":shMemberNum, "chPassword2":chPasswordChk, "mesMemberPassword":memberPassword},
			success : function(msg){
				
				var idx = msg.result.idx;
				var message = msg.result.message;
				
				if(idx == 0){
					//비밀번호 변경 오류
					alert(message);
					$('#mesMemberPassword').focus();
					return false;
				}else{
					alert(message + "");
					$("#mesMemberPassword").val("");
					$("#chPassword").val("");
					$("#chPassword2").val("");
					//location.href = "/mes/main.do";
				}
			}
		});
		
	}  
}
function checkPassword(password){	
    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$/.test(password)){            
        alert('숫자+영문자+특수문자 조합으로 9자리 이상 사용해야 합니다.');
        $('#password').val('').focus();
        return false;
    }    
    var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    if(checkNumber <0 || checkEnglish <0){
        alert("숫자와 영문자를 혼용하여야 합니다.");
        $('#password').val('').focus();
        return false;
    }
    if(/(\w)\1\1\1/.test(password)){
        alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
        $('#password').val('').focus();
        return false;
    }
        
   /*  if(password.search(id) > -1){
        alert("비밀번호에 아이디가 포함되었습니다.");
        $('#password').val('').focus();
        return false;
    } */
    return true;
}

function databaseDelete(){
	var mesUserKey = $("#kStaffKey").val();
	if(mesUserKey  == 1){
		if(confirm("등록된 데이터를 모두 삭제하겠습니까?")){	
			$.ajax({
				method : "post",
				url : "/mes/user/databaseAllTruncate.do",
				dataType : "json",
				success : function(msg){
					var upText = msg.result.eText;
					alert(upText);
				}
			});
			
		}
	}
}

</script>
<body class="content_bg" >
	
<form name="writeform" method="post" action="/mes/myPage/kw_myPage_u.do">
	<input type="hidden" id="kStaffKey" name="kStaffKey" value="<c:out value='${vo.kStaffKey}' />">
	<input type="hidden" id="kStaffSectorKey" name="kStaffSectorKey" value="${vo.kStaffSectorKey}" />

				<div class="content_top with_btn">	
					<div class="content_tit">
						<h2>직원정보수정</h2>
					</div>
					<div class="btns">
						<c:if test="${vo.kStaffId eq 'innost'}">
							<a class="form_btn md"  onclick="databaseDelete()">데이터 초기화</a>
						</c:if>
					</div>
				</div>	
					
				<div class="normal_table row">	
					<table>
						<tbody>
							<tr>
								<th>아이디</th>
								<td>
									<input type="hidden" name="kStaffId" id="kStaffId" value="<c:out value='${vo.kStaffId}'/>" onkeydown="againCheckStaffId()" maxLength="20">
	<!-- 								<a onclick="javascript:checkStaffId()" >중복체크</a>-->
									<c:out value='${vo.kStaffId}'/>
								</td> 
							</tr>
							<tr>
								<th>직 급</th>
								<td>
									<input type="hidden" id="kClassKey" name="kClassKey" value="${vo.kClassKey}" />
									<c:out value='${vo.kClassName}'/>
								</td>
							</tr>
							<tr>
								<TH>부 서</th>
								<TD>
									<input type="hidden" id="kPositionKey" name="kPositionKey" value="${vo.kPositionKey}" />
									<c:out value='${vo.kPositionName}'/>
								</td>
							</tr>
							<%-- <TR>
								<TH>사원번호</th>
								<TD><input type="text" name="kStaffNum" value="<c:out value='${vo.kStaffNum}'/>" maxLength="20"></td>
							</tr> --%>
							<tr>
								<TH>이 름</th>
								<TD><input type="text" name="kStaffName" value="<c:out value='${vo.kStaffName}'/>" maxLength="50"></td>
							</tr>
							<tr>
								<th>비밀번호 변경</th>
								<td class="myinfo_font">
									<p><span>현재 비밀번호 : </span><input type="password" class="myinfo_input"  name="mesMemberPassword" id="mesMemberPassword" value="" /></p>
									<p><span>변경 비밀번호 : </span><input type="password" class="myinfo_input"  name="chPassword" id="chPassword" value="" style="margin: 8px 0;"/></p>
									<p><span>비밀번호 확인 : </span><input type="password" class="myinfo_input"  name="chPassword2" id="chPassword2" value="" /><a name="btn_01" class="form_btn bg ml5" onclick="updatePwd_go();">비밀번호 변경</a></p>
								</td>
							</tr>
							<!-- <tr>
								<th>비밀번호</th>
								<td>
									현재 비밀번호 : <input type="password" id="nowPassword" name="nowPassword" maxlength="8" placeholder=" 현재 비밀번호" />
									비밀번호 변경 : <input type="password" id="changePassword" name="changePassword" maxlength="8" placeholder=" 비밀번호 변경" />
									비밀번호 확인 : <input type="password" id="confirmPassword" name="confirmPassword" maxlength="8" placeholder=" 비밀번호 확인" />
									<a onclick="pwUpd()" >비밀번호 체크</a>
								</td>
							</tr> -->
							<tr>
								<TH>생년월일</th>
								<TD><input type="text" name="kStaffBirthday" value="<c:out value='${vo.kStaffBirthday}'/>" maxLength="8" style="width: 150px;" class="mr20"> 
								<label class="inp_radio">
									<input type="radio" name="kStaffBirthdayFlag" value="T" <c:if test="${ vo.kStaffBirthdayFlag eq 'T' }" > checked</c:if>>
									<i></i>
									<span>양력 </span>
								</label>
								<label class="inp_radio">
									<input type="radio" name="kStaffBirthdayFlag" value="F" <c:if test="${ vo.kStaffBirthdayFlag eq 'F' }" > checked</c:if>>
									<i></i>
									<span>음력</span>
								</label>
								</td>
							</tr>
							<tr>
								<TH>이메일</th>
								<TD><input type="text" name="kStaffEmail" value="<c:out value='${vo.kStaffEmail}'/>" maxLength="100" size="30">
								</td>
							</tr>					
							<TR>
								<TH>전화번호</th>
								<TD><input type="text" name="kStaffPhone1" value="<c:out value='${vo.kStaffPhone1}'/>" maxLength="4" size="4">
									- <input type="text" name="kStaffPhone2" value="<c:out value='${vo.kStaffPhone2}'/>" maxLength="4" size="4">
									- <input type="text" name="kStaffPhone3" value="<c:out value='${vo.kStaffPhone3}'/>" maxLength="4" size="4">
								</td>
							</tr>
							<TR>
								<TH>휴대전화</th>
								<TD><input type="text" name="kStaffMobile1" value="<c:out value='${vo.kStaffMobile1}'/>" maxLength="3" size="4">
									- <input type="text" name="kStaffMobile2" value="<c:out value='${vo.kStaffMobile2}'/>" maxLength="4" size="4">
									- <input type="text" name="kStaffMobile3" value="<c:out value='${vo.kStaffMobile3}'/>" maxLength="4" size="4">
								</td>
							</tr>
							<TR>
								<TH>현재상태</th>
								<TD>
									<select name="kStaffStateFlag">
										<option value="1" <c:if test="${vo.kStaffStateFlag eq '1'}">selected="selected="</c:if>>재직</option>
										<option value="2" <c:if test="${vo.kStaffStateFlag eq '2'}">selected="selected="</c:if>>퇴직</option>
										<option value="3" <c:if test="${vo.kStaffStateFlag eq '3'}">selected="selected="</c:if>>휴가</option>
										<option value="4" <c:if test="${vo.kStaffStateFlag eq '4'}">selected="selected="</c:if>>파견</option>
									</select>
								</td>
							</tr>
							<%-- <TR>
								<TH>팀장여부</th>
								<TD>
									<select name="kStaffLeaderYn" id="kStaffLeaderYn">
										<option value="" <c:if test="${ vo.kStaffLeaderYn eq '' }" > selected</c:if>>선택</option>
										<option value="Y" <c:if test="${ vo.kStaffLeaderYn eq 'Y' }" > selected</c:if>>Y</option>
										<option value="N" <c:if test="${ vo.kStaffLeaderYn eq 'N' }" > selected</c:if>>N</option>
									</select>
								</td>
							</tr> --%>
						
									<%-- 	
									<TR>
										<Td colspan="2">
											<TABLE class="tbl_view">
												<tr>
													<th>확정권한</th>
													<td>
														<input type="radio" name="kStaffAuthConfirmFlag" value="T" <c:if test="${staffInfo.kStaffAuthConfirmFlag eq 'T'}">checked</c:if> >  권한있음&nbsp;&nbsp;&nbsp;
														<input type="radio" name="kStaffAuthConfirmFlag" value="F"  <c:if test="${staffInfo.kStaffAuthConfirmFlag eq 'F'}">checked</c:if> > 권한없음
													</td>
													<th>쓰기권한</th>
													<td>
														<input type="radio" name="kStaffAuthWriteFlag" value="T" <c:if test="${staffInfo.kStaffAuthWriteFlag eq 'T'}">checked</c:if>> 권한있음&nbsp;&nbsp;&nbsp;
														<input type="radio" name="kStaffAuthWriteFlag" value="F"  <c:if test="${staffInfo.kStaffAuthWriteFlag eq 'F'}">checked</c:if>> 권한없음
													</td>
												</tr>
												<tr>
													<th>수정권한</th>
													<TD>
														<input type="radio" name="kStaffAuthModifyFlag" value="T" <c:if test="${staffInfo.kStaffAuthModifyFlag eq 'T'}">checked</c:if>> 권한있음&nbsp;&nbsp;&nbsp;
														<input type="radio" name="kStaffAuthModifyFlag" value="F"  <c:if test="${staffInfo.kStaffAuthModifyFlag eq 'F'}">checked</c:if>> 권한없음
													</td>
													<th>삭제권한</th>
													<TD>
														<input type="radio" name="kStaffAuthDelFlag" value="T" <c:if test="${staffInfo.kStaffAuthDelFlag eq 'T'}">checked</c:if>> 권한있음&nbsp;&nbsp;&nbsp;
														<input type="radio" name="kStaffAuthDelFlag" value="F"  <c:if test="${staffInfo.kStaffAuthDelFlag eq 'F'}">checked</c:if>> 권한없음
													 </td>
												</tr>
											</table>
										</td>						
									</tr>
						 		--%>	
						</tbody>
					</table>
				</div>	
			
			
			<div class="bottom_btn">
				<!--  <a href="javascript:windowPopup1(<c:out value='${vo.kStaffKey}' />);" class="form_btn bg">사진등록</a>
				<a href="javascript:windowPopup2(<c:out value='${vo.kStaffKey}' />);" class="form_btn bg">사인등록</a> -->
				<button type="button" class="form_btn active" onclick="insert_go();">저장</button>
				<!--  <button type="button" class="form_btn" onclick="insert_reset();">다시</button> -->
				<a href="/mes/myPage/kw_myPage_lf.do" class="form_btn">취소</a>
			</div>
		
					
	</form>
			
</body>
