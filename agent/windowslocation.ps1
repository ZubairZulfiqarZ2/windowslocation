# Windows Location Plugin for OCS Inventory NG
# Copyright (C) 2025 Zubair Zulfiqar
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Script: Retrieve Windows geolocation data
# Version: 1.0
# Date: 05/28/2025
# Author: Zubair Zulfiqar, adapted from Stéphane PAUTREL

# Load System.Device assembly for GeoCoordinateWatcher
Add-Type -AssemblyName System.Device


$GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher

if ($GeoWatcher.Status -eq 'Disabled' -or $GeoWatcher.Status -eq 'NotSupported') {
    Write-Output "<WINDOWSLOCATION>`n<STATUS>$($GeoWatcher.Status)</STATUS>`n</WINDOWSLOCATION>"
    exit
}

$timeoutSeconds = 3
$startTime = Get-Date

try {
    $GeoWatcher.Start()
}
catch {
    Write-Output "<WINDOWSLOCATION/>"
    exit
}


if ($GeoWatcher.Status -eq 'Initializing') {
    while (($GeoWatcher.Status -eq 'Initializing') -and ($GeoWatcher.Permission -ne 'Denied')) {
        if (((Get-Date) - $startTime).TotalSeconds -ge $timeoutSeconds) {
            Write-Output "<WINDOWSLOCATION>`n<STATUS>$($GeoWatcher.Status)</STATUS>`n</WINDOWSLOCATION>" # Timeout reached
            $GeoWatcher.Stop()
            exit
        }
        Start-Sleep -Milliseconds 100
    }
}

# Initialize output
$outputXml = "<WINDOWSLOCATION/>"

if ($GeoWatcher.Permission -eq 'Denied') {
	$outputXml = "<WINDOWSLOCATION>`n"
	$outputXml += "  <PERMISSION>$($GeoWatcher.Permission)</PERMISSION>`n"
    $outputXml += "<STATUS>$($GeoWatcher.Status)</STATUS>`n"
	$outputXml += "</WINDOWSLOCATION>"
}
elseif ($GeoWatcher.Status -eq 'Ready') {
    $location = $GeoWatcher.Position.Location
    $outputXml = "<WINDOWSLOCATION>`n"
    $outputXml += "<LATITUDE>$($location.Latitude)</LATITUDE>`n"
    $outputXml += "<LONGITUDE>$($location.Longitude)</LONGITUDE>`n"
    $outputXml += "<STATUS>$($GeoWatcher.Status)</STATUS>`n"
    $outputXml += "  <PERMISSION>$($GeoWatcher.Permission)</PERMISSION>`n"
    $outputXml += "  <ISUNKNOWN>$($location.IsUnknown)</ISUNKNOWN>`n"
    
    $altitude = if ($location.Altitude -eq $null -or [double]::IsNaN($location.Altitude)) { "Unknown" } else { $location.Altitude }
    $outputXml += "<ALTITUDE>$altitude</ALTITUDE>`n"
    
    $horizontalAccuracy = if ($location.HorizontalAccuracy -eq $null -or [double]::IsNaN($location.HorizontalAccuracy)) { "Unknown" } else { $location.HorizontalAccuracy }
    $outputXml += "<HORIZONTALACCURACY>$horizontalAccuracy</HORIZONTALACCURACY>`n"
    
    $verticalAccuracy = if ($location.VerticalAccuracy -eq $null -or [double]::IsNaN($location.VerticalAccuracy)) { "Unknown" } else { $location.VerticalAccuracy }
    $outputXml += "<VERTICALACCURACY>$verticalAccuracy</VERTICALACCURACY>`n"
    
    $speed = if ($location.Speed -eq $null -or [double]::IsNaN($location.Speed)) { "Unknown" } else { $location.Speed }
    $outputXml += "<SPEED>$speed</SPEED>`n"
    
    $outputXml += "</WINDOWSLOCATION>"
}else {
    $outputXml = "<WINDOWSLOCATION/>" # Unexpected status
}

$GeoWatcher.Stop()

Write-Output $outputXml