Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$pathlabel = New-Object System.Windows.Forms.Label
$pathlabel.Location = New-Object System.Drawing.Point(10,20)
$pathlabel.Size = New-Object System.Drawing.Size(280,20)
$pathlabel.Text = 'Please enter the parent folder path'

$pathbox = New-Object System.Windows.Forms.TextBox
$pathbox.Location = New-Object System.Drawing.Point(10,40)
$pathbox.Size = New-Object System.Drawing.Size(260,20)

$ovlabel = New-Object System.Windows.Forms.Label
$ovlabel.Location = New-Object System.Drawing.Point(10,60)
$ovlabel.Size = New-Object System.Drawing.Size(280,20)
$ovlabel.Text = 'Please enter the old value to be replaced'

$ovbox = New-Object System.Windows.Forms.TextBox
$ovbox.Location = New-Object System.Drawing.Point(10,80)
$ovbox.Size = New-Object System.Drawing.Size(260,20)

$nvlabel = New-Object System.Windows.Forms.Label
$nvlabel.Location = New-Object System.Drawing.Point(10,100)
$nvlabel.Size = New-Object System.Drawing.Size(280,20)
$nvlabel.Text = 'Please enter the new value'

$nvbox = New-Object System.Windows.Forms.TextBox
$nvbox.Location = New-Object System.Drawing.Point(10,120)
$nvbox.Size = New-Object System.Drawing.Size(260,20)

$submit = New-Object System.Windows.Forms.Button
$submit.Location = New-Object System.Drawing.Point(10,200)
$submit.Size = New-Object System.Drawing.Size(260,20)
$submit.Text = "Submit"
$submit.Add_Click({
$targetDirectory = $pathbox.text
$oldString = $ovbox.text
$newString = $nvbox.text
write-host "File path: '$targetDirectory' \n Old value: '$oldString' \n New value: '$newString'"

Get-ChildItem -Path $targetDirectory -File -Recurse | ForEach-Object {
    # Read the content of each file
    $content = Get-Content $_.FullName

    # Check if the old string exists in the content
    if ($content -match $oldString) {
        # Replace the old string with the new string
        $modifiedContent = $content -replace $oldString, $newString

        # Write the modified content back to the file
        Set-Content $_.FullName $modifiedContent

        Write-Host "Replaced '$oldString' with '$newString' in: $($_.FullName)"
    }
}

write-host "Replace completed"
$form.Close()
})

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Self Service Password Portal'
$form.Size = New-Object System.Drawing.Size(500,500)
$form.StartPosition = 'CenterScreen'

$form.Controls.Add($pathlabel)
$form.Controls.Add($pathbox)
$form.Controls.Add($ovlabel)
$form.Controls.Add($ovbox)
$form.Controls.Add($nvlabel)
$form.Controls.Add($nvbox)
$form.Controls.Add($submit)
$form.Add_Shown({$form.Activate()})
$form.ShowDialog()
