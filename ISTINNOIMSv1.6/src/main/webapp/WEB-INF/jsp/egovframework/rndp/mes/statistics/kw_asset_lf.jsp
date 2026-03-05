<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>
<meta http-equiv="refresh" content="900">
<link rel="stylesheet" type="text/css" href="/js/jquery-ui-1.14.1/jquery-ui.min.css" />
<script src="/js/Chart/ChartB.js"></script>
<script src="/js/highchart/code/modules/exporting.js"></script>
<script src="/js/highchart/code/modules/export-data.js"></script>

<script type="text/javascript">
	$(document).ready(function(){	
		eDivCheck();
		datepickerSet('topStartDate', 'topEndDate');
		$('#mloader').hide();
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
td {
    text-align:center;
}

.graph-container {
    display: flex;
    justify-content: space-between;
   min-height: calc(100vh - 300px);
}

.graph {
    width: 48%; 
    margin: 10px;
    display: flex;
    align-items: center; 
    justify-content: center;
}

.chart-wrapper {
    display: flex;
    align-items: center;
    padding: 20px;
    width: 100%;
    height: 100%;
    box-sizing: border-box;
}

.chart-area {
    width: 65%; 
    height: 420px; 
    position: relative;
    display: flex;
    justify-content: center;
}

.legend-area {
    width: 35%; 
    max-height: 400px;
    overflow-y: auto;
    overflow-x: hidden;
    border: 1px solid #e2e2e2;
    border-radius: 8px;
    padding: 15px;
    box-sizing: border-box;
}
	
	
</style>

<form id="frm" name="frm" method="post" action="/mes/statistics/kw_asset_lf.do">
	
	<div class="content_top">
		<div class="content_tit">
			<h2>대상장비관리통계</h2>
		</div>
		<div class="filter_wrap"> 
			<div class="search_filter">
				<ul> 
<!-- 				<li> -->
<!-- 			          		<span>조회 구분</span> -->
<!-- 							<select name="ePageGubun" id="ePageGubun" onchange="eNowPage()"> -->
<%-- 								<option value="1" <c:if test="${mesStatisticsVO.ePageGubun eq '1'}">selected</c:if>>제조사기준</option> --%>
<%-- 								<option value="2" <c:if test="${mesStatisticsVO.ePageGubun eq '2'}">selected</c:if>>유형별기준</option> --%>
<%-- 								<option value="3" <c:if test="${mesStatisticsVO.ePageGubun eq '3'}">selected</c:if>>기간별</option> --%>
<!-- 					      	</select> -->
<!-- 					    </li> -->
<!-- 				<li> -->
					<li>
						<span>자산상태</span>
						<select id='searchType' name='searchType'>
							<option value=''>전체</option>
							<c:forEach var='list' items='${gubun37List}'>
								<option value='${list.sGubunKey}' data-value2='${list.sGubunName}'   <c:if test="${mesStatisticsVO.searchType eq list.sGubunKey  }">selected="selected"</c:if> >${list.sGubunName}</option>						
							</c:forEach>
						</select> 
					</li>
					<li>
		           	 	<span>도입일</span>
		           	 	<div class="date">
		           	 		<input type="text" name="topStartDate"  id="topStartDate" value="${mesStatisticsVO.topStartDate}" readonly/>
				       		-
				           	<input type="text" name="topEndDate" id="topEndDate"  value="${mesStatisticsVO.topEndDate}" readonly/>
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
	    <div id="containerGraph1Div" class="graph" >
	        <div class="chart-wrapper">
	            <div class="chart-area">
	                <canvas id="containerGraph1" width="400" height="286"></canvas>
	            </div>
	            <div class="legend-area">
	                <ul id="customLegend1" style="list-style: none; padding: 0; margin: 0;"></ul>
	            </div>
	        </div>
	    </div>
	
	    <div id="containerGraph2Div" class="graph" >
	        <div class="chart-wrapper">
	            <div class="chart-area">
	                <canvas id="containerGraph2" width="400" height="286"></canvas>
	            </div>
	            <div class="legend-area">
	                <ul id="customLegend2" style="list-style: none; padding: 0; margin: 0;"></ul>
	            </div>
	        </div>
	    </div>
	</div>
	
	
	<div id="div1"  style="display: none;" >
		<div class="normal_table">
	 		<table>
	   		  <thead>
	   		  	<tr> 
	   		  		<th>제조사</th>
	   		  		<th>등록 자산 수</th>
	  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="assetmcList" items="${assetmcList}" varStatus="status1">
	  		  			<tr> 
			   		  		<td>
								<c:out value="${assetmcList.sAssetMaker}" />
							</td>
							<td>
			   		  			 ${assetmcList.sAssetCount} 
							</td>
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
	   		  		<th>등록 자산 수</th>
	  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="ieList" items="${ieList}" varStatus="status1">
	  		  			<tr> 
			   		  		<td>
								${ieList.sAssetMaker}
								<input type="hidden" id="eValueA_${status1.index}" name="eValueA" value="${ieList.sAssetCount}">
								<input type="hidden" id="eWordA_${status1.index}" name="eWordA" value="${ieList.sAssetMaker}">
							</td>
							<td>
			   		  			 ${ieList.sAssetCount} 
							</td>
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
	   		  		<th>자산유형</th>
	   		  		<th>등록 자산 수</th>
	  		  		</tr>
	   		  </thead>
	   		  <tbody>
	   		 	<c:forEach var="ieList" items="${ieList}" varStatus="status1">
	  		  			<tr> 
			   		  		<td>
								<c:out value="${ieList.sAssetMaker}" />
							</td>
							<td>
			   		  			 ${ieList.sAssetCount} 
							</td>
						</tr>
	  		  		</c:forEach>
	   		  </tbody>
	   		  <tbody id="lineRow3">	
				<tr>
					<td colspan="2">표시할 데이터가 없습니다.</td>
				</tr>		
				</tbody>
			</table>
		</div>
	</div>
	
	<c:forEach var="assetList" items="${assetList}" varStatus="i">
		<c:if test="${assetList.sAssetCount > 0}">
		<input type="hidden" id="eDate_${i.index}" name="eDate" value="${assetList.eDate}">
		<input type="hidden" id="sAssetCount_${i.index}" name="sAssetCount" value="${assetList.sAssetCount}">
		</c:if>
	</c:forEach>

	<c:forEach var="assetmcList" items="${assetmcList}" varStatus="j">
		<c:if test="${assetmcList.sAssetCount > 0}">
		<input type="hidden" id="sAssetMaker_${j.index}" name="sAssetMaker" value="${assetmcList.sAssetMaker}">
		<input type="hidden" id="sAssetmcCount_${j.index}" name="sAssetmcCount" value="${assetmcList.sAssetCount}">
		</c:if>
	</c:forEach>

	<c:forEach var="environmentList" items="${environmentList}" varStatus="k">
		<input type="hidden" id="maxtemperature_${k.index}" name="maxtemperature" value="${environmentList.maxtemperature}">
		<input type="hidden" id="mintemperature_${k.index}" name="mintemperature" value="${environmentList.mintemperature}">
		<input type="hidden" id="environmentName_${k.index}" name="environmentName" value="${environmentList.environmentName}">
	</c:forEach>
</form>



<script>
    const eMachineDate = document.getElementsByName('eDate');
    const eMachineDateValue = Array.from(eMachineDate).map(eMachineDate => eMachineDate.value);
    
    const sAssetCount = document.getElementsByName('sAssetCount');
    const sAssetCountValue = Array.from(sAssetCount).map(sAssetCount => parseInt(sAssetCount.value));
    
    const sAssetmcCount = document.getElementsByName('sAssetmcCount');
    const sAssetmcCountValue = Array.from(sAssetmcCount).map(sAssetmcCount => parseInt(sAssetmcCount.value));

    const sAssetieCount = document.getElementsByName('sAssetieCount');
    const sAssetieCounttValue = Array.from(sAssetieCount).map(sAssetieCount => parseInt(sAssetieCount.value));
    
    const sAssetMaker = document.getElementsByName('sAssetMaker');
    const sAssetMakerValue = Array.from(sAssetMaker).map(sAssetMaker => sAssetMaker.value);

    const sAssetUesType = document.getElementsByName('sAssetUesType');
    const sAssetUesTypeValue = Array.from(sAssetUesType).map(sAssetUesType => sAssetUesType.value);

    function uncomma(str) {
        str = String(str);
        return isNullChk(str.replace(/(,)/g, ''));
    }

    const eValueA = document.getElementsByName('eValueA');
    const eValueAValue = Array.from(eValueA).map(eValueA => parseInt(eValueA.value));

    const eWordAa = document.getElementsByName('eWordA');
    const eWordAValuea = Array.from(eWordAa).map(eWordAa => eWordAa.value);


  
    const pieColors_old = [
        '#CC705C', '#4DCC4D', '#3C61CC', '#CC5291', '#CC6529',
        '#66CC29', '#2999CC', '#CCCC52', '#CC5291', '#6E3F3F',
        '#CCAA29', '#4DCC4D', '#CC654D', '#CC4529', '#3D6E50',
        '#29A629', '#CC7BA3', '#7A91CC', '#A0521A', '#843DCB'
    ];
	const pieColors = [
        '#4869fb', '#1fccb4', '#ff8c42', '#f9d857', '#9c6dfb', 
        '#6f9df9', '#f96d6d', '#4ed99b', '#3d60f9', '#f96df9', 
        '#5acdf9', '#a9e98d', '#2638a9', '#d96df9', '#8dd8f9', 
        '#a1b8d9', '#29b4d9', '#b98df9', '#8df9e9', '#cbd9e9'  
    ];

    let chart1Labels = [];
    let chart1Data = [];
    let chart1BgColors = [];
    let otherCount1 = 0; // 기타(나머지)
    
    const isOverSix1 = sAssetMakerValue.length >= 7; 

    for (let i = 0; i < sAssetMakerValue.length; i++) {
        if (isOverSix1 && i >= 5) {
            // 7개 이상이면서 6번째(index 5) 항목부터는 기타로 합산
            otherCount1 += sAssetmcCountValue[i];
        } else {
            // 6개 이하거나, 7개 이상이어도 Top 5 안에 드는 경우
            chart1Labels.push(sAssetMakerValue[i]);
            chart1Data.push(sAssetmcCountValue[i]);
            chart1BgColors.push(pieColors[i % pieColors.length]);
        }
    }

    // 7개 이상일 때만 마지막에 '기타' 조각 하나 추가
    if (isOverSix1) {
        chart1Labels.push('기타');
        chart1Data.push(otherCount1);
        chart1BgColors.push('#d1d5db');
    }
    

    var ctx1 = document.getElementById('containerGraph1').getContext('2d');
    var chart1 = new Chart(ctx1, {
        type: 'pie',
        data: {
            labels: chart1Labels, 
            datasets: [{
                label: '제조사별',
                data: chart1Data, 
                backgroundColor: chart1BgColors, 
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            layout: { padding: 0 }, 
            title: { display: true, text: '제조사별', fontSize: 16, fontStyle: 'bold', fontFamily: 'Pretendard', fontColor: '#171D2F' },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        var dataset = data.datasets[tooltipItem.datasetIndex];
                        var value = dataset.data[tooltipItem.index];
                        return '' + data.labels[tooltipItem.index] + ' : ' + value + '식';
                    }
                }
            },
            legend: { display: false },
            responsiveAnimationDuration: 1000
        }
    });
    

    let legendHtml1 = '';
    for (let i = 0; i < sAssetMakerValue.length; i++) {
      //  let color = pieColors[i % pieColors.length];
        let color = (isOverSix1 && i >= 5) ? '#d1d5db' : pieColors[i % pieColors.length];
        
        let fullName = sAssetMakerValue[i];
        let shortName = fullName.length > 15 ? fullName.substring(0, 15) + '...' : fullName;

        legendHtml1 += '<li style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #f4f4f4;">' +
            '<div style="display: flex; align-items: center; flex: 1; min-width: 0; padding-right: 10px;">' + 
                '<span style="display: inline-block; flex-shrink: 0; width: 12px; height: 12px; background-color: ' + color + '; margin-right: 8px; border-radius: 2px;"></span>' +
                '<span title="' + fullName + '" style="font-size: 13px; font-family: \'Pretendard\'; color: #555; display: block; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; min-width: 0;">' + shortName + '</span>' +
            '</div>' +
            '<span style="font-size: 13px; font-weight: bold; font-family: \'Pretendard\'; flex-shrink: 0;">' + sAssetmcCountValue[i] + '식</span>' +
        '</li>';
    }
    document.getElementById('customLegend1').innerHTML = legendHtml1;



    var ctx2 = document.getElementById('containerGraph2').getContext('2d');
    var chart2 = new Chart(ctx2, {
        type: 'pie',
        data: {
            labels: eWordAValuea,
            datasets: [{
                label: '자산유형별',
                data: eValueAValue,
                backgroundColor: pieColors,
                borderColor: '#fff',
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            title: { display: true, text: '자산유형별', fontSize: 16, fontStyle: 'bold', fontFamily: 'Pretendard', fontColor: '#171D2F' },
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        var dataset = data.datasets[tooltipItem.datasetIndex];
                        var value = dataset.data[tooltipItem.index];
                        return '' + data.labels[tooltipItem.index] + ' : ' + value + '식';
                    }
                }
            },
            legend: { display: false }, // 범례 숨김
            responsiveAnimationDuration: 1000
        }
    });

    let legendHtml2 = '';
    for (let i = 0; i < eWordAValuea.length; i++) {
        let color = pieColors[i % pieColors.length];
        
        let fullName = eWordAValuea[i];
        let shortName = fullName.length > 15 ? fullName.substring(0, 15) + '...' : fullName;

        legendHtml2 += '<li style="display: flex; justify-content: space-between; align-items: center; padding: 8px 0; border-bottom: 1px solid #f4f4f4;">' +
            '<div style="display: flex; align-items: center; flex: 1; min-width: 0; padding-right: 10px;">' + 
                '<span style="display: inline-block; flex-shrink: 0; width: 12px; height: 12px; background-color: ' + color + '; margin-right: 8px; border-radius: 2px;"></span>' +
                '<span title="' + fullName + '" style="font-size: 13px; font-family: \'Pretendard\'; color: #555; display: block; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; min-width: 0;">' + shortName + '</span>' +
            '</div>' +
            '<span style="font-size: 13px; font-weight: bold; font-family: \'Pretendard\'; flex-shrink: 0;">' + eValueAValue[i] + '식</span>' +
        '</li>';
    }
    document.getElementById('customLegend2').innerHTML = legendHtml2;
</script>