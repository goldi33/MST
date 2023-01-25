Add-Type -AssemblyName PresentationFramework
######################################################################################################
# Function Abschnitt                                                                                 #
######################################################################################################


# Hier wird getestet ob die Applikaiton als Administrator gestartet wurde, falls nicht, kommt eine Fehlermeldung.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {

    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

$title = "Information"
$message = "Bitte starte das Programm als Administrator!"
$buttons = [System.Windows.Forms.MessageBoxButtons]::OK
$icon = [System.Windows.Forms.MessageBoxIcon]::Information

[System.Windows.Forms.MessageBox]::Show($message, $title, $buttons, $icon)
    exit
} else {

}


#*****************************************************************************************************#


# Funktionabschnitt Get-FixedDisk, hier werden die Discinfos (Speicherplatz sowie Laufwerke) in
# Variabeln geschrieben, die später abgerufen werden können.
Function Get-FixedDisk {
    [CmdletBinding()]
   
    param (

        [Parameter(Mandatory)]
        [string]$Computer
    )

    # Schreibt alle Laufwerke in $DiskInfo raus
    $DiskInfo = Get-WmiObject Win32_LogicalDisk -ComputerName $Computer -Filter 'DriveType=3'
    $DiskInfo
}

######################################################################################################
# Allgemeiner XAML Abschnitt                                                                         #
######################################################################################################


