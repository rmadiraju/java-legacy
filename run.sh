#!/bin/bash

# Legacy E-Commerce Application Runner Script
# This script builds and runs the Java legacy e-commerce application

set -e  # Exit on any error

echo "🚀 Starting Legacy E-Commerce Application Setup..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Java is installed
check_java() {
    print_status "Checking Java installation..."
    if command -v java &> /dev/null; then
        JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2)
        print_success "Java found: $JAVA_VERSION"
    else
        print_error "Java is not installed or not in PATH"
        print_error "Please install Java 8 or higher and try again"
        exit 1
    fi
}

# Check if Maven is installed
check_maven() {
    print_status "Checking Maven installation..."
    if command -v mvn &> /dev/null; then
        MAVEN_VERSION=$(mvn -version | head -n 1 | cut -d' ' -f3)
        print_success "Maven found: $MAVEN_VERSION"
    else
        print_error "Maven is not installed or not in PATH"
        print_error "Please install Maven 3.6 or higher and try again"
        exit 1
    fi
}

# Build the application
build_app() {
    print_status "Building the application..."
    if mvn clean compile -q; then
        print_success "Application built successfully"
    else
        print_error "Build failed. Please check the error messages above."
        exit 1
    fi
}

# Package the application
package_app() {
    print_status "Packaging the application..."
    if mvn package -q -DskipTests; then
        print_success "Application packaged successfully"
    else
        print_error "Packaging failed. Please check the error messages above."
        exit 1
    fi
}

# Initialize sample data
init_data() {
    print_status "Waiting for application to start..."
    sleep 10
    
    print_status "Initializing sample data..."
    if curl -s "http://localhost:8080/ecommerce/init-data" > /dev/null; then
        print_success "Sample data initialized successfully"
    else
        print_warning "Could not initialize sample data automatically"
        print_warning "Please visit http://localhost:8080/ecommerce/init-data manually"
    fi
}

# Run the application
run_app() {
    print_status "Starting the application..."
    print_status "The application will be available at: http://localhost:8080/ecommerce"
    print_status "Press Ctrl+C to stop the application"
    echo ""
    
    # Start the application in the background
    mvn tomcat7:run &
    APP_PID=$!
    
    # Wait a bit for the application to start
    sleep 5
    
    # Initialize data
    init_data
    
    # Show application info
    echo ""
    print_success "🎉 Application is running!"
    echo "=================================================="
    echo "📱 Application URL: http://localhost:8080/ecommerce"
    echo "🏠 Homepage: http://localhost:8080/ecommerce/"
    echo "🛍️  Products: http://localhost:8080/ecommerce/products"
    echo "📊 Sample Data: http://localhost:8080/ecommerce/init-data"
    echo "=================================================="
    echo ""
    print_status "To test the application:"
    echo "1. Visit the homepage to see the welcome page"
    echo "2. Click 'Register' to create a new account"
    echo "3. Login and start shopping!"
    echo ""
    print_warning "Press Ctrl+C to stop the application"
    
    # Wait for the process to finish
    wait $APP_PID
}

# Clean up function
cleanup() {
    print_status "Stopping the application..."
    if [ ! -z "$APP_PID" ]; then
        kill $APP_PID 2>/dev/null || true
    fi
    print_success "Application stopped"
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Main execution
main() {
    echo "Legacy E-Commerce Application Runner"
    echo "===================================="
    echo ""
    
    # Check prerequisites
    check_java
    check_maven
    
    echo ""
    
    # Build and run
    build_app
    package_app
    
    echo ""
    
    # Run the application
    run_app
}

# Parse command line arguments
case "${1:-}" in
    "build")
        check_java
        check_maven
        build_app
        package_app
        print_success "Build completed successfully"
        ;;
    "clean")
        print_status "Cleaning the project..."
        mvn clean
        print_success "Project cleaned"
        ;;
    "help"|"-h"|"--help")
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  (no command)  Build and run the application"
        echo "  build         Build the application only"
        echo "  clean         Clean the project"
        echo "  help          Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0            # Build and run"
        echo "  $0 build      # Build only"
        echo "  $0 clean      # Clean project"
        ;;
    *)
        main
        ;;
esac
