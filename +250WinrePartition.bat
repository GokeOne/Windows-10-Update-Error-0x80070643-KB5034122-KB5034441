@echo off

rem Deshabilita la configuración de recuperación de Windows
reagentc /disable

rem Ejecuta Diskpart para mostrar los discos disponibles
echo Listando discos disponibles:
echo list disk > list_disk.txt
diskpart /s list_disk.txt

rem Pide al usuario que seleccione un disco
set /p numerodisco="Ingrese el número del disco con el S.O windows: "
echo.

rem Ejecuta Diskpart para mostrar las particiones del disco seleccionado
echo Listando particiones del disco %numerodisco%:
echo select disk %numerodisco% > list_part.txt
echo list part >> list_part.txt
diskpart /s list_part.txt

rem Pedimos la particion que queremos reducir normalmente la principal.
set /p numeroparticion="Ingrese el número de la partición para reducir (para quitarle 250MB): "
echo.

rem Pedimos la particion de WinRe(Recuperacion)
set /p partwinre="Ingre el numero de la particion de WinRe(Recuperacion): "
echo.

rem Ejecuta Diskpart con las operaciones deseadas
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

rem Habilita la configuración de recuperación de Windows
reagentc /enable