# In diesem Block ist das ganze XAML File gespeichert (MainWindow)
$xamlFile = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SMT  -  Samuel's Multi Tool " Height="500" Width="800" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" Icon="https://i.ibb.co/TrMY167/smt-icon.png">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition/>
        </Grid.ColumnDefinitions>
        <Button Content="Button" HorizontalAlignment="Left" Margin="411,188,0,0" VerticalAlignment="Top" Height="50" Width="185"/>
        <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="60,121,0,0" VerticalAlignment="Top"/>
        <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="60,141,0,0" VerticalAlignment="Top"/>
        <CheckBox Content="CheckBox" HorizontalAlignment="Left" Margin="60,161,0,0" VerticalAlignment="Top"/>
        <TabControl>
            <TabItem Header="Menu" Foreground="#FF3394FD">
                <Grid Background="#FFCDE5FF">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="18*"/>
                        <ColumnDefinition Width="15*"/>
                        <ColumnDefinition Width="91*"/>
                        <ColumnDefinition Width="8*"/>
                        <ColumnDefinition Width="662*"/>
                    </Grid.ColumnDefinitions>
                    <Button x:Name="btnWeitereInformationen" Grid.Column="1" Content="Weitere Informationen" HorizontalAlignment="Left" Height="28" Margin="8,399,0,0" VerticalAlignment="Top" Width="140" Cursor="Hand" Grid.ColumnSpan="4"/>
                    <Label Content="Multi Tool by Samuel" HorizontalAlignment="Left" Margin="0,10,0,0" VerticalAlignment="Top" Grid.ColumnSpan="3" Width="396" FontSize="36" Grid.Column="2"/>
                    <Label Grid.Column="2" Content="Dieses Tool wurde von Samuel für das Modul 122 gebaut. Es verfügt über einige " HorizontalAlignment="Left" Margin="0,111,0,0" VerticalAlignment="Top" Grid.ColumnSpan="3" Width="438" Height="26"/>
                    <Label Grid.Column="2" Content="Optionen - von auslesen von Computer Informationen, Netzwerk Einstellungen " HorizontalAlignment="Left" Margin="0,137,0,0" VerticalAlignment="Top" Width="438" Grid.ColumnSpan="3"/>
                    <Label Grid.Column="2" Content="und Lokale Benutzer Verwaltung." HorizontalAlignment="Left" Margin="0,163,0,0" VerticalAlignment="Top" Width="438" Grid.ColumnSpan="3"/>
                    <Label Grid.Column="4" Content="v1.9 22012023" HorizontalAlignment="Left" Margin="554,405,0,0" VerticalAlignment="Top" IsEnabled="False"/>
                    <Label Grid.Column="2" Content="Das Programm befindet sich in der Beta und wird zurzeit weiterentwickelt." HorizontalAlignment="Left" Margin="0,189,0,0" VerticalAlignment="Top" Width="438" Grid.ColumnSpan="3"/>
                    <Image x:Name="image" Grid.Column="4" HorizontalAlignment="Left" Height="300" Margin="337,0,0,0" VerticalAlignment="Top" Width="300" Source="https://i.ibb.co/18vZPsS/smt-image.png"/>
                    <Button Grid.Column="2" Content="📋" HorizontalAlignment="Left" Margin="7,257,0,0" VerticalAlignment="Top" Width="18" Height="20" Cursor="Hand"/>
                    <Label Grid.Column="2" Content="Drücke auf dieses &quot;Zwischenablage Symbol&quot; um direkt einen Text zu kopieren." HorizontalAlignment="Left" Margin="30,254,0,0" VerticalAlignment="Top" Width="438" Grid.ColumnSpan="3"/>
                    <Label Grid.Column="2" Content="Legende:" HorizontalAlignment="Left" Margin="0,228,0,0" VerticalAlignment="Top" Width="438" Grid.ColumnSpan="3" FontWeight="Bold"/>
                    <Button Grid.Column="2" Content="clear Content" HorizontalAlignment="Center" Margin="0,282,0,0" VerticalAlignment="Top" Width="78" Height="20" Cursor="Hand"/>
                    <Label Grid.Column="2" Content="Mit dem Button &quot;clear Content&quot;, kannst du den Text in der Konsole löschen." HorizontalAlignment="Left" Margin="89,279,0,0" VerticalAlignment="Top" Width="438" Grid.ColumnSpan="3"/>
                </Grid>
            </TabItem>
            <TabItem Header="Computer Informationen">
                <Grid>
                    <Grid.Background>
                        <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                            <GradientStop Color="White" Offset="0.003"/>
                            <GradientStop Color="#FFCDE5FF" Offset="1"/>
                        </LinearGradientBrush>
                    </Grid.Background>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="23*"/>
                        <ColumnDefinition Width="172*"/>
                        <ColumnDefinition Width="441*"/>
                        <ColumnDefinition Width="158*"/>
                    </Grid.ColumnDefinitions>
                    <Label Content="Computer Name:" HorizontalAlignment="Left" Margin="16,10,0,0" VerticalAlignment="Top" Grid.Column="1"/>
                    <TextBox x:Name="txtComputer" HorizontalAlignment="Left" Margin="138,13,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="151" Height="20" Grid.Column="1" Grid.ColumnSpan="2" IsEnabled="False"/>
                    <Button x:Name="btnQuery" Content="Disk Space" HorizontalAlignment="Left" Margin="336,91,0,0" VerticalAlignment="Top" Height="29" Width="107" Grid.Column="2" Cursor="Hand" Grid.ColumnSpan="2" ToolTip="Rufe den freien Speicherplatz auf, über dass dein Gerät noch verfügt."/>
                    <TextBox x:Name="txtResults" HorizontalAlignment="Left" Margin="16,91,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="476" Height="265" Grid.Column="1" Grid.ColumnSpan="2" IsEnabled="False" ScrollViewer.CanContentScroll="True"/>
                    <Button x:Name="btnHash" Content="Hash Code" HorizontalAlignment="Left" Margin="337,182,0,0" VerticalAlignment="Top" Height="30" Width="107" Grid.Column="2" Cursor="Hand" Grid.ColumnSpan="2" ToolTip="Rufe deinen Geräte Hash Code ab."/>
                    <Button x:Name="btnSaveHash" Content="Save Hash Code" HorizontalAlignment="Left" Margin="213,361,0,0" VerticalAlignment="Top" Height="29" Width="107" Grid.Column="2" Visibility="Hidden" Cursor="Hand"/>
                    <Label Content="Deine IP:" HorizontalAlignment="Left" Margin="60,34,0,0" VerticalAlignment="Top" Grid.Column="1"/>
                    <TextBox x:Name="txtIP" HorizontalAlignment="Left" Margin="138,37,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="151" Height="20" Grid.Column="1" Grid.ColumnSpan="2" IsEnabled="False"/>
                    <Label Content="Domain:" HorizontalAlignment="Left" Margin="63,57,0,0" VerticalAlignment="Top" Grid.Column="1"/>
                    <TextBox x:Name="txtDomain" HorizontalAlignment="Left" Margin="138,60,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="151" Height="20" Grid.Column="1" Grid.ColumnSpan="2" IsEnabled="False"/>
                    <Button x:Name="btnComputerInfo" Content="Computer Specs" HorizontalAlignment="Left" Margin="337,135,0,0" VerticalAlignment="Top" Height="30" Width="107" Grid.Column="2" Cursor="Hand" Grid.ColumnSpan="2" ToolTip="Rufe deine Computer Spezifikationen ab."/>
                    <Button x:Name="btnUsers" Content="Users" HorizontalAlignment="Left" Margin="337,228,0,0" VerticalAlignment="Top" Height="30" Width="107" Grid.Column="2" Cursor="Hand" Grid.ColumnSpan="2" ToolTip="Zeigt dir eine übersicht von allen Lokalen Benutzern."/>
                    <Button x:Name="btnCopyComputerName" Grid.Column="2" Content="📋" HorizontalAlignment="Left" Margin="122,13,0,0" VerticalAlignment="Top" Cursor="Hand" ToolTip="Drücke auf dieses &quot;Zwischenablage Symbol&quot; um direkt einen Text zu kopieren."/>
                    <Button x:Name="btnCopyIP" Grid.Column="2" Content="📋" HorizontalAlignment="Left" Margin="122,37,0,0" VerticalAlignment="Top" Cursor="Hand" ToolTip="Drücke auf dieses &quot;Zwischenablage Symbol&quot; um direkt einen Text zu kopieren."/>
                    <Button x:Name="btnCopyDomain" Grid.Column="2" Content="📋" HorizontalAlignment="Left" Margin="122,60,0,0" VerticalAlignment="Top" Cursor="Hand" ToolTip="Drücke auf dieses &quot;Zwischenablage Symbol&quot; um direkt einen Text zu kopieren."/>
                    <Button x:Name="btnClearContentComputer" Grid.Column="1" Content="clear Content" HorizontalAlignment="Left" Margin="17,361,0,0" VerticalAlignment="Top" Width="78" Height="19.96" Cursor="Hand" ToolTip="Mit dem Button &quot;clear Content&quot;, kannst du den Text in der Konsole löschen."/>
                    <Button x:Name="btnCopyContentComputer" Grid.Column="1" Content="📋" HorizontalAlignment="Left" Margin="100,361,0,0" VerticalAlignment="Top" Width="17.95" Height="19.96" Cursor="Hand" ToolTip="Drücke auf dieses &quot;Zwischenablage Symbol&quot; um direkt einen Text zu kopieren."/>
                    <Button x:Name="btnStartUpDateien" Content="Startup Dateien" HorizontalAlignment="Left" Margin="337,274,0,0" VerticalAlignment="Top" Height="30" Width="107" Grid.Column="2" Cursor="Hand" Grid.ColumnSpan="2" ToolTip="Zeigt dir alle Dateien an, die beim aufstarten des Computers im Hintergrund ausgeführt werden."/>
                </Grid>
            </TabItem>
            <TabItem Header="Netzwerk Einstellungen">
                <Grid>
                    <Grid.Background>
                        <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                            <GradientStop Color="White"/>
                            <GradientStop Color="#FFCDE5FF" Offset="1"/>
                        </LinearGradientBrush>
                    </Grid.Background>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="18*"/>
                        <ColumnDefinition Width="15*"/>
                        <ColumnDefinition Width="73*"/>
                        <ColumnDefinition Width="688*"/>
                    </Grid.ColumnDefinitions>
                    <Button x:Name="btnRenewIP" Grid.Column="3" Content="renew Ip" HorizontalAlignment="Left" Margin="426,91,0,0" VerticalAlignment="Top" Width="106" Height="29" Cursor="Hand" ToolTip="Deine IP wird refresht, du verlierst möglicherweise deine Internetverbindung."/>
                    <Button x:Name="btnWlanDeaktivieren" Grid.Column="3" Content="WLAN deaktivieren" HorizontalAlignment="Left" Margin="426,136,0,0" VerticalAlignment="Top" Width="106" Height="29" Cursor="Hand"/>
                    <Button x:Name="btnWlanAktivieren" Grid.Column="3" Content="WLAN aktivieren" HorizontalAlignment="Left" Margin="426,182,0,0" VerticalAlignment="Top" Width="107" Height="29" Cursor="Hand"/>
                    <TextBox x:Name="txtResultsNetwork" HorizontalAlignment="Left" Margin="6,91,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="476" Height="265" Grid.Column="2" Grid.ColumnSpan="2" IsEnabled="False"/>
                    <Label Grid.Column="2" Content="Konsole Output:" HorizontalAlignment="Left" Margin="6,65,0,0" VerticalAlignment="Top" Grid.ColumnSpan="2" Width="130"/>
                    <Button x:Name="btnClearContentNetwork" Grid.Column="2" Content="clear Content" HorizontalAlignment="Left" Margin="7,361,0,0" VerticalAlignment="Top" Grid.ColumnSpan="2" Width="78" Cursor="Hand" ToolTip="Mit dem Button &quot;clear Content&quot;, kannst du den Text in der Konsole löschen."/>
                    <Button x:Name="btnCopyContentNetwork" Grid.Column="3" Content="📋" HorizontalAlignment="Left" Margin="17,361,0,0" VerticalAlignment="Top" Width="17.95" Height="19.96" Cursor="Hand" ToolTip="Drücke auf dieses &quot;Zwischenablage Symbol&quot; um direkt einen Text zu kopieren."/>
                    <Button x:Name="btnNetzwerkAdapter" Grid.Column="3" Content="Netzwerk Adapter" HorizontalAlignment="Left" Margin="426,224,0,0" VerticalAlignment="Top" Width="107" Height="28" Cursor="Hand" ToolTip="Zeigt dir alle Netzwerkadapter an"/>
                </Grid>
            </TabItem>
            <TabItem Header="Lokale Benutzer">
                <Grid>
                    <Grid.Background>
                        <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                            <GradientStop Color="White"/>
                            <GradientStop Color="#FFCDE5FF" Offset="1"/>
                        </LinearGradientBrush>
                    </Grid.Background>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="18*"/>
                        <ColumnDefinition Width="15*"/>
                        <ColumnDefinition Width="193*"/>
                        <ColumnDefinition Width="568*"/>
                    </Grid.ColumnDefinitions>
                    <ComboBox x:Name="comboboxusers" Grid.Column="2" HorizontalAlignment="Left" Margin="163,91,0,0" VerticalAlignment="Top" Width="120" Grid.ColumnSpan="2"/>
                    <Label Grid.Column="2" Content="Ausgewählter Benutzer:" HorizontalAlignment="Left" Margin="23,150,0,0" VerticalAlignment="Top"/>
                    <TextBox x:Name="txtAusgewaelterBenutzer" Grid.Column="2" HorizontalAlignment="Left" Margin="163,154,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="120" IsEnabled="False" Grid.ColumnSpan="2"/>
                    <Label Grid.Column="2" Content="Beschreibung:" HorizontalAlignment="Left" Margin="73,173,0,0" VerticalAlignment="Top"/>
                    <TextBox x:Name="txtUserBeschreibung" Grid.Column="2" HorizontalAlignment="Left" Margin="163,177,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="218" IsEnabled="False" Height="80" Grid.ColumnSpan="2"/>
                    <Label Grid.Column="2" Content="Aktiviert:" HorizontalAlignment="Left" Margin="101,258,0,0" VerticalAlignment="Top"/>
                    <TextBox x:Name="txtUserStatus" Grid.Column="2" HorizontalAlignment="Left" Margin="163,262,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="120" IsEnabled="False" Grid.ColumnSpan="2"/>
                    <Button x:Name="btnUserDisable" Grid.Column="3" Content="Disable Account" HorizontalAlignment="Left" Margin="306,125,0,0" VerticalAlignment="Top" Width="106" Height="29" IsEnabled="False" Cursor="Hand" ToolTip="Benutzer deaktivieren"/>
                    <Button x:Name="btnUserEnable" Grid.Column="3" Content="Enable Account" HorizontalAlignment="Left" Margin="306,159,0,0" VerticalAlignment="Top" Width="106" Height="29" IsEnabled="False" Cursor="Hand" ToolTip="Benutzer aktivieren"/>
                    <Button x:Name="btnUserRemove" Grid.Column="3" Content="Benutzer löschen" HorizontalAlignment="Left" Margin="306,228,0,0" VerticalAlignment="Top" Width="106" Height="29" IsEnabled="False" Cursor="Hand"/>
                    <Label Grid.Column="2" Content="Benutzer auswählen:" HorizontalAlignment="Left" Margin="39,88,0,0" VerticalAlignment="Top"/>
                    <Button x:Name="btnUserCreate" Grid.Column="3" Content="Benutzer erstellen" HorizontalAlignment="Left" Margin="306,264,0,0" VerticalAlignment="Top" Width="106" Height="29" Cursor="Hand"/>
                    <Button x:Name="btnUserRenameBeta" Grid.Column="3" Content="Rename Account" HorizontalAlignment="Left" Margin="306,193,0,0" VerticalAlignment="Top" Width="106" Height="29" Cursor="Hand" IsEnabled="False" ToolTip="Benutzer unbenennen"/>
                    <Label Grid.Column="2" Content="Wähle zuerst einen Benutzer aus um fortfahren zu können!" HorizontalAlignment="Left" Margin="163,57,0,0" VerticalAlignment="Top" Grid.ColumnSpan="2"/>
                </Grid>
            </TabItem>
        </TabControl>

    </Grid>
