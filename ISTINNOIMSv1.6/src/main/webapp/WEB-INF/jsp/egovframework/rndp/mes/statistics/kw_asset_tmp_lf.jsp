<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<meta http-equiv="refresh" content="900">
<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />

<!-- 그리드 S -->
<link href="/css/mes/jquery-ui.min.css" rel="stylesheet"	type="text/css" />
<script src="/js/Chart/ChartB.js"></script>
<script src="/js/highchart/code/modules/exporting.js"></script>
<script src="/js/highchart/code/modules/export-data.js"></script>

<script type="text/javascript">
	$(document).ready(function(){	
		eDivCheck();
		datepickerSet('topStartDate', 'topEndDate');
	});	
	
	function eDivCheck(){
		var eNowPageNum = Number("${mesStatisticsVO.ePageGubun}");
		if(eNowPageNum == 1){
			document.getElementById("div1").style.display = "block";
			document.getElementById("div2").style.display = "none";
			document.getElementById("div3").style.display = "none";
		}
		if(eNowPageNum == 2){
			document.getElementById("div1").style.display = "none";
			document.getElementById("div2").style.display = "block";
			document.getElementById("div3").style.display = "none";
		}
		if(eNowPageNum == 3){
			document.getElementById("div1").style.display = "none";
			document.getElementById("div2").style.display = "none";
			document.getElementById("div3").style.display = "block";
		}
		 
	}
	
	function setStartDate(d) {
	    var settingDate = new Date();
	    if(d == '7'){
	        settingDate.setDate(settingDate.getDate()-7);
	    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	    }else if(d == '1'){
	        settingDate.setMonth(settingDate.getMonth()-1);
	    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	    }else{
	        settingDate.setMonth(settingDate.getMonth()-3);
	    	$('#topStartDate').val(settingDate.format("yyyy-MM-dd"));
	    }
	}
	
	// 현재날짜
	function nowDate(){
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
	    var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
	    var nowDate = year + "-" + month + "-" + day;
		
	    return nowDate;
	}
	/* 페이징 */
	function fn_guestList(pageNo) {
		$('#mloader').show();
		document.frm.submit();
	}
	
	function showDiv(divId) {
	    // Hide all divs
	    document.getElementById('div1').style.display = 'none';
	    document.getElementById('div2').style.display = 'none';
	    document.getElementById('div3').style.display = 'none';
	    
	    // Show the selected div
	    document.getElementById(divId).style.display = 'block';
	}
</script>

<style>
	td{
		text-align:center;
	}
	
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 310px;
	    max-width: 800px;
	    margin: 1em auto;
	}
	
	#container {
	    height: 400px;
	}
	
	.highcharts-data-table table {
	    font-family: Verdana, sans-serif;
	    border-collapse: collapse;
	    border: 1px solid #ebebeb;
	    margin: 10px auto;
	    text-align: center;
	    width: 100%;
	    max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
	    font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	}
	
	.graph-container {
	    display: flex;
	    justify-content: space-between;
	}
	
	.graph {
	    width: 45%; /* 그래프의 너비 조정 */
	    margin: 10px; /* 그래프 간격 조정 */
	}
</style>

<form id="frm" name="frm" method="post" action="/mes/statistics/kw_asset_tmp_lf.do">
	
	<div class="content_top">
		<div class="content_tit">
			<h2>임시자산 반입출통계</h2>
		</div>
		<div class="filter_wrap"> 
			<div class="search_filter">
				<ul> 
