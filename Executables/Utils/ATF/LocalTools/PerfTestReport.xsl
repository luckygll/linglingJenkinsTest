<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="TestReport_Sum.xsl"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="Report">
		<html>
			<div align="center">
			<body style="margin:5">
			<H1 align="center">Performance Test  Automation  Report</H1>
				<div id="KB1Parent" class="parent">
					<H2>- Test Properties -</H2>
				</div>
				<div id="KB1Child" class="child">
				<xsl:for-each select="/Report/TestProperties">
				<table border="0" cellpadding="0" cellspacing="2"><tr><td></td></tr></table>
					<table cellspacing="2" bgcolor="LightBlue" width="1400">
					<tr>
					<col width="300"/>
				        <col width="900"/>
					<td><font face="Arial" size="3">Test Start Time:</font></td>
					<td><font face="Arial" size="3"><xsl:value-of select="@TestStartTime"/></font></td>
					</tr>
					<tr>
					<col width="300"/>
				        <col width="900"/>
					<td><font face="Arial" size="3">Test Finish Time:</font></td>
					<td><font face="Arial" size="3"><xsl:value-of select="@TestFinishTime"/></font></td>
					</tr>
					<tr>
					<col width="300"/>
				        <col width="900"/>
					<td><font face="Arial" size="3">Test Duration:</font></td>
					<td><font face="Arial" size="4"><xsl:value-of select="@TestDuration"/></font></td>
					</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0"><tr><td></td></tr></table>
					<table cellspacing="2" bgcolor="LightBlue">
					</table>
			        </xsl:for-each>
					<table cellspacing="2" bgcolor="LightBlue" width="1400">
					<tr>
					<td align="left" width="300"><font face="Arial" size="3"><b>Test Server Name</b></font></td>
					<td align="left" width="300"><font face="Arial" size="3"><b>Test Server IP</b></font></td>
					<td align="left" width="600"></td>
					</tr>
					<xsl:for-each select="/Report/TestProperties/MachineList">
					<tr>
						<td align="left" width="300"><font face="Arial" size="3"><xsl:value-of select="@TestMachineName"/></font></td>
						<td align="left" width="300"><font face="Arial" size="3"><xsl:value-of select="@TestMachineIP"/></font></td>
					</tr>
					</xsl:for-each>
					</table>
				</div>
				<div id="KB2Parent" class="parent">
					<H2>- Performance Test Limit Range -</H2>
				</div>
				<div id="KB2Child" class="child">
				<xsl:for-each select="/Report/PerformanceLimit">
					<tr>
						<B><font face="Arial" size="5" color="red" >
						<td align="left" width="300"><xsl:value-of select="@BoundLow"/></td>
						~
						<td align="left" width="300"><xsl:value-of select="@BoundHigh"/></td>
						  Messages/Second
						</font></B>
					</tr>
				</xsl:for-each>
				</div>
				<div id="KB3Parent" class="parent">
						<H2>- Test Statistics -</H2>
				</div>
				<div id="KB3Child" class="child">
				<xsl:for-each select="/Report/Statistic">
					<table id="TestStat" cellspacing="2" bgcolor="LightBlue" width="1400">
					<td align="center" width="260"><font face="Arial" size="4" color="#000000">Total Test Cases: <xsl:value-of select="@TotalCase"/></font></td>
					<td align="center" width="260"><font face="Arial" size="4" color="#000000">Pass: <xsl:value-of select="@CasePass"/></font></td>
					<td align="center" width="260"><font face="Arial" size="4" color="#000000">Fail: <xsl:value-of select="@CaseFail"/></font></td>
					<td align="center" width="260"><font face="Arial" size="4" color="#000000">Time Out: <xsl:value-of select="@CaseTimeOut"/></font></td>
					<td align="center" width="260"><font face="Arial" size="4" color="#000000">Not Run: <xsl:value-of select="@CaseNotRun"/></font></td>
					<td align="center" width="260"><font face="Arial" size="4" color="#000000">Pass Rate: <xsl:value-of select="@CasePassRate"/> %</font></td>
					</table>
				</xsl:for-each>
				</div>
				<div id="KB4Parent" class="parent">
						<H2>- Test Results Summary -</H2>
				</div>
				
				<div id="KB4Child" class="child">
				<table id="TestStat" cellspacing="2" bgcolor="LightBlue" width="1400">
				<tr>
					<td align="left" width="400"><font face="Arial" size="4"><b>Test Case Name</b></font></td>
					<td align="left" width="200"><font face="Arial" size="4"><b>Case Status</b></font></td>
					<td align="left" width="600"><font face="Arial" size="4"><b>Execution Duration</b></font></td>
				</tr>
				<xsl:for-each select="/Report/ResultList/TestCase">
					<tr>
						<td><xsl:value-of select="@CaseName"/></td>
						<xsl:if test="@CaseStatus='Pass'">
						<td align="left"><font color="green" size="4"><xsl:value-of select="@CaseStatus"/></font></td>
						</xsl:if>
						<xsl:if test="@CaseStatus='Fail'">
						<td align="left"><b><font color="red" size="4"><xsl:value-of select="@CaseStatus"/></font></b></td>
						</xsl:if>
						<xsl:if test="@CaseStatus='TimeOut'">
						<td align="left"><b><font color="yellow" size="4"><xsl:value-of select="@CaseStatus"/></font></b></td>
						</xsl:if>
						<xsl:if test="@CaseStatus='Not Run'">
						<td align="left"><font color="gray" size="4"><xsl:value-of select="@CaseStatus"/></font></td>
						</xsl:if>
						<td><xsl:value-of select="@CaseDuration"/></td>
					</tr>
					</xsl:for-each>
				</table>
				
				</div>
				<div id="KB4Parent" class="parent">
						<H2>- Test Results Detail -</H2>
				</div>
				<div id="KB4Child" class="child">		
				<xsl:for-each select="/Report/ResultList/TestCase">
				<table id="LinksTable" cellspacing="2" bgcolor="LightBlue" width="1400">
				<tr>
					<td align="left" width="400"><font face="Arial" size="4"><b>Test Case Name</b></font></td>
					<td align="left" width="200"><font face="Arial" size="4"><b>Case Status</b></font></td>
					<td align="left" width="600"><font face="Arial" size="4"><b>Execution Duration</b></font></td>
				</tr>
					<tr>
						<td size="4"><xsl:value-of select="@CaseName"/></td>
						<xsl:if test="@CaseStatus='Pass'">
						<td size="4" align="left"><font color="green"><xsl:value-of select="@CaseStatus"/></font></td>
						</xsl:if>
						<xsl:if test="@CaseStatus='Fail'">
						<td size="4" align="left"><b><font color="red"><xsl:value-of select="@CaseStatus"/></font></b></td>
						</xsl:if>
						<xsl:if test="@CaseStatus='TimeOut'">
						<td size="4" align="left"><b><font color="yellow"><xsl:value-of select="@CaseStatus"/></font></b></td>
						</xsl:if>
						<xsl:if test="@CaseStatus='Not Run'">
						<td size="4" align="left"><font color="gray"><xsl:value-of select="@CaseStatus"/></font></td>
						</xsl:if>
						<td size="4"><xsl:value-of select="@CaseDuration"/></td>
					</tr>
					<table id="LinksTable" cellspacing="2" bgcolor="LightBlue" width="1400">
					<tr>
						<td align="left" width="60"><font face="Arial" size="3"><b>Step ID</b></font></td>
						<td align="left" width="220"><font face="Arial" size="3"><b>Test Step</b></font></td>
						<td align="left" width="500"><font face="Arial" size="3"><b>Step Parameter</b></font></td>
						<td align="center" width="120"><font face="Arial" size="3"><b>Target Server</b></font></td>
						<td align="center" width="100"><font face="Arial" size="3"><b>Step Status</b></font></td>
						<td align="center" width="400"><font face="Arial" size="3"><b>Error Detail</b></font></td>
					</tr>
					<xsl:for-each select="TestStep">
						<tr>
						<td align="center"><xsl:value-of select="@StepID"/></td>
						<td><xsl:value-of select="@StepName"/></td>
						<td><xsl:value-of select="@StepParam"/></td>
						<td align="center"><xsl:value-of select="@StepTarget"/></td>
						<xsl:if test="@StepStatus='Pass'">
						<td align="center"><font color="green"><xsl:value-of select="@StepStatus"/></font></td>
						</xsl:if>
						<xsl:if test="@StepStatus='Fail'">
						<td align="center"><b><font color="red"><xsl:value-of select="@StepStatus"/></font></b></td>
						</xsl:if>
						<xsl:if test="@StepStatus='Warning'">
						<td align="center"><b><font color="blue"><xsl:value-of select="@StepStatus"/></font></b></td>
						</xsl:if>
						<xsl:if test="@StepStatus='TimeOut'">
						<td align="center"><b><font color="yellow"><xsl:value-of select="@StepStatus"/></font></b></td>
						</xsl:if>
						<td align="left"><xsl:value-of select="@Detail"/></td>
						</tr>
					</xsl:for-each>
					</table>
					</table>
					<br></br>
					</xsl:for-each>
				</div>
			</body>
			</div>
		</html>	
	</xsl:template>
</xsl:stylesheet>
