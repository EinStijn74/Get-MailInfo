 function Get-MailInfo {

################################################################################################
# Name: Get-MailInfo                                                                           #
# Version: 1.0 (May, 2017)                                                                     #
# Created by: Stijn Langenberg                                                                 #
# What is it: Script combines output for Get-Mailbox, Get-MAilboxStatics and Get-CasMailbox    #
################################################################################################

　
#Function accepts pipeline input from Get-Aduser, Get-Mailbox, etc (property: SamSccountName)
[CmdletBinding()]            
 Param             
  (                       
  [Parameter(
   Mandatory=$true,
   ValueFromPipeline=$true,
   ValueFromPipelineByPropertyName=$true)]
  [AllowEmptyCollection()]
  [String[]]
  $SamAccountName
  )

Process {

$Output = @()

  ForEach ($User in $SamAccountName) {
  $Mailbox = Get-Mailbox $User
  $MailboxStatistics = Get-MailboxStatistics $User
  $CasMailbox = Get-CASMailbox $user

   #Below Properties are an example more can be added
   $Property = "" | Select-Object DisplayName,SamAccountName,ItemCount,DatabaseProhibitSendReceiveQuota,TotalItemSize,DeletedItemCount
     $Property.Displayname = $Mailbox.DisplayName
     $Property.SamAccountName = $Mailbox.SamAccountName
     $Property.ItemCount = $MailboxStatistics.ItemCount
     $Property.DatabaseProhibitSendReceiveQuota = $MailboxStatistics.DatabaseProhibitSendReceiveQuota
     $Property.TotalItemSize = $MailboxStatistics.TotalItemSize
     $Property.DeletedItemCount = $MailboxStatistics.DeletedItemCount
  
   $Output += $Property

  }#ForEach

$Output

}#Process

}#function 