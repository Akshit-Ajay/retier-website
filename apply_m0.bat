@echo off
REM Run from C:\dev\retier AFTER copying the zip contents over the project.
REM Deletes only unused skeleton files.
del /q backend\app\store.py backend\app\services\example.py backend\requirements-pipeline.txt backend\tests\test_services.py docs\ADAPTING.md 2>nul
rmdir /s /q backend\pipeline 2>nul
rmdir /s /q data\processed 2>nul
rmdir /s /q data\sources 2>nul
echo M0 cleanup done.
