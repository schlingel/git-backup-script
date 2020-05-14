@ECHO OFF

REM Simple Backup Script
REM Set the following variables accordingly
REM Make sure that you install 7-zip
SET SZIP_PATH="C:\Program Files\7-Zip"
SET GITHUB_USER=<user>
SET GITHUB_PWD=<pwd>
SET GITHUB_URL=https://%GITHUB_USER%:%GITHUB_PWD%@github.com/schlingel/git-backup-script.git
SET GITHUB_PROJECT_NAME=git-backup-script

PATH=%PATH%;%SZIP_PATH%

SET WORKING_DIRECTORY=C:\Users\IEUser\Documents\example
REM Parse date env to get an iso-like date string
SET ISO_DATE=%date:~10,4%%date:~4,2%%date:~7,2%
SET BK_DIRECTORY=%WORKING_DIRECTORY%\backup_%ISO_DATE%
SET BK_TARGET_DIRECTORY=C:\Users\IEUser\Documents\example\backups

REM Remove old folder if it exists
IF EXIST %BK_DIRECTORY% (rmdir /s /q %BK_DIRECTORY%)

echo Creating Temporary directory...

mkdir "%BK_DIRECTORY%"
cd "%BK_DIRECTORY%"

echo Cloning Git Project

git clone %GITHUB_URL%

echo Compressing Folder for backup
7z.exe a "backup_%ISO_DATE%" "%BK_DIRECTORY%/%GITHUB_PROJECT_NAME%/*"

echo Moving compressed backup to target directory
xcopy "%BK_DIRECTORY%\backup_%ISO_DATE%.7z" "%BK_TARGET_DIRECTORY%" /c /i /y

echo Finished backup