</Window>

"@

# XAML in XML
[xml]$XAML = $xamlFile

# Erstell ein XmlNodeReader Objekt von dem XML Objekt
$reader = (New-Object System.Xml.XmlNodeReader $XAML)

# Konvertiert die XML Datei in ein WPF UI Objekt
$window = [Windows.Markup.XamlReader]::Load($reader)

Get-Variable var_*

######################################################################################################
# Abschnitt Menu                                                                                     #
######################################################################################################


# Prüft ob eine Variable im UI enthalten ist
$btnWeitereInformationen = $window.FindName("btnWeitereInformationen")

# Block05
# In diesem Block ist das ganze XAML File gespeichert für das "Weitere Informationen" UI. Dies wird von durch das klicken eines Buttons aufgerufen.
$btnWeitereInformationen.Add_Click( {

$xamlFile2 = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SMT  -  Weitere Informationen" Height="331" Width="379" ResizeMode="NoResize" Icon="https://i.ibb.co/TrMY167/smt-icon.png" WindowStartupLocation="CenterScreen">
    <Grid Margin="0,0,0,-6">
        <Grid.Background>
            <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                <GradientStop Color="White"/>
                <GradientStop Color="#FFCDE5FF" Offset="1"/>
            </LinearGradientBrush>
        </Grid.Background>
        <Label Content="Aktuelle Version:" HorizontalAlignment="Left" Margin="37,10,0,0" VerticalAlignment="Top"/>
        <Label Content="Programm Zweck:" HorizontalAlignment="Left" Margin="30,88,0,0" VerticalAlignment="Top"/>
        <Label Content="Start der Entwicklung:" HorizontalAlignment="Left" Margin="10,36,0,0" VerticalAlignment="Top"/>
        <Label Content="v1.9 22012023" HorizontalAlignment="Left" Margin="140,10,0,0" VerticalAlignment="Top"/>
        <Label Content="17.11.2022" HorizontalAlignment="Left" Margin="140,36,0,0" VerticalAlignment="Top"/>
        <Label Content="Entwickler:" HorizontalAlignment="Left" Margin="69,62,0,0" VerticalAlignment="Top"/>
        <Label Content="P. Samuel" HorizontalAlignment="Left" Margin="140,62,0,0" VerticalAlignment="Top"/>
        <Label Content="SMT ist die Praxisarbeit von Modul 122" HorizontalAlignment="Left" Margin="140,88,0,0" VerticalAlignment="Top" Height="26" Width="227"/>
        <Image HorizontalAlignment="Left" Height="168" Margin="135,88,0,0" VerticalAlignment="Top" Width="291" Source="https://i.ibb.co/18vZPsS/smt-image.png"/>
        <Button x:Name="btnWindow3schliessen" Content="Schliessen" HorizontalAlignment="Left" Margin="141,256,0,0" VerticalAlignment="Top" Width="78" Height="20" Cursor="Hand" IsCancel="True"/>

    </Grid>
</Window>
"@

# XAML in XML
[xml]$XAML2 = $xamlFile2

# Erstell ein XmlNodeReader Objekt von dem XML Objekt
$reader2 = (New-Object System.Xml.XmlNodeReader $XAML2)

# Konvertiert die XML Datei in ein WPF UI Objekt
$window2 = [Windows.Markup.XamlReader]::Load($reader2)

Get-Variable var_*

# Window "Weitere Informationen" wird angezeigt
$Null = $window2.ShowDialog()  

   })


######################################################################################################
# Abschnitt Computer Informations                                                                    #
######################################################################################################


# Prüft ob eine Variable im UI enthalten ist
$btnQuery = $window.FindName("btnQuery")
$txtResults = $window.FindName("txtResults")
$btnSaveHash = $window.FindName("btnSaveHash")
$txtComputer = $window.FindName("txtComputer")

