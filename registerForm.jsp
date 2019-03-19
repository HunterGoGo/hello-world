<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register form</title>
<style type="text/css">
	table { border-collapse:collapse; }  
	th, td { border:1px solid gray; }
</style>
<script type="text/javascript">
	function add_row(tbody) {
		if (tbody != "my-tbody") {
			tbody = "my-tbody-" + tbody;
		}
		// console.log("tbody : " + tbody);
		var my_tbody = document.getElementById(tbody);
		var getRow = my_tbody.getElementsByTagName("tr");
		var val = my_tbody.rows.length;
		var str;
		if (val == 0) {
			str = 1;
		} else {
			str = getRow[val-1].childNodes[0].firstChild.data;
			str++;
		}
		 
	    // var row = my_tbody.insertRow(0); // 상단에 추가
	    var row = my_tbody.insertRow(val); // 하단에 추가
	    var cell1 = row.insertCell(0);
	    var cell2 = row.insertCell(1);
	    var cell3 = row.insertCell(2);
	    var cell4 = row.insertCell(3);
	    var cell5 = row.insertCell(4);
	    cell1.innerHTML = str;
	    cell2.innerHTML = new Date().toUTCString();
	    if (tbody == "my-tbody") {
	    	cell3.innerHTML = "<input type=\"text\" name=\"sub_" + str + "\" id=\"sub_" + str +
	    		"\" onchange=\"check_value(this)\" onfocus=\"check_text(this)\"/>";
	    } else {
	    	cell3.innerHTML = "";
	    }
	    cell4.innerHTML = "<input name=\"add_" + str + "\" id=\"add_" + str + "\" type=\"text\"/>";
	    cell5.innerHTML = "<input name=\"btn_" + str + "\" id=\"btn_" + str +
	    		"\" type=\"button\" value=\"삭제\" onclick=\"delete_row(this,'','" + tbody + "')\"/>";
	}
	
	function check_text(obj) {
		var id = obj.getAttribute("id");
		var id_value = document.getElementById(id).getAttribute("id");
		var element = document.getElementById(id_value);
		var value = element.value;
		console.log("id_value : " + id_value);
		if (value != null && value.length > 0) {
			element.onkeyup = function() {
				this.setAttribute("onchange", "");
				var targetElement = document.getElementById("title_" + id_value);
				var targetElement1 = document.getElementById(id_value + "_td1");
				var targetElement2 = document.getElementById(id_value + "_input1");
				targetElement.innerHTML = "전문 Layout (" + this.value + ")";
				targetElement1.innerHTML = this.value;
				targetElement2.value = this.value;
				console.log("value : " + this.value);
			}
		}
	}
	
	function del_layer(obj) {
		var id = obj.getAttribute("id");
		var del_id_div = document.getElementById(id).getAttribute("id");
		del_id_div = "div_" + del_id_div;
		var del_id = document.getElementById(del_id_div);
		if (del_id != null) {
			del_id.innerHTML = "";
			console.log("삭제!!!");
		}
	}
	
	function delete_row(obj, id, tbody) {
		if (id != "") {
			var element = document.getElementById(id);
			element.parentNode.removeChild(element);
		}
		var idx = obj.parentElement.parentElement.rowIndex;
		var my_tbody = document.getElementById(tbody);
	    if (my_tbody.rows.length < 1) return;
	    // my_tbody.deleteRow(0); // 상단부터 삭제
	    // my_tbody.deleteRow(my_tbody.rows.length-1); // 하단부터 삭제
	    my_tbody.deleteRow(idx-1);
	}
	
	
	function check_value(obj) {
		var id = obj.getAttribute("id");
		var value = document.getElementById(id).value;
		var del_id = value;
		var id_value = document.getElementById(id).getAttribute("id");
		if (value.length > 0) {
			var id_value_num = id_value.substr(id_value.length - 1);
			var id_sub_value = document.getElementById("sub_" + id_value_num).value;
			document.getElementById("btn_" + id_value_num).setAttribute("onclick", "delete_row(this,'div_sub_" + id_value_num +"','my-tbody')");
			
			add_tbl(obj);
			
			alert("전문Layout (" + value + ") 를 작성하세요.");
		} else {
			var sub = document.getElementById("sub");
			var body = document.getElementById("my-tbody");
			var id = obj.getAttribute("id");
			var del_id_div = document.getElementById(id).getAttribute("id");
			del_id_div = "div_" + del_id_div;
			var del_id = document.getElementById(del_id_div);
			del_id.innerHTML = "";
		}
	}
	
	function add_tbl(obj) {
		var id = obj.getAttribute("id");
		var id_value = document.getElementById(id).value;
		var value_id = document.getElementById(id).getAttribute("id");
		var tbl1_select = document.getElementById("input2");
		var selected_val = tbl1_select.options[tbl1_select.selectedIndex].value;
		var table = document.getElementById("sub");
		table.innerHTML += "<div id=\"div_" + value_id +"\">\n" +
						   "	<input type=\"hidden\" name=\"" + value_id + "_input1\" id=\"" + value_id + "_input1\" value=\"" + id_value + "\"/>\n" +
						   "	<input type=\"hidden\" name=\"" + value_id + "_input2\" id=\"" + value_id + "_input2\" value=\"" + selected_val + "\"/>\n" +
						   "	<br/>\n" +
						   "	<h3><span id=\"title_" + value_id + "\">전문 Layout (" + id_value + ")</span></h3>" +
						   "	<input type=\"button\" value=\"행추가하기\" onclick=\"add_row('" + value_id + "')\"/>\n" +
						   "	<p/>\n" +
						   "	<table>\n" +
						   "		<tr>\n" +
						   "			<td>" + value_id + "</td>\n" +
						   "			<td id=\"" + value_id + "_td1\">" + id_value + "</td>\n" +
						   "		</tr>\n" +
						   "		<tr>\n" +
						   "			<td>" + selected_val + "</td>\n" +
						   "			<td id=\"" + value_id + "_td2\">" + selected_val + "</td>\n" +
						   "		</tr>\n" +
						   "		<tr>\n" +
						   "			<td>" + value_id + "_input3</td>\n" +
						   "			<td><input type=\"text\" size=\"30\" name=\"" + value_id + "_input3\" id=\"" + value_id + "_input3\"/></td>\n" +
						   "		</tr>\n" +
						   "	</table>\n" +
						   "		<hr/>\n" +
						   "		<table id=\"" + value_id + "_tbl\">\n" +
						   "			<thead>\n" +
			  			   "			<tr>\n" +
			    		   "				<th>번호</th>\n" +
			    		   "				<th>일자</th>\n" +
			    		   "				<th>서브메시지</th>\n" +
			    		   "				<th>선택지</th>\n" +
			    		   "				<th>항목삭제</th>\n" +
			    		   "			</tr>\n" +
						   "			</thead>\n" +
						   "			<tbody id=\"my-tbody-" + value_id + "\">\n" +
						   "			</tbody>\n" +
						   "		</table>\n" +
						   "</div>";
	}
	
	function sub_change_value() {
		var tbl1_select = document.getElementById("input2");
		var selected_val = tbl1_select.options[tbl1_select.selectedIndex].value;
		var body = document.getElementById("my-tbody");
		for (var i = 1; i < body.childNodes.length; i++) {
			var td_val = body.rows[i - 1].cells[0].innerHTML;
			var val = document.getElementById("sub_" + td_val).value;
			if (val != "") {
				var id_val = "sub_" + td_val;
				var target_hidden = document.getElementById(id_val + "_input2");
				target_hidden.setAttribute("value", selected_val);
				var target_td = document.getElementById(id_val + "_td2");
				target_td.innerHTML = selected_val;
			}
		}
	}
</script>
</head>
<body>
<form name="registerForm" id="registerForm" method="post" action="register.jsp">
<div id="cloneSource">
<br/>
<input name="btn" type="button" value="행 추가하기" onclick="add_row('my-tbody')"/>
<p></p>
<table>
	<tr>
		<td>input1</td>
		<td><input name="input1" id="input1" type="text" size="30"/></td>
	</tr>
	<tr>
		<td>input2</td>
		<td>
			<select name="input2" id="input2" onchange="sub_change_value()">
				<option value="NM1">NM1</option>
				<option value="NM2">NM2</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>input3</td>
		<td><input  name="input3" id="input3" type="text" size="30"/></td>
	</tr>
</table>
<hr/>
<table id="tbl">
	<thead>
	  	<tr>
	    	<th>번호</th>
	    	<th>일자</th>
	    	<th>서브메시지</th>
	    	<th>선택지</th>
	    	<th>항목삭제</th>
	    </tr>
	</thead>
	<tbody id="my-tbody">
	</tbody>
</table>
</div>
<div id="sub">
</div>
</form>
</body>
</html>