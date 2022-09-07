TOOL-QueryWindowsEventLogs
Description: A Powershell script to query Windows Event Logs for events using variables such as amount of days, a given severity or both.  Then export finding to CSV files.
Example: This script will look through Application, Security and System logs for the past seven days for Severe errors.  Then write these to three seperate CSV files. 
Use case: To see if a server has had any errors logged recently at the OS level.
Compatibilty: This powershell script is compatible with Windows XP and Server 2003 forward. It uses Get-EventLog which only works against the 'classic' event logs.  
Get-WinEvent would be the ideal replacement but that only works on Windows Vista and later.
Variables of note:
$PRIORDATE: change this to how far back.
$OUTPUTDRIVE and $OUTPUTDIR: Check that a drive letter and the folders are in place before running the script.  By default, d:\tools\logs is used.
In the code, the -EntryType parameter can be changed to Error, Information, FailureAudit, SuccessAudit or Warning as needed.  See the Microsoft documentation on Get-EventLog for more details.
