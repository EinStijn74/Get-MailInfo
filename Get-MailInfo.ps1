function Get-MailInfo {

    ##############################################################################################
    # Name: Get-MailInfo                                                                         #
    # Version: 1.01 (May, 2017)                                                                  #
    # Created: EinStijn                                                                          #
    # What is it: Script combines output for Get-Mailbox, Get-MAilboxStatics and Get-CasMailbox  #
    ##############################################################################################


    #Function accepts pipeline input from Get-Aduser, Get-Mailbox, etc (property: SamSccountName)
    [CmdletBinding()]            
    Param             
    (                       
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyCollection()]
        [String[]]
        $SamAccountName
    )

    Process {

        $Output = @()

        ForEach ($User in $SamAccountName) {
            if (!($Mailbox = Get-Mailbox $User -ErrorAction SilentlyContinue)) { 
                Write-Warning "Cannot find Exchange information for $user"            
            }#if
            Else {
                $Mailbox = Get-Mailbox $User
                $MailboxStatistics = Get-MailboxStatistics $User
                $CasMailbox = Get-CASMailbox $user

                #More properties can be added below
                $Property = "" | Select-Object DisplayName, Name, SamAccountName, UserPrincipalName, OrganizationalUnit, Alias, PrimarySmtpAddress, ServerName, Database, 
                ItemCount, TotalItemSize, IssueWarningQuota, ProhibitSendQuota, ProhibitSendReceiveQuota, ArchiveWarningQuota, ArchiveQuota, RulesQuota, UseDatabaseQuotaDefaults,
                DatabaseProhibitSendReceiveQuota, DatabaseIssueWarningQuota, DatabaseProhibitSendQuota, DeletedItemCount, TotalDeletedItemSize, RetentionPolicy, OWAEnabled,
                ActiveSyncEnabled, OwaMailboxPolicy

                $Property.Displayname = $Mailbox.DisplayName
                $Property.Name = $Mailbox.Name
                $Property.SamAccountName = $Mailbox.SamAccountName
                $Property.UserPrincipalName = $Mailbox.UserPrincipalName
                $Property.OrganizationalUnit = $Mailbox.OrganizationalUnit
                $Property.Alias = $Mailbox.Alias
                $Property.PrimarySmtpAddress = $Mailbox.PrimarySmtpAddress
                $Property.ServerName = $Mailbox.ServerName
                $Property.Database = $Mailbox.Database
                $Property.ItemCount = $MailboxStatistics.ItemCount
                $Property.TotalItemSize = $MailboxStatistics.TotalItemSize
                $Property.IssueWarningQuota = $Mailbox.IssueWarningQuota
                $Property.ProhibitSendQuota = $Mailbox.ProhibitSendQuota
                $Property.ProhibitSendReceiveQuota = $Mailbox.ProhibitSendReceiveQuota
                $Property.ArchiveWarningQuota = $Mailbox.ArchiveWarningQuota
                $Property.ArchiveQuota = $Mailbox.ArchiveQuota
                $Property.RulesQuota = $Mailbox.RulesQuota
                $Property.UseDatabaseQuotaDefaults = $Mailbox.UseDatabaseQuotaDefaults
                $Property.DatabaseProhibitSendReceiveQuota = $MailboxStatistics.DatabaseProhibitSendReceiveQuota
                $Property.DatabaseIssueWarningQuota = $MailboxStatistics.DatabaseIssueWarningQuota
                $Property.DatabaseProhibitSendQuota = $MailboxStatistics.DatabaseProhibitSendQuota
                $Property.DeletedItemCount = $MailboxStatistics.DeletedItemCount
                $Property.TotalDeletedItemSize = $MailboxStatistics.TotalDeletedItemSize
                $Property.UseDatabaseQuotaDefaults = $Mailbox.UseDatabaseQuotaDefaults
                $Property.RetentionPolicy = $Mailbox.RetentionPolicy
                $Property.OWAEnabled = $CasMailbox.OWAEnabled
                $Property.ActiveSyncEnabled = $CasMailbox.ActiveSyncEnabled
                $Property.OwaMailboxPolicy = $CasMailbox.OwaMailboxPolicy
  
                $Output += $Property
            }#Else
        }#ForEach

        $Output

    }#Process

}#function


