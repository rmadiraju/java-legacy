# Legacy E-Commerce Java Application

A comprehensive Java legacy e-commerce web application built using servlets, JSP, EJB, and H2 database. This application demonstrates traditional Java EE patterns and technologies.

## Features

- **User Management**: Registration, login, and user profiles
- **Product Catalog**: Browse products by category, search functionality
- **Shopping Cart**: Add/remove items, update quantities
- **Order Management**: Checkout process, order history
- **Responsive UI**: Modern, mobile-friendly interface
- **Database**: H2 in-memory database with JPA/Hibernate

## Technology Stack

- **Java 8**
- **Servlets 3.1** - HTTP request handling
- **JSP 2.3** - View layer with JSTL
- **EJB 3.2** - Business logic (Session Beans)
- **JPA 2.2** - Data persistence
- **Hibernate 5.4** - JPA implementation
- **H2 Database** - In-memory database
- **Maven** - Build and dependency management
- **Tomcat** - Application server

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/ecommerce/
│   │       ├── servlet/          # HTTP request handlers
│   │       ├── ejb/
│   │       │   ├── entity/       # JPA entities
│   │       │   └── session/      # EJB session beans
│   │       └── util/             # Utility classes and filters
│   ├── resources/
│   │   └── META-INF/
│   │       └── persistence.xml   # JPA configuration
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml          # Web application configuration
│       │   └── jsp/             # JSP pages
│       ├── css/                 # Stylesheets
│       ├── js/                  # JavaScript files
│       └── index.html           # Homepage
└── test/
    └── java/                    # Test classes
```

## Getting Started

### Prerequisites

- Java 8 or higher
- Maven 3.6 or higher
- Tomcat 8.5 or higher (or use Maven Tomcat plugin)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd java-legacy
   ```

2. **Build the project**
   ```bash
   mvn clean compile
   ```

3. **Run with Maven Tomcat plugin**
   ```bash
   mvn tomcat7:run
   ```
   
   Or deploy the WAR file to your Tomcat server:
   ```bash
   mvn clean package
   # Copy target/legacy-ecommerce.war to Tomcat webapps directory
   ```

4. **Initialize sample data**
   - Visit: `http://localhost:8080/ecommerce/init-data`
   - This will populate the database with sample products

5. **Access the application**
   - Homepage: `http://localhost:8080/ecommerce/`
   - Products: `http://localhost:8080/ecommerce/products`

## Usage

### User Registration and Login

1. **Register a new account**
   - Click "Register" in the navigation
   - Fill in username, email, password, and personal details
   - Submit the form

2. **Login**
   - Click "Login" in the navigation
   - Enter username and password
   - You'll be redirected to the products page

### Shopping Experience

1. **Browse Products**
   - View all products on the main products page
   - Use the search bar to find specific items
   - Filter by category using the dropdown

2. **Add to Cart**
   - Select quantity and click "Add to Cart"
   - Items are added to your shopping cart
   - Cart count is displayed in the header

3. **Manage Cart**
   - Click "Cart" in the navigation to view cart items
   - Update quantities or remove items
   - View order summary with tax and shipping

4. **Checkout**
   - Click "Proceed to Checkout"
   - Enter shipping and billing addresses
   - Select payment method
   - Complete the order

5. **View Orders**
   - Click "Orders" to view order history
   - View order details and status
   - Track order progress

## Database Schema

The application uses the following main entities:

- **User**: Customer information and authentication
- **Product**: Product catalog with categories, pricing, and inventory
- **CartItem**: Shopping cart items linked to users and products
- **Order**: Customer orders with status tracking
- **OrderItem**: Individual items within orders

## Configuration

### Database Configuration

The application uses H2 in-memory database by default. Configuration is in `src/main/resources/META-INF/persistence.xml`:

```xml
<property name="javax.persistence.jdbc.url" 
          value="jdbc:h2:mem:ecommerce;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE"/>
```

### Web Application Configuration

Main configuration is in `src/main/webapp/WEB-INF/web.xml`:
- Servlet mappings
- Security constraints
- Session configuration
- Error pages

## Development

### Adding New Features

1. **New Entity**: Create JPA entity in `ejb.entity` package
2. **Business Logic**: Create EJB session bean in `ejb.session` package
3. **Web Layer**: Create servlet in `servlet` package
4. **View**: Create JSP page in `webapp/WEB-INF/jsp`
5. **Configuration**: Update `web.xml` with new servlet mappings

### Testing

Run tests with:
```bash
mvn test
```

## Deployment

### Production Deployment

1. **Build WAR file**
   ```bash
   mvn clean package
   ```

2. **Deploy to Tomcat**
   - Copy `target/legacy-ecommerce.war` to Tomcat `webapps` directory
   - Start Tomcat server
   - Access application at `http://your-server:8080/legacy-ecommerce`

### Docker Deployment

Create a `Dockerfile`:
```dockerfile
FROM tomcat:8.5-jdk8
COPY target/legacy-ecommerce.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

## API Endpoints

- `GET /products` - Product listing page
- `GET /login` - Login page
- `POST /login` - Login form submission
- `GET /register` - Registration page
- `POST /register` - Registration form submission
- `GET /cart` - Shopping cart page
- `POST /cart` - Cart operations (add/update/remove)
- `GET /checkout` - Checkout page
- `POST /checkout` - Process order
- `GET /orders` - Order history
- `GET /logout` - Logout user
- `GET /init-data` - Initialize sample data

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or issues, please create an issue in the repository or contact the development team.