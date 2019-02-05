
<style>
	table {
		font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
		border-collapse: collapse;
		width:100%;
	}
	table,tr,td{
		border:1px solid red;
		padding:8px;

	}
</style>


<cfparam name="ops" default="0">
<cfparam name="showData" default="0">
<cfparam name="TotalData" default="10">
<cfset bil=0>

<cfoutput>
	
	<form action="index.cfm" >
		<input type="hidden" name="ops" value="tables">
		<label>Datasource : </label>
		<input type="text" size="50" name="dsn" >
		<input type="submit" name="submit" value="GO">

	</form>
	
	<p>
	<table>
	<tr>
		<td valign="top">
			<h1>Tables</h1>
			<cfif isDefined('dsn')>
				<cfdbinfo 
					type="tables" 
					datasource="#dsn#" 
					name="dbdata"> 

					<cfloop query="dbdata">
						<cfif ucase(dbdata.table_type) EQ "TABLE">
			             <a href="index.cfm?ops=columns&dsn=#dsn#&table=#dbdata.table_name#&showData=#showData#&TotalData=#TotalData#">#dbdata.table_name#</a><br>
			         </cfif>
			        </cfloop>
		    </cfif>
		</td>
			
		<cfif isDefined('table')>
			<td valign="top">
				<h1>Table : #table#</h1>

				<cfif isDefined('table')>
					<cfdbinfo
					    type="columns"
					    datasource="#dsn#"
					    name="dbdata"
					    table="#table#">
					<cfset txt="">
					<cfset bil=0>

				    <table>
			    	<tr>
			    		<td>Column Name</td>
			    		<td>Type Name</td>
			    		<td>Column Size</td>
			    		<td>is Null</td>
			    	</tr>

			    	<!---numbers of row--->
			    	<cfset txt="<tr><td>##bil##</td>">
			    	<!---header --->	
			    	<cfset dbHeader="<th>Row</th>">
				    <cfloop query="dbdata">
					    <tr>
					    	<td>
				             	<a href="index.cfm?ops=columns&dsn=#dsn#&table=#dbdata.table_name#&txt=#dbdata.column_name#">#dbdata.column_name#</a>
				             	<!--- set table header--->
				             	<cfset dbHeader="#dbHeader#<th>#dbdata.column_name#</th>">
				             	<!--- data--->
				             	<cfset txt="#txt#<td>###dbdata.column_name###</td>">
				             </td>
				             <td>#dbdata.type_name#</td> 
				             <td>#dbdata.column_size#</td>
				             <td>#dbdata.is_nullable#</td>
				             
				    </cfloop>	
				    	<!---close row--->
				        <cfset txt="#txt# </tr>">
			        </table>

		        	<cfif showData EQ 1>
		        		<input type="checkbox" onchange="if(this.checked) document.location.href='index.cfm?ops=columns&dsn=#dsn#&table=#dbdata.table_name#&showData=0';"/> Hide Data 
		        	<cfelse>
		        		<input type="checkbox" onchange="if(this.checked) document.location.href='index.cfm?ops=columns&dsn=#dsn#&table=#dbdata.table_name#&showData=1';"/> Show Data
		        	</cfif>

			        <cfif showData EQ 1>	
				        <form action="index.cfm" method="post">	
				        	<input type="hidden" name="ops" value="columns">	
				        	<input type="hidden" name="dsn" value="#dsn#">
				        	<input type="hidden" name="table" value="#dbdata.table_name#">
				        	<input type="hidden" name="showData" value="1">
				        	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

				        	<cfset urlS="index.cfm?ops=columns&dsn=#dsn#&table=#dbdata.table_name#&showData=1&TotalData=">
					        	Show 
				        	<select onchange="if (this.value) window.location.href=this.value">
				        		<cfif TotalData EQ "10">
							    	<option value="#urlS#10" selected>10</option>
							    <cfelse>
									<option value="#urlS#10">10</option>
							    </cfif>
							    <cfif TotalData EQ "20">
							    	<option value="#urlS#20" selected>20</option>
							    <cfelse>
									<option value="#urlS#20">20</option>
							    </cfif>
							    <cfif TotalData EQ "50">
							    	<option value="#urlS#50" selected>50</option>
							    <cfelse>	
							    	<option value="#urlS#50">50</option>
							    </cfif>	
							    <cfif TotalData EQ "100">
							    	<option value="#urlS#100" selected>100</option>	
							    <cfelse>	
							    	<option value="#urlS#100">100</option>
							    </cfif>
							</select>
							&nbsp;rows
				        	
				    	</form>
				    </cfif>
				</cfif>
				<cfset txt="#txt#">

				<!---create html header--->
				<cfset htmlHeader="<!DOCTYPE html>
					<html>
					<head>
					<style>
					##tableKu {
					  font-family: Arial, Helvetica, sans-serif;
					  border-collapse: collapse;
					  width: 100%;
					}

					##tableKu td, ##tableKu th {
					  border: 1px solid ##ddd;
					  padding: 8px;
					}

					##tableKu tr:nth-child(even){background-color: ##f2f2f2;}

					##tableKu tr:hover {background-color: ##ddd;}

					##tableKu th {
					  padding-top: 12px;
					  padding-bottom: 12px;
					  text-align: left;
					  background-color: ##4CAF50;
					  color: white;
					}
					</style>
					</head>
					<body>">
				<cfset htmlFooter="</body></html>">

				<cfset content="<cfquery name='Qload' datasource='#dsn#'>
								SELECT top #TotalData# *
								FROM #table#
								</cfquery>
								#htmlHeader#
								<table id=tableKu border=1>

								<tr>#dbHeader#</tr>
								
								<cfoutput query='Qload'>
									<cfset bil=##bil##+1>
								
									#txt#
								</cfoutput>
							</table>
							#htmlFooter#">

				<!---if user want to see a data--->
				<cfif #showdata# EQ 1>
					<!---create and save file--->
					<cffile
						action = "write"
						file = #ExpandPath("q.cfm")# 
						output = "#content#">

					<p><h1>Data</h1><cfinclude template="q.cfm"></p>
				</cfif>
			</td>
		</cfif>
	</tr>
	</table>

	<!---</cfif>--->
</cfoutput>
