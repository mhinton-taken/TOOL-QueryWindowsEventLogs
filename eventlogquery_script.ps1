#Author: Matthew Hinton

#Date: September 5 2022 

#Version : 6

#Purpose: Script to export Windows logs to CSV files

<#Compatibilty: This powershell script is compatible with Windows XP and Server 2003 forward. It uses Get-EventLog which only works against the 'classic' event logs.  
Get-WinEvent would be the ideal replacement but that only works on Windows Vista and later.
#>

#Variables

#Computer name

$COMPUTERNAME = $env:computername

#Current Date

$CURRENTDATE = get-date -format yyyy-MM-dd

<#
$PRIORDATE is the variable to hold a date value.  This is the date before problem started. Example: to look back seven days,
we put in (...-days 7).
#>

$PRIORDATE = (get-date) - (new-timespan -days 7)

#Directory for output file storage
#Specify drive letter
$OUTPUTDRIVE = "D:"
#Edit path as needed.  Avoid using spaces 
$OUTPUTDIR = "\Tools\logs\"
#Next variable will store the drive letter and path
$OUTPUTPATH = $OUTPUTDRIVE + $OUTPUTDIR   


#Filename for Windows Event Viewer Application log export

$FILENAME1 ="_" + $COMPUTERNAME + "_application_event_log.csv"

#Filename for Windows Event Viewer Application log "Event Type: errors" export

$FILENAME3 ="_" + $COMPUTERNAME + "_application_event_errors_log.csv"

 

#Filename for Windows Event Viewer System log export

$FILENAME2 = "_" + $COMPUTERNAME + "_system_event_log.csv"

#Filename for Windows Event Viewer System log "Event Type: errors" export

$FILENAME4 = "_" + $COMPUTERNAME + "_system_event_errors_log.csv"

 

#Filename for Windows Event Viewer Security log "FailureAudit" events export

$FILENAME5 = "_" + $COMPUTERNAME + "_security_event_errors_log.csv"

 

#Main

#Test to see if storage path exsists for output files

if (Test-Path -Path $OUTPUTPATH) {
    "Storage path for query files exists!"
} else {
    "Storage path for query files doesn't exist. Please check. Exiting..."
    Exit
}


#Application log export

#Retrieve ALL events in application log for time range then export to csv file 

#Get-EventLog -LogName Application -After $PRIORDATE | Export-Csv -Path ($DIR + $CURRENTDATE + $FILENAME1)

#Retrieve events in application log of Type Error for time range then export to csv file 

Get-EventLog -LogName Application -EntryType Error -After $PRIORDATE | Export-Csv -Path ($OUTPUTPATH + $CURRENTDATE + $FILENAME3)

"Application log query file created."
 

#Security log export

#Assumption: you are not locked out of these logs.  If so, comment this out.

#Next line exports failures to CSV

Get-EventLog -LogName Security -EntryType FailureAudit -After $PRIORDATE | Export-Csv -Path ($OUTPUTPATH + $CURRENTDATE + $FILENAME5)

"Security log query file created." 

#System log export

#Retrieve ALL events in system log for time range then export to csv file

#Get-EventLog -LogName System -After $PRIORDATE | Export-Csv -Path ($DIR + $CURRENTDATE + $FILENAME2)

#Retrieve events in system log of Type Error for time range then export to csv file

Get-EventLog -LogName System -EntryType Error -After $PRIORDATE | Export-Csv -Path ($OUTPUTPATH + $CURRENTDATE + $FILENAME4)

"System log query file created." 

"Check " + $OUTPUTPATH + " for query files in CSV format."  