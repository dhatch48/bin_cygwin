@echo off

REM The %~dp0 (that’s a zero) variable when referenced within a Windows batch file will expand to the drive letter and path of that batch file.

REM The variables %0-%9 refer to the command line parameters of the batch file. %1-%9 refer to command line arguments after the batch file name. %0 refers to the batch file itself.

REM If you follow the percent character (%) with a tilde character (~), you can insert a modifier(s) before the parameter number to alter the way the variable is expanded. The d modifier expands to the drive letter and the p modifier expands to the path of the parameter.

echo Full Path       : %~f0
echo Drive + path    : %~dp0
echo File name + ext : %~nx0
echo File short      : %~fs0

echo Var1            : %1
echo Var1 Full Path  : %~f1
echo Var2 Full Path  : %~f2



