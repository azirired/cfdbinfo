<cfquery name='Qload' datasource='dmanamelaka'>
									SELECT top 20 *
									FROM pcrs_timelogger
									</cfquery>
									<!DOCTYPE html>
						<html>
						<head>
						<style>
						#tableKu {
						  font-family: Arial, Helvetica, sans-serif;
						  border-collapse: collapse;
						  width: 100%;
						}

						#tableKu td, #tableKu th {
						  border: 1px solid #ddd;
						  padding: 8px;
						}

						#tableKu tr:nth-child(even){background-color: #f2f2f2;}

						#tableKu tr:hover {background-color: #ddd;}

						#tableKu th {
						  padding-top: 12px;
						  padding-bottom: 12px;
						  text-align: left;
						  background-color: #4CAF50;
						  color: white;
						}
						</style>
						</head>
						<body>
									<table id=tableKu border=1>

									<tr><th>Row</th><th>id</th><th>noic</th><th>userid</th><th>defaultdeptID</th><th>checktime</th><th>catatan</th><th>waktuBerperingkat</th><th>tkhWPMula</th><th>tkhWPLast</th></tr>
									
									<cfoutput query='Qload'>
										<cfset bil=#bil#+1>
									
										<tr><td>#bil#</td><td>#id#</td><td>#noic#</td><td>#userid#</td><td>#defaultdeptID#</td><td>#checktime#</td><td>#catatan#</td><td>#waktuBerperingkat#</td><td>#tkhWPMula#</td><td>#tkhWPLast#</td> </tr>
									</cfoutput>
								</table>
								</body></html>
