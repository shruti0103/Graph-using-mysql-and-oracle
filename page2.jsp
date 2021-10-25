<%@ include file="conn.jsp"%>
<%@ page  language = "java" import="java.sql.*,java.util.*,java.io.*" session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>New Page</title>

	<link rel="stylesheet" type="text/css" href="style.css">

	<script src="./charts/loader.js"></script>
	<script type="text/javascript">
		var inp={
			col1:[],
			col2:[],
			col3:[]
		};
		 var titlP;
		 var titlC;
		 var i=0;
		 var anm=1;
		 var pie=1;
		
		<%	String test ="";
			String query="select * from "+tb_name ;
			Statement stmt=null;
			stmt= con.createStatement();
			ResultSet rs=stmt.executeQuery(query);
			ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
			int colCount= rsmd.getColumnCount();
			test = rsmd.getColumnName(2);
		%>   
			titlP="<%=test%>";
		   	titlC="<%=tb_name%>";
			
		 function getname(na){
		 	var th1=document.getElementsByTagName("th")[1].textContent;

  			if(na==th1){
  				titlP=na;
  				pie=1;
  				
  			}else{
  				titlP=na;
  				pie=0;
  			}
  			drawChart();
  		}	
  			<%for(int i=1;i<=colCount;i++){
  				if(i==1){%>
  					inp.col1.push("<%=rsmd.getColumnName(i)%>");
				<%}
				if(i==2){%>
  					inp.col2.push("<%=rsmd.getColumnName(i)%>");
				<%}
				if(i==3){%>
  					inp.col3.push("<%=rsmd.getColumnName(i)%>");
				<%}
		    	
				}%>
			
		<% int b=0;	
		while(rs.next()){
				String part[] =rs.getString(2).split("\\s");
				int a = Integer.parseInt(part[0]);
				if(colCount==3){
					String part2[] =rs.getString(3).split("\\s");
					 b = Integer.parseInt(part2[0]);
				}
				String ele = rs.getString(1);
				String s1=ele.trim();
				if(a!=0||b!=0){
			if(colCount==3){
		%>		var a3="<%=b%>";	
				inp.col3.push(a3);
				<%}%>
				var a1="<%=s1%>";
				inp.col1.push(a1);
				var a2="<%=a%>";
				inp.col2.push(a2);
					
			<%} }
			rs.close();%>
			
			google.charts.load("current", {packages:["corechart"]});
   			google.charts.setOnLoadCallback(drawChart);
   			function drawChart() {
						var data = new google.visualization.DataTable();
	      				data.addColumn('string', inp.col1[0]);
	      				data.addColumn('number',inp.col2[0]);
	      				data.addColumn('number', inp.col3[0]);
	      				var data1 = new google.visualization.DataTable();
	      				data1.addColumn('string', inp.col1[0]);
	      				data1.addColumn('number', inp.col3[0]);
		      				for(i=1;i<inp.col1.length;i++){
		      					data.addRow([inp.col1[i],parseInt(inp.col2[i]),parseInt(inp.col3[i])]);
		      					data1.addRow([inp.col1[i],parseInt(inp.col3[i])]);
		      				}    		
	      				var chartP = new google.visualization.PieChart(document.getElementById('pChart'));
	      				var chartC = new google.visualization.ColumnChart(document.getElementById('cChart'));
	       		
	      		
	      				var options1 ={
	     		    			title:titlP,
	     		    			titleTextStyle:{
	     		    			bold:true	
	     		    			},
	        					is3D:true,

	        					legend:{
	        						position:'right',
	        						textStyle:{
	        							fontSize:13
	        						}
	        					},
	        					chartArea:{left:70,top:150,right:50,width:'50%',height:'50%'},

	         					backgroundColor:'#CCFFFF',
	         					slices:{
	         						1:{color:'orange'},
	         						2:{color:'blue'}
	         					}
	    					};
	      			if(pie==1){
	      				chartP.draw(data, options1);
	      			}else
	      			{
	        			chartP.draw(data1, options1);
	      			}
	        		
	      		
	      			if(anm==1){
	      				var options ={
	     		    			title:titlC,
	     		    			colors:['blue','green'],
	     		    			animation:{
	     		    				duration:1000,
	     		    				easing:'out',
	     		    				startup:true
	     		    			},
	     		    			titleTextStyle:{
	     		    				bold:true	
	     		    			},
	     		    			hAxis:{
	     		    				maxAlternation:1,
	     		    				slantedText:false,
	     		    				minTextSpacing:0,
	     		    				textStyle:{
	     		    					fontSize:12
	     		    				}
	     		    		     },
	     		    			chartArea:{left:90,top:150,right:70,width:'50%',height:'60%'},
	        					legend	:{
	        						position:'top',
	        						alignment:'end'
	        					},
	         					backgroundColor:'#CCFFFF'
	    					};
	    				anm	=anm+1;
	      				chartC.draw(data, options);	
	      			}	
	      	}
	</script>
</head>
<body>
<%	
		
		int i;
		
		rs = stmt.executeQuery(query);
		%>

		<h3>Bhilai Steel Plant</h3>
		<h4>Released PRs pending for Enquiry Since 01-04-2017</h4>
		<p><i>Report based on SAP Data Dated : 18-MAR-2021</i></p>


		<table cellpadding="0" width="400px" cellspacing="0"  ><tr>
		<% for(i=1 ; i<= colCount;i++){%>
			<%if(i==1){%>

				<th >
					<%=rsmd.getColumnName(i)%>
				</th>
			<%}else{%>
			<th onclick="getname(this.textContent)">
					<%=rsmd.getColumnName(i)%>
			</th>
		<%}}	

		rs.close();%>
		</tr>
		<%  rs = stmt.executeQuery(query); %>
		 
		 	<% while(rs.next()){%>
		 <tr>
		 	<%for(i=1;i<=colCount; i++){%>
		 	<%if(i==1){%>
		 		<td class="td"><font size="2"><%= rs.getString(i)%></font></td>
		 		<%}else{%>
		 		<td class="link"><font size="2"><a href="#" ><%= rs.getString(i)%></a></font></td>
			<% }}%>
		 </tr>

		<%} rs.close();
		con.close();%>
		</table>
		
				<div id="pChart" style="width:40%;height:500px; display: inline-block;float:left;" ></div>
				<div id="cChart" style="width:55%;height:500px; display: inline-block;float:right;" ></div>
			
			
	</body>
</html>