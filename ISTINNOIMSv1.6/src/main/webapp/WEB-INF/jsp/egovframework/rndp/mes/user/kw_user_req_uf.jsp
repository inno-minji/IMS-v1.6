<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script>


function mesUserResInsert(key){
	document.writeForm.action = "/mes/user/kw_user_req_i.do";
	document.writeForm.submit();
}

</script>
<form name="writeForm" id="writeForm">		
	<input type="hidden" name="mesUserRequestKey" id="mesUserRequestKey" value="${mesUserInfo.mesUserRequestKey}" />
	
	
		<div class="content">
			<div class="content_tit">
				<h2>직원가입신청 정보수정</h2>
			</div>
		</div>
		
	
			<div class="tbl_write">
				<table>
					<tbody>
						<tr>
							<th>I D</th>
							<td>${mesUserInfo.mesUserId}</td>
							<th>이름</th>
							<td>${mesUserInfo.mesUserName }<input type="hidden" name="mesUserName" maxLength="50" style="width: 150px;" value="${mesUserInfo.mesUserName }" /></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>${mesUserInfo.mesUserBirthday}<input type="hidden" name="mesUserBirthday" maxLength="8" onkeypress="onlyNumber();"
									style="ime-mode: disabled; width: 150px;" value="${mesUserInfo.mesUserBirthday}"/> (Ex:19220125) 
								<input type="radio" name="mesUserBirthdayFlag" value="T" <c:if test="${mesUserInfo.mesUserBirthdayFlag eq '양력'}">checked</c:if>><span>양력</span>
								<input type="radio" name="mesUserBirthdayFlag" value="F" value="T" <c:if test="${mesUserInfo.mesUserBirthdayFlag eq '음력'}">checked</c:if>><span>음력</span>
							</td>
							<th>이메일</th>
							<td>${mesUserInfo.mesUserEmail}<input type="hidden" name="mesUserEmail" maxLength="100" style="width: 300px;" value="${mesUserInfo.mesUserEmail}"/></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td colspan="3">
							
							${mesUserInfo.mesUserTelephone1}-${mesUserInfo.mesUserTelephone2}-${mesUserInfo.mesUserTelephone3}
							<input type="hidden" name="mesUserTelephone1" maxLength="3" onkeypress="onlyNumber();" 
									style="ime-mode: disabled; width: 15% !important;" value="${mesUserInfo.mesUserTelephone1}" readonly="readonly"/>
								<input type="hidden" name="mesUserTelephone2" maxLength="4" onkeypress="onlyNumber();"
									style="ime-mode: disabled; width: 15% !important;" value="${mesUserInfo.mesUserTelephone2}" readonly="readonly" />
								<input type="hidden" name="mesUserTelephone3" maxLength="4" onkeypress="onlyNumber();"
									style="ime-mode: disabled; width:15% !important;" value="${mesUserInfo.mesUserTelephone3}" readonly="readonly" /></td>
						</tr>
						<tr>
							<th scope="row">핸 드 폰</th>
							<td colspan="3">
							${mesUserInfo.mesUserMobile1}-${mesUserInfo.mesUserMobile2}-${mesUserInfo.mesUserMobile3}
							
							<input type="hidden" name="mesUserMobile1" maxLength="3" onkeypress="onlyNumber();"
									style="ime-mode: disabled; width:15% !important;" value="${mesUserInfo.mesUserMobile1}" readonly="readonly" />
								<input type="hidden" name="mesUserMobile2" maxLength="4" onkeypress="onlyNumber();"
									style="ime-mode: disabled; width:15% !important;" value="${mesUserInfo.mesUserMobile2}" readonly="readonly" /> 
								<input type="hidden" name="mesUserMobile3" maxLength="4" onkeypress="onlyNumber();"
									style="ime-mode: disabled; width: 15% !important;" value="${mesUserInfo.mesUserMobile3}" readonly="readonly" />
							</td>
						</tr>					
					</tbody>
				</table>
			</div>	
			
			<div class="tbl_write">
			<%-- 	<table>
					<tbody>
						<tr>
							<th>확정권한</th>
							<td>
								<input type="radio" name="kMemberConfirmFlag" value="T" <c:if test="${mesUserInfo.mesUserAuthConfirmFlag eq 'T'}">checked</c:if>>있음
								<input type="radio" name="kMemberConfirmFlag" value="F" <c:if test="${mesUserInfo.mesUserAuthConfirmFlag ne 'T'}">checked</c:if>>없음
							</td>
							<th>쓰기권한</th>
							<td>
								<input type="radio" name="kMemberWriteFlag" value="T" <c:if test="${mesUserInfo.mesUserAuthWriteFlag eq 'T'}">checked</c:if>>있음
								<input type="radio" name="kMemberWriteFlag" value="F" <c:if test="${mesUserInfo.mesUserAuthWriteFlag ne 'T'}">checked</c:if>>없음
							</td>
						</tr>
						<tr>
							<th>수정권한</th>
							<td>
								<input type="radio" name="kMemberUpdateFlag" value="T" <c:if test="${mesUserInfo.mesUserAuthModifyFlag eq 'T'}">checked</c:if>>있음
								<input type="radio" name="kMemberUpdateFlag" value="F" <c:if test="${mesUserInfo.mesUserAuthModifyFlag ne 'T'}">checked</c:if>>없음
							</td>
							<th>삭제권한</th>
							<td>
								<input type="radio" name="kMemberDeleteFlag" value="T" <c:if test="${mesUserInfo.mesUserAuthDelFlag eq 'T'}">checked</c:if>>있음
								<input type="radio" name="kMemberDeleteFlag" value="F" <c:if test="${mesUserInfo.mesUserAuthDelFlag ne 'T'}">checked</c:if>>없음
							</td>
						</tr>
					</tbody>
				</table> --%>		
			</div>
			
			<div class="tbl_btn_right">
				<ul>
					<li>
						<a href="javascript:mesUserResInsert();">승인</a>
					</li>
					<li>
						<a href="/mes/user/kw_user_req_lf.do">목록</a>
					</li>
				</ul>
			</div>
		
</form>