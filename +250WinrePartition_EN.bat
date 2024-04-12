@echo off

rem Disable Windows Recovery Settings
reagentc /disable

rem Run Diskpart to show available disks
echo Listing available disks:
echo list disk > list_disk.txt
diskpart /s list_disk.txt

rem Prompts the user to select a disk
set /p numerodisco="Enter the disk number with Windows OS: "
echo.

rem Run Diskpart to show the partitions of the selected disk
echo Listing disk partitions %numerodisco%:
echo select disk %numerodisco% > list_part.txt
echo list part >> list_part.txt
diskpart /s list_part.txt

rem We ask for the partition that we want to reduce normally the main one.
set /p numeroparticion="Enter the partition number to shrink (to remove 250MB): "
echo.

rem We ask for the WinRe partition (Recovery)
set /p partwinre="Enter the WinRe (Recovery) partition number: "
echo.

rem Run Diskpart with the desired operations
(
echo select disk %numerodisco%
echo select part %numeroparticion%
echo shrink desired=250 minimum=250
echo sel part %partwinre%
echo delete partition override
echo create partition primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
echo gpt attributes=0x8000000000000001
echo format quick fs=ntfs label="Windows RE tools"
echo list vol
) | diskpart

rem Enable Windows Recovery Settings
reagentc /enable