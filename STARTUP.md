# 🚀 Application Startup Scripts

This directory contains several scripts to help you run the Legacy E-Commerce Application easily.

## 📋 Available Scripts

### 🐧 Linux/macOS Scripts

#### `run.sh` - Full-featured runner
```bash
./run.sh
```
**Features:**
- ✅ Checks Java and Maven installation
- 🔨 Builds and packages the application
- 🚀 Starts the application with Tomcat
- 📊 Automatically initializes sample data
- 🎨 Colored output with status messages
- 🛑 Graceful shutdown with Ctrl+C

**Commands:**
- `./run.sh` - Build and run (default)
- `./run.sh build` - Build only
- `./run.sh clean` - Clean project
- `./run.sh help` - Show help

#### `quick-start.sh` - Simple runner
```bash
./quick-start.sh
```
**Features:**
- ⚡ Quick startup without extra features
- 🔨 Basic build and run
- 🚀 Direct Tomcat startup

### 🪟 Windows Scripts

#### `run.bat` - Full-featured runner
```cmd
run.bat
```
**Features:**
- ✅ Checks Java and Maven installation
- 🔨 Builds and packages the application
- 🚀 Starts the application in a separate window
- 📊 Automatically initializes sample data
- 🎨 Colored output with status messages

#### `quick-start.bat` - Simple runner
```cmd
quick-start.bat
```
**Features:**
- ⚡ Quick startup without extra features
- 🔨 Basic build and run
- 🚀 Direct Tomcat startup

## 🎯 Quick Start Guide

### Option 1: Use the Scripts (Recommended)

**For Linux/macOS:**
```bash
# Make scripts executable (if not already done)
chmod +x run.sh quick-start.sh

# Run the application
./run.sh
```

**For Windows:**
```cmd
# Double-click run.bat or run from command prompt
run.bat
```

### Option 2: Manual Commands

```bash
# Build the application
mvn clean compile

# Package the application
mvn package -DskipTests

# Run the application
mvn tomcat7:run
```

## 🌐 Accessing the Application

Once the application starts, you can access it at:

- **🏠 Homepage:** http://localhost:8080/ecommerce/
- **🛍️ Products:** http://localhost:8080/ecommerce/products
- **📊 Initialize Data:** http://localhost:8080/ecommerce/init-data

## 📝 First Time Setup

1. **Run the application** using one of the scripts above
2. **Initialize sample data** by visiting: http://localhost:8080/ecommerce/init-data
3. **Register a new account** by clicking "Register" on the homepage
4. **Start shopping!** Browse products, add to cart, and complete checkout

## 🔧 Troubleshooting

### Common Issues

**❌ "Java not found"**
- Install Java 8 or higher
- Make sure Java is in your PATH
- Verify with: `java -version`

**❌ "Maven not found"**
- Install Maven 3.6 or higher
- Make sure Maven is in your PATH
- Verify with: `mvn -version`

**❌ "Port 8080 already in use"**
- Stop other applications using port 8080
- Or change the port in `pom.xml`:
  ```xml
  <configuration>
      <port>8081</port>
  </configuration>
  ```

**❌ "Build failed"**
- Check Java and Maven versions
- Run `mvn clean` and try again
- Check for network connectivity (Maven downloads dependencies)

### Getting Help

If you encounter issues:

1. **Check the logs** in the terminal/command prompt
2. **Verify prerequisites** (Java 8+, Maven 3.6+)
3. **Try manual commands** instead of scripts
4. **Check the README.md** for detailed instructions

## 🎉 Success!

When everything works correctly, you should see:

```
🎉 Application is running!
==================================================
📱 Application URL: http://localhost:8080/ecommerce
🏠 Homepage: http://localhost:8080/ecommerce/
🛍️  Products: http://localhost:8080/ecommerce/products
📊 Sample Data: http://localhost:8080/ecommerce/init-data
==================================================
```

Happy shopping! 🛒