<!-- 				<li> -->
<!-- 	          		<span>조회 구분</span> -->
<!-- 					<select name="ePageGubun" id="ePageGubun" onchange="eNowPage()"> -->
<%-- 						<option value="1" <c:if test="${mesStatisticsVO.ePageGubun eq '1'}">selected</c:if>>사용자기준</option> --%>
<%-- 						<option value="2" <c:if test="${mesStatisticsVO.ePageGubun eq '2'}">selected</c:if>>유형별기준</option> --%>
<%-- 						<option value="3" <c:if test="${mesStatisticsVO.ePageGubun eq '3'}">selected</c:if>>기간별</option> --%>
<!-- 			      	</select> -->
<!-- 			    </li> -->
					<li>
						<span>기간 </span>
						<div class="date">
							<input type="text" name="topStartDate" id="topStartDate" value="${mesStatisticsVO.topStartDate}" readonly/>
				       		-
				           	<input type="text" name="topEndDate"  id="topEndDate"  value="${mesStatisticsVO.topEndDate}" readonly/>
						</div>
					</li>
				</ul>
			</div>
			<div class="button_wrap">
				<button type="button" class="form_btn bg" onclick="fn_guestList(1)">검색</button>
			</div>
		</div>
	</div>
	
	<div class="graph-container">
	     <div id="containerGraph1Div" class="graph" style="cursor:pointer;" onclick="showDiv('div1')">
	     <canvas id="containerGraph1" width="400" height="286"></canvas></div>
	    <div id="containerGraph2Div" class="graph" style="cursor:pointer;" onclick="showDiv('div2')">
	    <canvas id="containerGraph2" width="400" height="286"></canvas></div>
	</div>
	
	<div id="div1"  style="display: block;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th>제조사</th>
	   		  		<th>반입 건수</th>
	   		  		<th>미반출 건수</th>
  		  		</tr>
	   		  </thead>
	   		   <tbody>
	   		 	<c:forEach var="iMakerList" items="${iMakerList}" varStatus="a">
	  		  			<tr>
				   		 	<td>${iMakerList.eWordA}
								<input type="hidden" id="eWordA_${a.index}" name="eWordA" value="${iMakerList.eWordA}">
								<input type="hidden" id="eValueA_${a.index}" name="eValueA" value="${iMakerList.eValueA}">
								<input type="hidden" id="eWordB_${a.index}" name="eValueB" value="${iMakerList.eValueB}">
							</td>
				   		 	<td>${iMakerList.eValueA}</td>
				   		 	<td>${iMakerList.eValueB}</td>
								
						</tr>
	  		  		</c:forEach>
	   		  </tbody>
			</table>
		</div>
	</div>

	<div id="div2"  style="display: none;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th>자산유형</th>
	   		  		<th>반입 건수</th>
	   		  		<th>미반출 건수</th>
  		  		</tr>
	   		  </thead>
	   		   <tbody>
	   		 	<c:forEach var="iTypeList" items="${iTypeList}" varStatus="b">
	  		  			<tr> 
			   		  		<td>${iTypeList.eWordB}
								<input type="hidden" id="eWordB_${b.index}" name="eWordB" value="${iTypeList.eWordB}">
								<input type="hidden" id="eValueC_${b.index}" name="eValueC" value="${iTypeList.eValueC}">
								<input type="hidden" id="eValueD_${b.index}" name="eValueD" value="${iTypeList.eValueD}">
							</td>
				   		 	<td>${iTypeList.eValueC}</td>
				   		 	<td>${iTypeList.eValueD}</td>
						</tr>
	  		  		</c:forEach>
	   		  	</tbody>
			</table>
		</div>
	</div>

	<div id="div3"  style="display: none;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th>기간</th>
	   		  		<th>건수</th>
	  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="statisticsList" items="${statisticsList}" varStatus="status1">
	   		 		<c:if test="${statisticsList.mMaintanceCount > 0}"> 
	  		  			<tr> 
			   		  		<td>
								<c:out value="${statisticsList.eDate}" />
							</td>
							<td>
			   		  			 ${statisticsList.mMaintanceCount} 
							</td>
						</tr>
						</c:if>
	  		  		</c:forEach>
	   		  </tbody>
			</table>
		</div>
	</div>
</form>



<script>
	const eMachineDate = document.getElementsByName('eDate');
	const eMachineDateValue = Array.from(eMachineDate).map(eMachineDate => eMachineDate.value);
 
	const Countst = document.getElementsByName('Countst');
	const CountstValue = Array.from(Countst).map(Countst => parseInt(Countst.value));
 
	
	
