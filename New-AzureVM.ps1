using namespace System.Management.Automation;
# When implement in console, then function will give you the ability to fill in the information and start the progress: New-AzureVM -vmName VMName -region eastus
function New-AzureVM {
        [cmdletbinding(confirmImpact = 'low')]
        param(
            # VM name
            [Parameter(Position = 0,
                Mandatory,
                ValueFromPipeline,
                HelpMessage = 'Enter VM name' )]
            [alias('VM', 'Name')]
            [ValidateNotNullOrEmpty()]
            [string]$vmName,

            # VM Region
            [Parameter(Position = 1,
                HelpMessage = 'Enter Region name')]
            [Alias('location')]
            [ValidateNotNullOrEmpty()]
            [string]$region,

            # VM Region
            [Parameter(Position = 1,
                    HelpMessage = 'Enter Ports')]
            [ValidateNotNullOrEmpty()]
            [string]$ports = ('22', '443')
        

    )
        # Begin will first check if you have the correct Module installed else give feedback to install it first.
        begin{

            $az = Get-InstalledModule Az
            if(-not ($az)) {
                Write-Warning 'Please install the Az module....'; Pause; Exit 
            }
        }
        
        # Process that in all the typed in information and asks for the credentials.
        process {
            $params = @{
                'Name' = $vmName
                'Location' = $region
                'OpenPorts' = $ports
                'Credentials' = $(Get-Credential)
        }
        # Try will process if everything is correct the installation of the VM.
        try{
            New-AzVM @params
        }
        # Catch will look of something goes wrong with try then prints out the errors.
        Catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
    # End will let you know the command completed.
    end{
        Write-Output "command complete: "
    }


}
# To use template, select all press F8 to implement in console, then start typing: New-AzureVM -vmName VMName -region eastus.
