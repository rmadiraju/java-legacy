@echo off
REM Quick Start Script for Legacy E-Commerce Application (Windows)
REM This is a simplified version for quick testing

echo 🚀 Quick Start - Legacy E-Commerce Application
echo ==============================================

REM Check if we're in the right directory
if not exist "pom.xml" (
    echo ❌ Error: pom.xml not found. Please run this script from the project root directory.
    pause
    exit /b 1
)

REM Check Java and Maven
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java not found. Please install Java 8+ and try again.
    pause
    exit /b 1
)

mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Maven not found. Please install Maven 3.6+ and try again.
    pause
    exit /b 1
)

echo ✅ Prerequisites check passed
echo.

REM Build and run
echo 🔨 Building application...
call mvn clean compile -q

echo 📦 Packaging application...
call mvn package -q -DskipTests

echo 🚀 Starting application...
echo.
echo 🌐 Application will be available at: http://localhost:8080/ecommerce
echo 📊 Initialize data at: http://localhost:8080/ecommerce/init-data
echo.
echo ⏳ Starting Tomcat server...
echo    (This may take a moment on first run)
echo.

REM Start the application
call mvn tomcat7:run