// 	--
	const eValueA = document.getElementsByName('eValueA');
	const eValueAValue = Array.from(eValueA).map(eValueA => parseInt(eValueA.value));

	const eWordAa = document.getElementsByName('eWordA');
	const eWordAValuea = Array.from(eWordAa).map(eWordAa => eWordAa.value);
	 
	
	function uncomma(str) {
	    str = String(str);
	    return isNullChk(str.replace(/(,)/g, ''));
	}
	 
	var ctx = document.getElementById('containerGraph1').getContext('2d');

	var chart1 = new Chart(ctx, {
	    type: 'pie',
	    data: {
	        labels: eWordAValuea, // 제조사 이름 배열
	        datasets: [{
	            label: '제조사별 반입 건',
	            data: eValueAValue, // 반입 건수 배열
	            backgroundColor: [
	            	'#CC705C', '#4DCC4D', '#3C61CC', '#CC5291', '#CC6529',
	            	  '#66CC29', '#2999CC', '#CCCC52', '#CC5291', '#6E3F3F',
	            	  '#CCAA29', '#4DCC4D', '#CC654D', '#CC4529', '#3D6E50',
	            	  '#29A629', '#CC7BA3', '#7A91CC', '#A0521A', '#843DCB'
	            ], // 파스텔 톤 색상 배열
	            borderColor: '#fff', // 섹션 간 경계선 색상
	            borderWidth: 2
	        }]
	    },
	    options: {
	    	legend: {
		          display: false 
		        },
	        responsive: true,
	        title: {
	            display: true,
	            text: '제조사별 반입 건',
	            fontSize: 16,
	            fontStyle: 'bold',
	            fontFamily: 'Pretendard',
	            fontColor: '#171D2F'
	        },
	        tooltips: {
	            callbacks: {
	                label: function(tooltipItem, data) {
	                    var dataset = data.datasets[tooltipItem.datasetIndex];
	                    var value = dataset.data[tooltipItem.index];
	                    return '' + data.labels[tooltipItem.index] + ' : ' + value + '건';
	                }
	            }
	        },
	        legend: {
	            display: true,
	            labels: {
	                fontFamily: 'Pretendard',
	                fontSize: 13,
	                fontColor: '#6A6D75'
	            }
	        },
	        responsiveAnimationDuration: 1000
	    }
	});
// 	--
	const eValueB = document.getElementsByName('eValueC');
	const eValueBValue = Array.from(eValueB).map(eValueB => parseInt(eValueB.value));

	const eWordBa = document.getElementsByName('eWordB');
	const eWordBValuea = Array.from(eWordBa).map(eWordBa => eWordBa.value);
	
	var ctx = document.getElementById('containerGraph2').getContext('2d');

	var chart2 = new Chart(ctx, {
	    type: 'bar',
	    data: {
	        labels: eWordBValuea, // 자산유형 이름 배열
	        datasets: [{
	            label: '자산유형별 반입 건',
	            data: eValueBValue, // 자산유형별 반입 건수 배열
	            backgroundColor: [
	            	'#CC705C', '#4DCC4D', '#3C61CC', '#CC5291', '#CC6529',
	            	  '#66CC29', '#2999CC', '#CCCC52', '#CC5291', '#6E3F3F',
	            	  '#CCAA29', '#4DCC4D', '#CC654D', '#CC4529', '#3D6E50',
	            	  '#29A629', '#CC7BA3', '#7A91CC', '#A0521A', '#843DCB'
	            ], // 파스텔 톤 색상 배열
	            borderColor: '#fff', // 막대 간 경계선 색상
	            borderWidth: 2
	        }]
	    },
	    options: {
	    	legend: {
		          display: false 
		        },	   
				    	
	        responsive: true,
	        title: {
	            display: true,
	            text: '자산유형별 반입 건',
	            fontSize: 16,
	            fontStyle: 'bold',
	            fontFamily: 'Pretendard',
	            fontColor: '#171D2F'
	        },
	        tooltips: {
	            callbacks: {
	                label: function(tooltipItem, data) {
	                    var dataset = data.datasets[tooltipItem.datasetIndex];
	                    var value = dataset.data[tooltipItem.index];
	                    return '' + data.labels[tooltipItem.index] + ' : ' + value + '건';
	                }
	            }
	        },
	        scales: {
	            xAxes: [{
	                ticks: {
	                    fontFamily: 'Pretendard',
	                    fontSize: 13,
	                    fontColor: '#6A6D75'
	                }
	            }],
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true,
	                    fontFamily: 'Pretendard',
	                    fontSize: 13,
	                    fontColor: '#6A6D75',
	                    callback: function(value) {
	                        return value + ' 건'; // y축에 '건' 추가
	                    }
	                }
	            }]
	        },
	        responsiveAnimationDuration: 1000
	    }
	});
	
</script>