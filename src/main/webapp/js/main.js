// Main JavaScript file for E-Commerce Application

document.addEventListener('DOMContentLoaded', function() {
    // Initialize cart count
    updateCartCount();
    
    // Initialize dropdown menus
    initializeDropdowns();
    
    // Initialize form validations
    initializeFormValidations();
    
    // Initialize quantity inputs
    initializeQuantityInputs();
});

// Update cart count in header
function updateCartCount() {
    // This would typically make an AJAX call to get the current cart count
    // For now, we'll just ensure the cart count is displayed if it exists
    const cartCounts = document.querySelectorAll('.cart-count');
    cartCounts.forEach(count => {
        if (count.textContent === '0') {
            count.style.display = 'none';
        }
    });
}

// Initialize dropdown menus
function initializeDropdowns() {
    const dropdowns = document.querySelectorAll('.dropdown');
    
    dropdowns.forEach(dropdown => {
        const toggle = dropdown.querySelector('.dropdown-toggle');
        const menu = dropdown.querySelector('.dropdown-menu');
        
        if (toggle && menu) {
            toggle.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                
                // Close other dropdowns
                dropdowns.forEach(otherDropdown => {
                    if (otherDropdown !== dropdown) {
                        otherDropdown.classList.remove('active');
                    }
                });
                
                // Toggle current dropdown
                dropdown.classList.toggle('active');
            });
        }
    });
    
    // Close dropdowns when clicking outside
    document.addEventListener('click', function() {
        dropdowns.forEach(dropdown => {
            dropdown.classList.remove('active');
        });
    });
}

// Initialize form validations
function initializeFormValidations() {
    // Password confirmation validation
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    
    if (passwordInput && confirmPasswordInput) {
        confirmPasswordInput.addEventListener('input', function() {
            if (passwordInput.value !== confirmPasswordInput.value) {
                confirmPasswordInput.setCustomValidity('Passwords do not match');
            } else {
                confirmPasswordInput.setCustomValidity('');
            }
        });
    }
    
    // Email validation
    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('input', function() {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(emailInput.value)) {
                emailInput.setCustomValidity('Please enter a valid email address');
            } else {
                emailInput.setCustomValidity('');
            }
        });
    }
}

// Initialize quantity inputs
function initializeQuantityInputs() {
    const quantityInputs = document.querySelectorAll('input[name="quantity"]');
    
    quantityInputs.forEach(input => {
        input.addEventListener('change', function() {
            const min = parseInt(this.getAttribute('min')) || 1;
            const max = parseInt(this.getAttribute('max')) || 999;
            const value = parseInt(this.value) || min;
            
            if (value < min) {
                this.value = min;
            } else if (value > max) {
                this.value = max;
            }
        });
    });
}

// Add to cart functionality
function addToCart(productId, quantity = 1) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/ecommerce/cart';
    
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'add';
    
    const productInput = document.createElement('input');
    productInput.type = 'hidden';
    productInput.name = 'productId';
    productInput.value = productId;
    
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = quantity;
    
    form.appendChild(actionInput);
    form.appendChild(productInput);
    form.appendChild(quantityInput);
    
    document.body.appendChild(form);
    form.submit();
}

// Update cart item quantity
function updateCartItemQuantity(cartItemId, quantity) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/ecommerce/cart';
    
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'update';
    
    const cartItemInput = document.createElement('input');
    cartItemInput.type = 'hidden';
    cartItemInput.name = 'cartItemId';
    cartItemInput.value = cartItemId;
    
    const quantityInput = document.createElement('input');
    quantityInput.type = 'hidden';
    quantityInput.name = 'quantity';
    quantityInput.value = quantity;
    
    form.appendChild(actionInput);
    form.appendChild(cartItemInput);
    form.appendChild(quantityInput);
    
    document.body.appendChild(form);
    form.submit();
}

// Remove item from cart
function removeFromCart(cartItemId) {
    if (confirm('Are you sure you want to remove this item from your cart?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/ecommerce/cart';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'remove';
        
        const cartItemInput = document.createElement('input');
        cartItemInput.type = 'hidden';
        cartItemInput.name = 'cartItemId';
        cartItemInput.value = cartItemId;
        
        form.appendChild(actionInput);
        form.appendChild(cartItemInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

// Clear entire cart
function clearCart() {
    if (confirm('Are you sure you want to clear your entire cart?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/ecommerce/cart';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'clear';
        
        form.appendChild(actionInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

// Search products
function searchProducts(searchTerm) {
    if (searchTerm.trim() === '') {
        window.location.href = '/ecommerce/products';
        return;
    }
    
    window.location.href = '/ecommerce/products?search=' + encodeURIComponent(searchTerm);
}

// Filter products by category
function filterByCategory(category) {
    if (category) {
        window.location.href = '/ecommerce/products?category=' + encodeURIComponent(category);
    } else {
        window.location.href = '/ecommerce/products';
    }
}

// Toggle order details
function toggleOrderDetails(orderId) {
    const details = document.getElementById('details-' + orderId);
    if (details) {
        if (details.style.display === 'none' || details.style.display === '') {
            details.style.display = 'block';
        } else {
            details.style.display = 'none';
        }
    }
}

// Show loading spinner
function showLoading(element) {
    const spinner = document.createElement('div');
    spinner.className = 'loading-spinner';
    spinner.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
    
    if (element) {
        element.appendChild(spinner);
    }
}

// Hide loading spinner
function hideLoading(element) {
    const spinner = element.querySelector('.loading-spinner');
    if (spinner) {
        spinner.remove();
    }
}

// Show alert message
function showAlert(message, type = 'info') {
    const alert = document.createElement('div');
    alert.className = `alert alert-${type}`;
    alert.innerHTML = `
        <i class="fas fa-${type === 'error' ? 'exclamation-circle' : 'check-circle'}"></i>
        ${message}
    `;
    
    const container = document.querySelector('.container');
    if (container) {
        container.insertBefore(alert, container.firstChild);
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            alert.remove();
        }, 5000);
    }
}

// Format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(amount);
}

// Validate form
function validateForm(form) {
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    
    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            field.classList.add('error');
            isValid = false;
        } else {
            field.classList.remove('error');
        }
    });
    
    return isValid;
}

// Utility function to get URL parameters
function getUrlParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// Utility function to debounce function calls
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}
