#!/bin/bash

# Quick Start Script for Legacy E-Commerce Application
# This is a simplified version for quick testing

echo "🚀 Quick Start - Legacy E-Commerce Application"
echo "=============================================="

# Check if we're in the right directory
if [ ! -f "pom.xml" ]; then
    echo "❌ Error: pom.xml not found. Please run this script from the project root directory."
    exit 1
fi

# Check Java and Maven
if ! command -v java &> /dev/null; then
    echo "❌ Java not found. Please install Java 8+ and try again."
    exit 1
fi

if ! command -v mvn &> /dev/null; then
    echo "❌ Maven not found. Please install Maven 3.6+ and try again."
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# Build and run
echo "🔨 Building application..."
mvn clean compile -q

echo "📦 Packaging application..."
mvn package -q -DskipTests

echo "🚀 Starting application..."
echo ""
echo "🌐 Application will be available at: http://localhost:8080/ecommerce"
echo "📊 Initialize data at: http://localhost:8080/ecommerce/init-data"
echo ""
echo "⏳ Starting Tomcat server..."
echo "   (This may take a moment on first run)"
echo ""

# Start the application
mvn tomcat7:run
