@echo off
echo ==== Generating Project ====
echo.
pushd %~dp0\..\
echo.
CALL ThirdParty\Premake\Bin\premake5.exe vs2019