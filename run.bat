@echo off
REM Legacy E-Commerce Application Runner Script for Windows
REM This script builds and runs the Java legacy e-commerce application

setlocal enabledelayedexpansion

echo 🚀 Starting Legacy E-Commerce Application Setup...
echo ==================================================

REM Check if Java is installed
echo [INFO] Checking Java installation...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Java is not installed or not in PATH
    echo [ERROR] Please install Java 8 or higher and try again
    pause
    exit /b 1
) else (
    for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| findstr "version"') do set JAVA_VERSION=%%i
    echo [SUCCESS] Java found: !JAVA_VERSION!
)

REM Check if Maven is installed
echo [INFO] Checking Maven installation...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Maven is not installed or not in PATH
    echo [ERROR] Please install Maven 3.6 or higher and try again
    pause
    exit /b 1
) else (
    for /f "tokens=3" %%i in ('mvn -version ^| findstr "Apache Maven"') do set MAVEN_VERSION=%%i
    echo [SUCCESS] Maven found: !MAVEN_VERSION!
)

echo.

REM Build the application
echo [INFO] Building the application...
call mvn clean compile -q
if %errorlevel% neq 0 (
    echo [ERROR] Build failed. Please check the error messages above.
    pause
    exit /b 1
) else (
    echo [SUCCESS] Application built successfully
)

REM Package the application
echo [INFO] Packaging the application...
call mvn package -q -DskipTests
if %errorlevel% neq 0 (
    echo [ERROR] Packaging failed. Please check the error messages above.
    pause
    exit /b 1
) else (
    echo [SUCCESS] Application packaged successfully
)

echo.

REM Run the application
echo [INFO] Starting the application...
echo [INFO] The application will be available at: http://localhost:8080/ecommerce
echo [INFO] Press Ctrl+C to stop the application
echo.

REM Start the application
start "E-Commerce App" cmd /k "mvn tomcat7:run"

REM Wait for application to start
echo [INFO] Waiting for application to start...
timeout /t 15 /nobreak >nul

REM Initialize sample data
echo [INFO] Initializing sample data...
curl -s "http://localhost:8080/ecommerce/init-data" >nul 2>&1
if %errorlevel% equ 0 (
    echo [SUCCESS] Sample data initialized successfully
) else (
    echo [WARNING] Could not initialize sample data automatically
    echo [WARNING] Please visit http://localhost:8080/ecommerce/init-data manually
)

echo.
echo [SUCCESS] 🎉 Application is running!
echo ==================================================
echo 📱 Application URL: http://localhost:8080/ecommerce
echo 🏠 Homepage: http://localhost:8080/ecommerce/
echo 🛍️  Products: http://localhost:8080/ecommerce/products
echo 📊 Sample Data: http://localhost:8080/ecommerce/init-data
echo ==================================================
echo.
echo [INFO] To test the application:
echo 1. Visit the homepage to see the welcome page
echo 2. Click 'Register' to create a new account
echo 3. Login and start shopping!
echo.
echo [INFO] The application is running in a separate window.
echo [INFO] Close that window to stop the application.
echo.
pause