# Ruft den Inhalt von der Funciton Get-FixedDisk und schreibt es in Text boxen
$btnQuery.Add_Click( {
 $btnSaveHash.Visibility = "Hidden"
   $txtResults.Text = ""
   # löscht den Inhalt von $var_txtResults
       if ($result = Get-FixedDisk -Computer $txtComputer.Text) {
       # Ruft den Inhalt von der Funciton Get-FixedDisk -> Block03
           foreach ($item in $result) {
               $txtResults.Text = $txtResults.Text + "Laufwerk: $($item.DeviceID)`n" 
               $txtResults.Text = $txtResults.Text + "Volume Name: $($item.VolumeName)`n"
               $txtResults.Text = $txtResults.Text + "Freier Speicherplatz: $($item.FreeSpace)`n"
               $txtResults.Text = $txtResults.Text + "Insgesamte grösse: $($item.Size)`n`n"
           }
       }    
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnHash = $window.FindName("btnHash")
$txtResults = $window.FindName("txtResults")
$btnSaveHash = $window.FindName("btnSaveHash")

$btnHash.Add_Click( {
   $txtResults.Text = ""

$session = New-CimSession
$serial = (Get-CimInstance -CimSession $session -Class Win32_BIOS).SerialNumber
# Serien Nummer wird ermittelt
$devDetail = (Get-CimInstance -CimSession $session -Namespace root/cimv2/mdm/dmmap -Class MDM_DevDetail_Ext01 -Filter "InstanceID='Ext' AND ParentID='./DevDetail'")
# Hash Code wird ermittelt
$hash = $devDetail.DeviceHardwareData
Remove-CimSession $session
$body = $serial +",,"+$hash
# Das ganze wird zusammengesetzt
               $txtResults.Text = $txtResults.Text + "Device Hash-Code: $body"

               
 $btnSaveHash.Visibility = "Visible"
 # Macht den Button btnSaveHash sichtbar
       }       
   )


#*****************************************************************************************************#


#Variable wird gesetzt
$selectedfolder = ""

$btnSaveHash.Add_Click( {
$session = New-CimSession
# Serien Nummer wird ermittelt
$serial = (Get-CimInstance -CimSession $session -Class Win32_BIOS).SerialNumber
# Hash Code wird ermittelt
$devDetail = (Get-CimInstance -CimSession $session -Namespace root/cimv2/mdm/dmmap -Class MDM_DevDetail_Ext01 -Filter "InstanceID='Ext' AND ParentID='./DevDetail'")
$hash = $devDetail.DeviceHardwareData
Remove-CimSession $session
$body = $serial +",,"+$hash
# Das ganze wird zusammengesetzt


$shell = New-Object -ComObject Shell.Application
$selectedfolder = $shell.BrowseForFolder( 0, 'Wähle einen Speicherort für die Datei aus!', 16, $shell.NameSpace( 17 ).Self.Path ).Self.Path
# Öffnet ein "Save File" UI

if ($selectedfolder -eq "0") 
    {
        
    }else
    {
        $path = $selectedfolder + "\HashCode.csv"
        # Exportiert den HashCode als CSV Datei an den gewünschten Pfad
        $body | out-file -filepath "$path" -append -width 200

        Add-Type -AssemblyName PresentationCore,PresentationFramework
        $msgBody = "Der HashCode wurde als CSV unter $path gespeichert."
        [System.Windows.MessageBox]::Show($msgBody)
    }
  })


#*****************************************************************************************************#

# Prüft ob eine Variable im UI enthalten ist
$btnComputerInfo = $window.FindName("btnComputerInfo")   
$txtResults = $window.FindName("txtResults")


$btnComputerInfo.Add_Click( {
$txtResults.Text = ""
# Versteckt den SaveHash button
$btnSaveHash.Visibility = "Hidden"
# Setzt verschiedene Computer Informationen in die Textbox (txtResults)
$txtResults.Text = $txtResults.Text + "Hostname: " + $((Get-CimInstance -ClassName Win32_ComputerSystem).Caption) + "`n"
$txtResults.Text = $txtResults.Text + "OS Info: " + $((Get-CimInstance -ClassName Win32_OperatingSystem).Caption) + "`n`n"
$txtResults.Text = $txtResults.Text + "CPU: " + $((Get-CimInstance -ClassName Win32_Processor).Caption) + "`n"
$txtResults.Text = $txtResults.Text + "GPU: " + $((Get-CimInstance -ClassName Win32_VideoController).Caption) + "`n"
$txtResults.Text = $txtResults.Text + "Verwendete Laufwerkbuchstaben: " + $((Get-CimInstance -ClassName Win32_LogicalDisk).Caption) + "`n"
$txtResults.Text = $txtResults.Text + "BIOS: " + $((Get-CimInstance -ClassName Win32_BIOS).Caption) + "`n"
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnUsers = $window.FindName("btnUsers")

$btnUsers.Add_Click( {
$txtResults.Text = ""
# Versteckt den SaveHash button
$btnSaveHash.Visibility = "Hidden"
   $btnUser = Get-LocalUser

           # Setzt den Wert bei $count zu 0
           $count = 0
   foreach ($item in $btnUser) {
               # Addiert für jeden User der gefunden wird 1 zu $count
               $count += 1
           }
           $txtResults.Text = $txtResults.Text + "Es wurden insgesamt $count lokale Benutzer gefunden!`n`n" 

   foreach ($item in $btnUser) {
               # Schreibt alle Users in die Textbox
               $txtResults.Text = $txtResults.Text + "User: $($item.Name)`n" 
           }
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnCopyContentComputer = $window.FindName("btnCopyContentComputer")

$btnCopyContentComputer.Add_Click( {
# Kopiert den Inhalt von $var_txtResults.Text
Set-Clipboard $txtResults.Text
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnClearContentComputer = $window.FindName("btnClearContentComputer")

$btnClearContentComputer.Add_Click( {
# Zeigt allfällige Errors nicht an
$ErrorActionpreference = "silentlycontinue"
# Versteckt den SaveHash button
$btnSaveHash.Visibility = "Hidden"
# cleared die Textbox
$txtResults.Text = ""
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnStartUpDateien = $window.FindName("btnStartUpDateien")   
$txtResults = $window.FindName("txtResults")

$btnStartUpDateien.Add_Click( {
# cleared die Textbox
$txtResults.Text = ""
# Versteckt den SaveHash button
$btnSaveHash.Visibility = "Hidden"
$txtResults.Text = $txtResults.Text + "" + $((Get-CimInstance -ClassName Win32_startupcommand).Caption)
   })


######################################################################################################
# Abschnitt Network Settings                                                                         #
######################################################################################################


# Prüft ob eine Variable im UI enthalten ist
$btnRenewIP = $window.FindName("btnRenewIP")
$txtResultsNetwork = $window.FindName("txtResultsNetwork")

$btnRenewIP.Add_Click( {
# cleared die Textbox
$txtResultsNetwork.Text = ""
# Setzt den Wert von $release & $renew, damit dies später in die Textbox geschrieben werden kann.
   $release = ipconfig /release
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$release`n`n"
   $renew = ipconfig /renew
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$renew"
   })


#*****************************************************************************************************#

# Prüft ob eine Variable im UI enthalten ist
$btnWlanDeaktivieren = $window.FindName("btnWlanDeaktivieren")

$btnWlanDeaktivieren.Add_Click( {
# cleared die Textbox
$txtResultsNetwork.Text = ""
# Cleared alle Errors
$error.clear()
# Zeigt allfällige Errors nicht an
$ErrorActionpreference = "silentlycontinue"
   $NetAdapterTable = Get-NetAdapter | format-table

# Deaktiviert verschiedene WiFi / Wlan Adapter, dessen Name von Computer zu Computer varieert
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterTable`n`n"
Disable-NetAdapter -Name "WLAN" -Confirm:$false

   $NetAdapterDisable = Disable-NetAdapter -Name "WLAN" -Confirm:$false
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterDisable"

Disable-NetAdapter -Name "Wi-Fi" -Confirm:$false
   $NetAdapterDisable2 = Disable-NetAdapter -Name "Wi-Fi" -Confirm:$false
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterDisable2"

Disable-NetAdapter -Name "WiFi" -Confirm:$false
   $NetAdapterDisable3 = Disable-NetAdapter -Name "WiFi" -Confirm:$false

$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterDisable3"
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnWlanAktivieren = $window.FindName("btnWlanAktivieren")

$btnWlanAktivieren.Add_Click( {
# cleared die Textbox
$txtResultsNetwork.Text = ""
# Cleared alle Errors
$error.clear()
# Zeigt allfällige Errors nicht an
$ErrorActionpreference = "silentlycontinue"
   $NetAdapterTable = Get-NetAdapter | format-table

# Aktiviert verschiedene WiFi / Wlan Adapter, dessen Name von Computer zu Computer varieert
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterTable`n`n"
Enable-NetAdapter -Name "WLAN" -Confirm:$false

   $NetAdapterEnable = Enable-NetAdapter -Name "WLAN" -Confirm:$false
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterEnable"

Enable-NetAdapter -Name "Wi-Fi" -Confirm:$false
   $NetAdapterEnable2 = Enable-NetAdapter -Name "Wi-Fi" -Confirm:$false
$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterEnable2"

Enable-NetAdapter -Name "WiFi" -Confirm:$false
   $NetAdapterEnable3 = Enable-NetAdapter -Name "WiFi" -Confirm:$false

$txtResultsNetwork.Text = $txtResultsNetwork.Text + "$NetAdapterEnable3"
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnClearContentNetwork = $window.FindName("btnClearContentNetwork")

$btnClearContentNetwork.Add_Click( {
# cleared die Textbox
$txtResultsNetwork.Text = ""
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnCopyContentNetwork = $window.FindName("btnCopyContentNetwork")

$btnCopyContentNetwork.Add_Click( {
# Kopiert den Inhalt von $var_txtResultsNetwork.Text
Set-Clipboard $txtResultsNetwork.Text
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnNetzwerkAdapter = $window.FindName("btnNetzwerkAdapter")   

$btnNetzwerkAdapter.Add_Click( {
# cleared die Textbox
$txtResultsNetwork.Text = ""
   # Setzt den Wert von $NetzwerkAdapter
   $NetzwerkAdapter = Get-CimInstance -ClassName Win32_NetworkAdapter

   # Damit nach jedem Netzwerkadapter ein Absatz erscheint, müssen die items in $NetzwerkAdapter jeweils getrennt werden
   foreach ($item2 in $NetzwerkAdapter) {
               $txtResultsNetwork.Text = $txtResultsNetwork.Text + "$($item2.Name)`n" 
           }
   })


######################################################################################################
# Abschnitt Users                                                                                    #
######################################################################################################


# Prüft ob eine Variable im UI enthalten ist
$comboboxusers = $window.FindName("comboboxusers")
$txtAusgewaelterBenutzer = $window.FindName("txtAusgewaelterBenutzer")
$txtUserBeschreibung = $window.FindName("txtUserBeschreibung")
$txtUserStatus = $window.FindName("txtUserStatus")
$btnUserDisable = $window.FindName("btnUserDisable")
$btnUserEnable = $window.FindName("btnUserEnable")
$btnUserRenameBeta = $window.FindName("btnUserRenameBeta")
$btnUserRemove = $window.FindName("btnUserRemove")
$btnRenameAccount = $window.FindName("btnRenameAccount")

# Setzt den Wert von $comboxvar, mit dem im ganzen Abschnitt Users gearbeitet wird
$comboboxvar = Get-LocalUser
      # Ein Foreach statement, damit jeder User separat in der Combobox angezeigt wird
      foreach($usercomboboxvar in $comboboxvar)
        {
$comboboxusers.Items.add($usercomboboxvar)
        }

# Sobald ein User in der Combobox ausgewählt wird, oder sich ändert
$comboboxusers.Add_SelectionChanged( {

# Cleared alle Errors
$error.clear()

# Der Name des ausgewählten Benutzer wird in die Textbox geschrieben
$txtAusgewaelterBenutzer.Text = $comboboxusers.SelectedItem.ToString()
# Hier wird die Beschreibung des ausgewählten Benutzers in die Textbox geschrieben
$txtUserBeschreibung.Text = Get-LocalUser $comboboxusers.SelectedItem.ToString() | Select-Object -ExpandProperty Description
# Hier wird der Status des ausgewählten Benutzers in die Textbox geschrieben
$txtUserStatus.Text = Get-LocalUser $comboboxusers.SelectedItem.ToString() | Select-Object -ExpandProperty Enabled
# Wenn ein Error auftaucht bzw. kein User ausgewählt wird
if ($error) {
# Fürs debugging
    write-host "Kein Benutzer ausgewählt"
    $error.clear()
} else 
{
# Aktiviert alle Buttons, damit man diese aswählen kann
 $btnUserDisable.IsEnabled = "True"
 $btnUserEnable.IsEnabled = "True"
 $btnUserRenameBeta.IsEnabled = "True"
 $btnUserRemove.IsEnabled = "True"
 $btnRenameAccount.IsEnabled = "True"
 }


#*****************************************************************************************************#


$btnUserEnable.Add_Click( {
# Aktiviert den Ausgewählte Benutzer
Enable-LocalUser $comboboxusers.SelectedItem.ToString()
    # Erstellt ein kleines UI mit einer Bestätigung
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $msgBody = "Der Benutzer " + $comboboxusers.SelectedItem.ToString() + " wurde aktiviert!"
    [System.Windows.MessageBox]::Show($msgBody)
    # Refresht die Status Textbox
    $txtUserStatus.Text = Get-LocalUser $comboboxusers.SelectedItem.ToString() | Select-Object -ExpandProperty Enabled
   })


#*****************************************************************************************************#


$btnUserDisable.Add_Click( {
# Deaktiviert den Ausgewählte Benutzer
Disable-LocalUser $comboboxusers.SelectedItem.ToString()
    # Erstellt ein kleines UI mit einer Bestätigung
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $msgBody = "Der Benutzer " + $comboboxusers.SelectedItem.ToString() + " deaktiviert!"
    [System.Windows.MessageBox]::Show($msgBody)
    # Refresht die Status Textbox
    $txtUserStatus.Text = Get-LocalUser $comboboxusers.SelectedItem.ToString() | Select-Object -ExpandProperty Enabled
   })
})


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnUserRenameBeta = $window.FindName("btnUserRenameBeta")

$btnUserRenameBeta.Add_Click( {
# Setzt den ausgewählten Benutzer in die Variable $OldAccountName. Diese Variable wird später benötigt
$OldAccountName = $comboboxusers.SelectedItem.ToString()
# In diesem Block ist das ganze XAML File gespeichert für das "Benutzer unbennen" UI. Dies wird von durch das klicken eines Buttons aufgerufen.
$xamlFile3 = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SMT  -  Lokalen Benutzer unbenennen" Height="165" Width="379" ResizeMode="NoResize" Icon="https://i.ibb.co/TrMY167/smt-icon.png" WindowStartupLocation="CenterScreen">
    <Grid>
        <Grid.Background>
            <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                <GradientStop Color="White"/>
                <GradientStop Color="#FFCDE5FF" Offset="1"/>
            </LinearGradientBrush>
        </Grid.Background>
        <Label Content="Gib hier den neuen Benutzernamen ein:" HorizontalAlignment="Left" Margin="38,41,0,0" VerticalAlignment="Top"/>
        <Button x:Name="btnWindow4schliessen" Content="Schliessen" HorizontalAlignment="Left" Margin="176,98,0,0" VerticalAlignment="Top" Width="78" Height="20" Cursor="Hand" IsCancel="True"/>
        <Button x:Name="btnWindow4Bestätigen" Content="Bestätigen" HorizontalAlignment="Left" Margin="259,98,0,0" VerticalAlignment="Top" Width="78" Height="20" Cursor="Hand"/>
        <Label Content="Ausgewählter Benutzer:" HorizontalAlignment="Left" Margin="37,10,0,0" VerticalAlignment="Top"/>
        <TextBox x:Name="txtWindow4Benutzername" HorizontalAlignment="Left" Margin="177,14,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="160" IsEnabled="False"/>
        <TextBox x:Name="txtWindow4NewBenutzername" HorizontalAlignment="Left" Margin="38,67,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="299"/>

    </Grid>
</Window>
"@

# XAML in XML
[xml]$XAML3 = $xamlFile3

# Erstell ein XmlNodeReader Objekt von dem XML Objekt
$reader3 = (New-Object System.Xml.XmlNodeReader $XAML3)

# Konvertiert die XML Datei in ein WPF UI Objekt
$window3 = [Windows.Markup.XamlReader]::Load($reader3)

Get-Variable var_*


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$txtWindow4Benutzername = $window3.FindName("txtWindow4Benutzername")
$btnWindow4Bestätigen = $window3.FindName("btnWindow4Bestätigen")
$txtWindow4NewBenutzername = $window3.FindName("txtWindow4NewBenutzername")

# $OldAccountName wird in die Textbox geschrieben
$txtWindow4Benutzername.Text = $OldAccountName

$btnWindow4Bestätigen.Add_Click( {
# Wenn die Textbox des neuen Benutzernamen leer ist, muss der Nutzer einen Benutzernamen eingeben
 if ($txtWindow4NewBenutzername.Text -eq "") {
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $msgBody = "Du musst zuerst einen neuen Benutzername angeben!"
    [System.Windows.MessageBox]::Show($msgBody)
 }
 else{

$OldAccountName = $comboboxusers.SelectedItem.ToString()
# Falls nicht, wird der neue Benutzername in die Variable $NewAccountName gesetzt
$NewAccountName = $txtWindow4NewBenutzername.Text
 # Fehlermeldung wenn $NewAccountName gleich ist wie $OldAccountName
 if ($NewAccountName -eq $OldAccountName) {
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $msgBody = "Du kannst einen Nutzer nicht mit dem gleichen Nutzernamen unbenennen!"
    [System.Windows.MessageBox]::Show($msgBody)
    #$var_txtRenameAccount.Text = ""
 }
 else{
 # Falls nicht, müsste alles stimmen. Der Benutzer wird in $NewAccountName unbenannt
Rename-LocalUser $comboboxusers.SelectedItem.ToString() $NewAccountName

# Die Combobox wird aktualisiert
$comboboxusers.Items.Clear();
$comboboxvar = Get-LocalUser
      foreach($usercomboboxvar in $comboboxvar)
        {
$comboboxusers.Items.add($usercomboboxvar)
$comboboxusers.SelectedItem = $usercomboboxvar
        }
        $txtRenameAccount.Text = ""
        $txtAusgewaelterBenutzer.Text = ""
        $txtUserBeschreibung.Text = ""
        $txtUserStatus.Text = ""
        Remove-Variable $OldAccountName
        Remove-Variable $NewAccountName
        sleep 1
        # Nach der aktualisierung, wird das "Benutzer unbenennen" UI geschlossen
        $Null = $window3.Close()  
        }

      }})

$Null = $window3.ShowDialog()  
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnUserCreate = $window.FindName("btnUserCreate")

$btnUserCreate.Add_Click( {
# In diesem Block ist das ganze XAML File gespeichert für das "Benutzer erstellen" UI. Dies wird von durch das klicken eines Buttons aufgerufen.
$xamlFile4 = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SMT  -  Create User" Height="331" Width="468" ResizeMode="NoResize" WindowStartupLocation="CenterScreen" Icon="https://i.ibb.co/TrMY167/smt-icon.png">
    <Grid Margin="0,0,0,-6">
        <Grid.Background>
            <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                <GradientStop Color="White"/>
                <GradientStop Color="#FFCDE5FF" Offset="1"/>
            </LinearGradientBrush>
        </Grid.Background>
        <TextBox x:Name="txtWindow2Benutzername" HorizontalAlignment="Left" Margin="154,30,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="218"/>
        <Label Content="Benutzername:" HorizontalAlignment="Left" Margin="60,26,0,0" VerticalAlignment="Top"/>
        <Label Content="Beschreibung:" HorizontalAlignment="Left" Margin="65,174,0,0" VerticalAlignment="Top"/>
        <TextBox x:Name="txtWindow2UserBeschreibung" HorizontalAlignment="Left" Margin="155,174,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="218" Height="80"/>
        <Button x:Name="btnWindow2BenutzerAnlegen" Content="Benutzer anlegen" HorizontalAlignment="Left" Margin="215,259,0,0" VerticalAlignment="Top" Cursor="Hand"/>
        <Button x:Name="btnWindow2Abrechen" Content="Abrechen" HorizontalAlignment="Left" Margin="155,259,0,0" VerticalAlignment="Top" IsCancel="True" Cursor="Hand"/>
        <Button x:Name="btnWindow2PWdeaktiviert" Content="" HorizontalAlignment="Left" Margin="155,67,0,0" VerticalAlignment="Top" Width="15" Height="15" Background="White" Cursor="Hand"/>
        <Button x:Name="btnWindow2PWaktiviert" Content="✓" HorizontalAlignment="Left" Margin="155,67,0,0" VerticalAlignment="Top" Width="15" Height="15" Background="White" FontWeight="Bold" FontSize="10" Cursor="Hand"/>
        <Button x:Name="btnWindow2BenutzerDeaktiviert" Content="" HorizontalAlignment="Left" Margin="155,150,0,0" VerticalAlignment="Top" Width="15" Height="15" Background="White" Cursor="Hand"/>
        <Button x:Name="btnWindow2BenutzerAktiviert" Content="✓" HorizontalAlignment="Left" Margin="155,150,0,0" VerticalAlignment="Top" Width="15" Height="15" Background="White" FontWeight="Bold" FontSize="10" Cursor="Hand"/>
        <Label x:Name="txtWindow2Passwort11" Content="Passwort eingeben:" HorizontalAlignment="Left" Margin="38,83,0,0" VerticalAlignment="Top"/>
        <Label x:Name="txtWindow2Passwort22" Content="Passwort erneut eingeben:" HorizontalAlignment="Left" Margin="-1,106,0,0" VerticalAlignment="Top"/>
        <Label x:Name="txtWindow2PWaktiviert" Content="Passwort ist aktiviert" HorizontalAlignment="Left" Margin="170,61,0,0" VerticalAlignment="Top"/>
        <Label x:Name="txtWindow2BenutzerAktiviert" Content="Benutzer ist aktiviert" HorizontalAlignment="Left" Margin="170,145,0,0" VerticalAlignment="Top"/>
        <TextBox x:Name="txtWindow2PasswortStatus" HorizontalAlignment="Left" Margin="393,65,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="29" IsEnabled="True" Text="1" Visibility="Hidden"/>
        <TextBox x:Name="txtWindow2BenutzerStatus" HorizontalAlignment="Left" Margin="393,0,0,0" TextWrapping="Wrap" VerticalAlignment="Center" Width="29" IsEnabled="True" Text="1" Visibility="Hidden"/>
        <PasswordBox x:Name="txtWindow2Passwort1" HorizontalAlignment="Left" Margin="155,87,0,0" VerticalAlignment="Top" Width="218" Password=""/>
        <PasswordBox x:Name="txtWindow2Passwort2" HorizontalAlignment="Left" Margin="155,110,0,0" VerticalAlignment="Top" Width="218" Password=""/>
    </Grid>
</Window>


"@

# XAML in XML
[xml]$XAML4 = $xamlFile4

# Erstell ein XmlNodeReader Objekt von dem XML Objekt
$reader4 = (New-Object System.Xml.XmlNodeReader $XAML4)

# Konvertiert die XML Datei in ein WPF UI Objekt
$window4 = [Windows.Markup.XamlReader]::Load($reader4)

Get-Variable var_*

#*****************************************************************************************************#

# Prüft ob eine Variable im UI enthalten ist
$txtWindow2Passwort1 = $window4.FindName("txtWindow2Passwort1")
$txtWindow2Passwort2 = $window4.FindName("txtWindow2Passwort2")
$btnWindow2PWaktiviert = $window4.FindName("btnWindow2PWaktiviert")
$txtWindow2PWaktiviert = $window4.FindName("txtWindow2PWaktiviert")
$txtWindow2PasswortStatus = $window4.FindName("txtWindow2PasswortStatus")
$passwortStatuswindow2 = $window4.FindName("passwortStatuswindow2")
$txtWindow2Passwort11 = $window4.FindName("txtWindow2Passwort11")
$txtWindow2Passwort22 = $window4.FindName("txtWindow2Passwort22")
$btnWindow2PWdeaktiviert = $window4.FindName("btnWindow2PWdeaktiviert")

# Prüft ob eine Variable im UI enthalten ist
$btnWindow2BenutzerAktiviert = $window4.FindName("btnWindow2BenutzerAktiviert")
$txtWindow2BenutzerAktiviert = $window4.FindName("txtWindow2BenutzerAktiviert")
$txtWindow2BenutzerStatus = $window4.FindName("txtWindow2BenutzerStatus")
$btnWindow2BenutzerAktiviert = $window4.FindName("btnWindow2BenutzerAktiviert")
$btnWindow2BenutzerDeaktiviert = $window4.FindName("btnWindow2BenutzerDeaktiviert")
$txtWindow2Passwort22 = $window4.FindName("txtWindow2Passwort22")

 # Prüft ob eine Variable im UI enthalten ist
 $btnWindow2BenutzerAnlegen = $window4.FindName("btnWindow2BenutzerAnlegen")
 $txtWindow2Benutzername = $window4.FindName("txtWindow2Benutzername")
 $txtWindow2UserBeschreibung = $window4.FindName("txtWindow2UserBeschreibung")


# Damit man bei der Eingabe des Passwort, dass Passwort nicht sieht, wird es mit "*" zensiert
$txtWindow2Passwort1.PasswordChar = "*"
$txtWindow2Passwort2.PasswordChar = "*"

 $btnWindow2PWaktiviert.Add_Click( {
    # Versteckt den Button
    $btnWindow2PWaktiviert.Visibility = "Hidden"
    # Ändert den Kontext der TextBox
    $txtWindow2PWaktiviert.Content = "Passwort ist deaktiviert"
    # Setzt den Wert der TextBox zu 0, ist später bei $btnWindow2BenutzerAnlegen relevant
    $txtWindow2PasswortStatus.Text = "0"
    # Das eingegebene Passwort wird in $passwortStatuswindow2 geschrieben
    $passwortStatuswindow2 = $txtWindow2PasswortStatus.Text
    # Versteckt den Button
    $txtWindow2Passwort1.Visibility = "Hidden"
    $txtWindow2Passwort2.Visibility = "Hidden"
    $txtWindow2Passwort11.Visibility = "Hidden"
    $txtWindow2Passwort22.Visibility = "Hidden"
   })


#*****************************************************************************************************#


 $btnWindow2PWdeaktiviert.Add_Click( {
    # Zeigt den Button wieder an
    $btnWindow2PWaktiviert.Visibility = "Visible"
    # Ändert den Kontext der TextBox
    $txtWindow2PWaktiviert.Content = "Passwort ist aktiviert"
    # Setzt den Wert der TextBox zu 1, ist später bei $btnWindow2BenutzerAnlegen relevant
    $txtWindow2PasswortStatus.Text = "1"
    # Das eingegebene Passwort wird in $passwortStatuswindow2 geschrieben
    $passwortStatuswindow2 = $var_txtWindow2PasswortStatus.Text
    # Zeigt den Button wieder an
    $txtWindow2Passwort1.Visibility = "Visible"
    $txtWindow2Passwort2.Visibility = "Visible"
    $txtWindow2Passwort11.Visibility = "Visible"
    $txtWindow2Passwort22.Visibility = "Visible"
   })


#*****************************************************************************************************#


 $btnWindow2BenutzerAktiviert.Add_Click( {
    # Versteckt den Button
    $btnWindow2BenutzerAktiviert.Visibility = "Hidden"
    # Ändert den Kontext der TextBox
    $txtWindow2BenutzerAktiviert.Content = "Benutzer ist deaktiviert"
    # Setzt den Wert der TextBox zu 0, ist später bei $btnWindow2BenutzerAnlegen relevant
    $txtWindow2BenutzerStatus.Text = "0"
   })

 $btnWindow2BenutzerDeaktiviert.Add_Click( {
    # Zeigt den Button wieder an
    $btnWindow2BenutzerAktiviert.Visibility = "Visible"
    # Ändert den Kontext der TextBox
    $txtWindow2BenutzerAktiviert.Content = "Benutzer ist aktiviert"
    # Setzt den Wert der TextBox zu 1, ist später bei $btnWindow2BenutzerAnlegen relevant
    $txtWindow2BenutzerStatus.Text = "1"
   })


#*****************************************************************************************************#


 $btnWindow2BenutzerAnlegen.Add_Click( {
    # Prüft ob die Textbox leer ist
    if ($txtWindow2Benutzername.Text -eq "") 
    {
        # Falls ja, Fehlermeldung
        Add-Type -AssemblyName PresentationCore,PresentationFramework
        $msgBody = "Du musst zuerst einen neuen Benutzername angeben!"
        [System.Windows.MessageBox]::Show($msgBody)
    }else
        {
        # Prüft ob der angegebene Benutzername schon verwendet wird
        if ($txtWindow2Benutzername.Text -eq $usercomboboxvar) {
            # Falls ja, Fehlermeldung
            Add-Type -AssemblyName PresentationCore,PresentationFramework
            $msgBody = "Benutze bitte einen anderen Benutzernamen!"
            [System.Windows.MessageBox]::Show($msgBody)
        }else{
            # Setzt die Textboxen in Variabeln
            $2Benutzername = $txtWindow2Benutzername.Text
            $2Beschreibung = $txtWindow2UserBeschreibung.Text
                #Prüft ob der vorherige Wert bei der PasswortTextbox 0 ist
                if ($txtWindow2PasswortStatus.Text -eq "0") 
                {
                    #Falls ja, wird geprüft, ob bei der Benutzerstatus Textbox 0 ist
                    if ($txtWindow2BenutzerStatus.Text -eq "0") 
                    {
                        # Falls ja, wird ein Benutzer ohne Passwort erstellt, der nicht aktiviert ist
                        New-LocalUser $2Benutzername -Description $2Beschreibung -NoPassword
                        Disable-LocalUser $2Benutzername
                        # Eine Bestätigungs Meldung erscheint
                        Add-Type -AssemblyName PresentationCore,PresentationFramework
                        $msgBody = "Benutzer $2Benutzername wurde erstellt!"
                        [System.Windows.MessageBox]::Show($msgBody)
                        # Das User erstellen UI wird geschlossen
                        $Null = $window4.Close()
                        # Die Combobox wird aktualisiert
                        $comboboxusers.Items.Clear();
                        $comboboxvar = Get-LocalUser
                        foreach($usercomboboxvar in $comboboxvar)
                                    {
                                        $comboboxusers.Items.add($usercomboboxvar)
                                        $comboboxusers.SelectedItem = $usercomboboxvar
                                    }
                    }else
                        {
                            # Falls der Wert nicht = 0 bei der BenutzerStatus TextBox ist, wird ein Benutzer ohne Passwort erstellt, der aktiviert ist
                            New-LocalUser $2Benutzername -Description $2Beschreibung -NoPassword
                            # Eine Bestätigungs Meldung erscheint
                            Add-Type -AssemblyName PresentationCore,PresentationFramework
                            $msgBody = "Benutzer $2Benutzername wurde erstellt!"
                            [System.Windows.MessageBox]::Show($msgBody)
                            # Das User erstellen UI wird geschlossen
                            $Null = $window4.Close()
                            # Die Combobox wird aktualisiert
                            $comboboxusers.Items.Clear();
                            $comboboxvar = Get-LocalUser
                            foreach($usercomboboxvar in $comboboxvar)
                                    {
                                        $comboboxusers.Items.add($usercomboboxvar)
                                        $comboboxusers.SelectedItem = $usercomboboxvar
                                    }
                        }
                    
                }else
                {
                    # Falls der Wert nicht = 0 bei der PasswortTextbox ist, wird geprüft, ob das Passwort Feld leergelassen wurde
                    if ($txtWindow2Passwort1.Text -eq "") 
                    {
                        # Falls ja, erscheint eine Fehlermeldung
                        Add-Type -AssemblyName PresentationCore,PresentationFramework
                        $msgBody = "Du musst ein Passwort für den Benutzer eingeben!"
                        [System.Windows.MessageBox]::Show($msgBody)
                    }else
                        {
                            # Falls nicht, wird das nochmals bei der zweiteingabe geprüft
                            if ($txtWindow2Passwort2.Password -eq "") 
                        {
                            # Falls das Feld leer ist, erscheint eine Fehlermeldung
                            Add-Type -AssemblyName PresentationCore,PresentationFramework
                            $msgBody = "Du musst das Passwort für den Benutzer erneut eingeben!"
                            [System.Windows.MessageBox]::Show($msgBody)
                        }else
                            {
                                # Falls beide Felder ausgefüllt worden sind, muss noch überprüft werden, ob beide übereinstimmen
                                if ($txtWindow2Passwort1.Password -ceq $txtWindow2Passwort2.Password) 
                            {
                            # Das Passwort wird in die Variable $2password geschrieben
                            $2password = $txtWindow2Passwort2.Password
                            # $2password wird in eine SecureString konvertiert, damit der Benutzer damit erstellt werden kann
                            $secureString = ConvertTo-SecureString -String $2password -AsPlainText -Force
                            # Aus sicherheitsgründen, wird die Variable $2password gelöscht
                            Remove-Variable 2password
                                    # Falls der Wer der BenutzerStatus TextBox 0 ist
                                    if ($txtWindow2BenutzerStatus.Text -eq "0") 
                                    {
                                    # Es wird ein Benutzer mit Passwort erstellt, der deaktiviert ist
                                    New-LocalUser $2Benutzername -Password $secureString -Description $2Beschreibung
                                    Disable-LocalUser $2Benutzername
                                    # Eine Bestätigungs Meldung erscheint
                                    Add-Type -AssemblyName PresentationCore,PresentationFramework
                                    $msgBody = "Benutzer $2Benutzername wurde erstellt!"
                                    [System.Windows.MessageBox]::Show($msgBody)
                                    # Das User erstellen UI wird geschlossen
                                    $Null = $window4.Close()
                                    # Die Combobox wird aktualisiert
                                    $comboboxusers.Items.Clear();
                                    $comboboxvar = Get-LocalUser
                                    foreach($usercomboboxvar in $comboboxvar)
                                        {
                                            $comboboxusers.Items.add($usercomboboxvar)
                                            $comboboxusers.SelectedItem = $usercomboboxvar
                                        }
                                }else
                                    {
                                        # Falls der Wert nicht = 0 ist, wird ein Benutzer mit Passwort erstellt, der aktiviert ist
                                        New-LocalUser $2Benutzername -Password $secureString -Description $2Beschreibung
                                        # Eine Bestätigungs Meldung erscheint
                                        Add-Type -AssemblyName PresentationCore,PresentationFramework
                                        $msgBody = "Benutzer $2Benutzername wurde erstellt!"
                                        [System.Windows.MessageBox]::Show($msgBody)
                                        # Das User erstellen UI wird geschlossen
                                        $Null = $window4.Close()
                                        # Die Combobox wird aktualisiert
                                        $comboboxusers.Items.Clear();
                                        $comboboxvar = Get-LocalUser
                                        foreach($usercomboboxvar in $comboboxvar)
                                            {
                                                $comboboxusers.Items.add($usercomboboxvar)
                                                $comboboxusers.SelectedItem = $usercomboboxvar
                                            }
                                    }
                            }else
                                {
                                    # Falls die Passwörter nicht übereinstimmen, erschein eine Fehlermeldung
                                    Add-Type -AssemblyName PresentationCore,PresentationFramework
                                    $msgBody = "Die Passwörter stimmen nicht überein!"
                                    [System.Windows.MessageBox]::Show($msgBody)
                                }
                            }
                        }
                }
        }
 }})

$Null = $window4.ShowDialog()  

})


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$btnUserRemove = $window.FindName("btnUserRemove")

$btnUserRemove.Add_Click( {

$OldAccountName = $comboboxusers.SelectedItem.ToString()

# In diesem Block ist das ganze XAML File gespeichert für das "Benutzer löschen" UI. Dies wird von durch das klicken eines Buttons aufgerufen.
$xamlFile6 = @"
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="SMT  -  Lokalen Benutzer löschen" Height="165" Width="379" ResizeMode="NoResize" Icon="https://i.ibb.co/TrMY167/smt-icon.png" WindowStartupLocation="CenterScreen">
    <Grid>
        <Grid.Background>
            <LinearGradientBrush EndPoint="0.5,1" StartPoint="0.5,0">
                <GradientStop Color="White"/>
                <GradientStop Color="#FFCDE5FF" Offset="1"/>
            </LinearGradientBrush>
        </Grid.Background>
        <Label Content="Wenn du dich entscheidest einen Benutzer zu löschen," HorizontalAlignment="Left" Margin="38,41,0,0" VerticalAlignment="Top"/>
        <Button x:Name="btnWindow5Abrechen" Content="Abrechen" HorizontalAlignment="Left" Margin="176,98,0,0" VerticalAlignment="Top" Width="78" Height="20" Cursor="Hand" IsCancel="True"/>
        <Button x:Name="btnWindow5Bestätigen" Content="Bestätigen" HorizontalAlignment="Left" Margin="259,98,0,0" VerticalAlignment="Top" Width="78" Height="20" Cursor="Hand" Foreground="#FFFF1313"/>
        <Label Content="Ausgewählter Benutzer:" HorizontalAlignment="Left" Margin="37,10,0,0" VerticalAlignment="Top"/>
        <TextBox x:Name="txtWindow5Benutzername" HorizontalAlignment="Left" Margin="177,14,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="160" IsEnabled="False"/>
        <Label Content="kann dies nicht mehr rückgängig gemacht werden." HorizontalAlignment="Left" Margin="38,67,0,0" VerticalAlignment="Top"/>

    </Grid>
</Window>
"@

# XAML in XML
[xml]$XAML6 = $xamlFile6

# Erstellt ein XmlNodeReader Objekt von dem XML Objekt
$reader6 = (New-Object System.Xml.XmlNodeReader $XAML6)

# Konvertiert die XML Datei in ein WPF UI Objekt
$window6 = [Windows.Markup.XamlReader]::Load($reader6)

Get-Variable var_*


#*****************************************************************************************************#

# Prüft ob eine Variable im UI enthalten ist
$txtWindow5Benutzername = $window6.FindName("txtWindow5Benutzername")
$btnWindow5Bestätigen = $window6.FindName("btnWindow5Bestätigen")
$txtWindow5Benutzername = $window6.FindName("txtWindow5Benutzername")
# $OldAccountName wird in die Textbox geschrieben
$txtWindow5Benutzername.Text = $OldAccountName

$btnWindow5Bestätigen.Add_Click( {
        # Der ausgewählte Benutzer wird gelöscht
        Remove-LocalUser $OldAccountName
        # Das UI schliesst sich
        $Null = $window6.Close()
        # Die Combobox wird aktualisiert
        $comboboxusers.Items.Clear();
        $comboboxvar = Get-LocalUser
        foreach($usercomboboxvar in $comboboxvar)
               {
                   $comboboxusers.Items.add($usercomboboxvar)
                   $comboboxusers.SelectedItem = $usercomboboxvar
               } 
    })

$Null = $window6.ShowDialog()  

})


######################################################################################################
# Direkt ausgeführt Abschnitt                                                                        #
######################################################################################################


# Prüft ob eine Variable im UI enthalten ist
$txtIP = $window.FindName("txtIP")
$btnCopyIP = $window.FindName("btnCopyIP")

# Der Wert von $ipV4 wird gesetzt
$ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address 
$txtIP.Text = $txtIP.Text + "$ipV4"


#*****************************************************************************************************#


$btnCopyIP.Add_Click( {
# Der Wert von $ipV4 wird gesetzt, damit dieser später in die Zwischenablage kopiert werden kann
$ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select -ExpandProperty IPV4Address
# $ipV4 wird in die Zwischenablage kopiert
Set-Clipboard $ipV4
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$txtComputer = $window.FindName("txtComputer")
$btnCopyComputerName = $window.FindName("btnCopyComputerName")

# Der Wert von der $txtComputer Texbox wird gesetzt
$txtComputer.Text = $env:COMPUTERNAME

$btnCopyComputerName.Add_Click( {
# $env:COMPUTERNAME wird in die Zwischenablage kopiert
Set-Clipboard $env:COMPUTERNAME
   })


#*****************************************************************************************************#


# Prüft ob eine Variable im UI enthalten ist
$txtDomain = $window.FindName("txtDomain")
$btnCopyDomain = $window.FindName("btnCopyDomain")

# Der Wert von der $cinfo Texbox wird gesetzt
$cinfo = $env:USERDNSDOMAIN
$txtDomain.Text = $txtDomain.Text + "$cinfo"

$btnCopyDomain.Add_Click( {
# $env:USERDNSDOMAIN wird in die Zwischenablage kopiert
Set-Clipboard $env:USERDNSDOMAIN
   })


######################################################################################################
# Immer das Ende des Scripts                                                                         #
$Null = $window.ShowDialog()                                                                         #
#                                                                                                    #
######################################################################################################