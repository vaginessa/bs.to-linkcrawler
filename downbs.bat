@echo off
cls
echo [Tutorial Alert]
echo.
echo The Series Name has to be the name in the Url
echo an Example for Akame ga Kill :
echo The Link is https://bs.to/serie/Akame-ga-Kill/1
echo The Series Name you have to enter is: "Akame-ga-Kill" (without quotes)
echo.
pause
cls
echo.
set /p ss="Enter the Series you want to get the Links from:"
echo Please wait it's downloading now some data for the Links...

tools\wget -r -p -S --no-parent https://bs.to/serie/%ss%/ --no-check-certificate

echo finished downloading data
cls
:season
echo Season 0 (Special) won't work in most cases because the are just the Files
set /p season="Enter the Season you want to get the Links from:"

for /D %%f in (bs.to\serie\%ss%\%season%\*) do (
tools\grep -rn %%f\Streamango -e "https://bs.to/out/">>link.txt
)

tools\sed 2~2d link.txt > link
del /Q /F link.txt
tools\sed  -r "s .{13}  " link > link.txt
del /Q /F link
tools\cut -b1-25 link.txt > link
del /Q /F link.txt
ren link %ss%_%season%.txt
cls
echo Do you want to download another season ?
set /p bb="y or n:"
IF %bb% == y goto :season
pause
exit /b