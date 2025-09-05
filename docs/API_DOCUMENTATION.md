# 📚 Food Delivery App API Documentation

This document describes the API endpoints and data models used in the Food Delivery App.

## 🔗 Base URL

```
https://api.fooddeliveryapp.com/v1
```

## 🔐 Authentication

All API requests require authentication using Firebase Auth tokens.

### Headers

```http
Authorization: Bearer <firebase_token>
Content-Type: application/json
```

## 📊 Data Models

### User Model

```json
{
  "id": "string",
  "email": "string",
  "name": "string",
  "phone": "string",
  "role": "customer|restaurant|rider|admin",
  "profileImageUrl": "string",
  "address": "string",
  "location": {
    "lat": "number",
    "lng": "number"
  },
  "isActive": "boolean",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Restaurant Model

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "logoUrl": "string",
  "address": "string",
  "location": {
    "lat": "number",
    "lng": "number"
  },
  "phone": "string",
  "email": "string",
  "categories": ["string"],
  "rating": "number",
  "reviewCount": "number",
  "deliveryTime": "number",
  "deliveryFee": "number",
  "minimumOrder": "number",
  "isActive": "boolean",
  "isApproved": "boolean",
  "ownerId": "string",
  "imageUrls": ["string"],
  "operatingHours": {
    "monday": "09:00-22:00",
    "tuesday": "09:00-22:00"
  },
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Dish Model

```json
{
  "id": "string",
  "restaurantId": "string",
  "name": "string",
  "description": "string",
  "price": "number",
  "imageUrl": "string",
  "category": "string",
  "ingredients": ["string"],
  "allergens": ["string"],
  "preparationTime": "number",
  "isAvailable": "boolean",
  "isVegetarian": "boolean",
  "isVegan": "boolean",
  "isSpicy": "boolean",
  "rating": "number",
  "reviewCount": "number",
  "orderCount": "number",
  "sizeOptions": {
    "small": "number",
    "medium": "number",
    "large": "number"
  },
  "addOns": [
    {
      "name": "string",
      "price": "number"
    }
  ],
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Order Model

```json
{
  "id": "string",
  "customerId": "string",
  "customerName": "string",
  "customerPhone": "string",
  "customerAddress": "string",
  "customerLocation": {
    "lat": "number",
    "lng": "number"
  },
  "restaurantId": "string",
  "restaurantName": "string",
  "restaurantAddress": "string",
  "restaurantLocation": {
    "lat": "number",
    "lng": "number"
  },
  "riderId": "string",
  "riderName": "string",
  "riderPhone": "string",
  "items": [
    {
      "id": "string",
      "dishId": "string",
      "dish": "DishModel",
      "quantity": "number",
      "selectedSize": "string",
      "selectedAddOns": ["string"],
      "specialInstructions": "string",
      "unitPrice": "number",
      "totalPrice": "number"
    }
  ],
  "subtotal": "number",
  "deliveryFee": "number",
  "serviceFee": "number",
  "tax": "number",
  "total": "number",
  "paymentMethod": "cod|credit_card|debit_card|digital_wallet",
  "paymentStatus": "pending|paid|failed|refunded",
  "orderStatus": "placed|accepted|preparing|ready|cancelled",
  "deliveryStatus": "pending|accepted|picked_up|on_the_way|delivered",
  "specialInstructions": "string",
  "estimatedDeliveryTime": "timestamp",
  "actualDeliveryTime": "timestamp",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "trackingData": "object"
}
```

## 🔌 API Endpoints

### Authentication

#### Register User
```http
POST /auth/register
```

**Request Body:**
```json
{
  "email": "string",
  "password": "string",
  "name": "string",
  "phone": "string",
  "role": "customer|restaurant|rider|admin",
  "address": "string",
  "location": {
    "lat": "number",
    "lng": "number"
  }
}
```

**Response:**
```json
{
  "success": true,
  "user": "UserModel",
  "token": "string"
}
```

#### Login User
```http
POST /auth/login
```

**Request Body:**
```json
{
  "email": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "success": true,
  "user": "UserModel",
  "token": "string"
}
```

### Restaurants

#### Get All Restaurants
```http
GET /restaurants
```

**Query Parameters:**
- `category` (optional): Filter by category
- `search` (optional): Search by name or description
- `lat` (optional): User latitude for distance calculation
- `lng` (optional): User longitude for distance calculation
- `radius` (optional): Search radius in kilometers (default: 10)

**Response:**
```json
{
  "success": true,
  "restaurants": ["RestaurantModel"],
  "total": "number"
}
```

#### Get Restaurant by ID
```http
GET /restaurants/{id}
```

**Response:**
```json
{
  "success": true,
  "restaurant": "RestaurantModel"
}
```

#### Get Restaurant Dishes
```http
GET /restaurants/{id}/dishes
```

**Query Parameters:**
- `category` (optional): Filter by dish category
- `search` (optional): Search by dish name

**Response:**
```json
{
  "success": true,
  "dishes": ["DishModel"],
  "total": "number"
}
```

### Orders

#### Create Order
```http
POST /orders
```

**Request Body:**
```json
{
  "restaurantId": "string",
  "items": [
    {
      "dishId": "string",
      "quantity": "number",
      "selectedSize": "string",
      "selectedAddOns": ["string"],
      "specialInstructions": "string"
    }
  ],
  "customerAddress": "string",
  "customerLocation": {
    "lat": "number",
    "lng": "number"
  },
  "paymentMethod": "cod|credit_card|debit_card|digital_wallet",
  "specialInstructions": "string"
}
```

**Response:**
```json
{
  "success": true,
  "order": "OrderModel"
}
```

#### Get User Orders
```http
GET /orders
```

**Query Parameters:**
- `status` (optional): Filter by order status
- `limit` (optional): Number of orders to return (default: 20)
- `offset` (optional): Number of orders to skip (default: 0)

**Response:**
```json
{
  "success": true,
  "orders": ["OrderModel"],
  "total": "number"
}
```

#### Get Order by ID
```http
GET /orders/{id}
```

**Response:**
```json
{
  "success": true,
  "order": "OrderModel"
}
```

#### Update Order Status
```http
PATCH /orders/{id}/status
```

**Request Body:**
```json
{
  "status": "placed|accepted|preparing|ready|cancelled",
  "deliveryStatus": "pending|accepted|picked_up|on_the_way|delivered"
}
```

**Response:**
```json
{
  "success": true,
  "order": "OrderModel"
}
```

### Restaurant Management

#### Create Restaurant
```http
POST /restaurants
```

**Request Body:**
```json
{
  "name": "string",
  "description": "string",
  "address": "string",
  "location": {
    "lat": "number",
    "lng": "number"
  },
  "phone": "string",
  "email": "string",
  "categories": ["string"],
  "operatingHours": {
    "monday": "09:00-22:00",
    "tuesday": "09:00-22:00"
  }
}
```

**Response:**
```json
{
  "success": true,
  "restaurant": "RestaurantModel"
}
```

#### Update Restaurant
```http
PATCH /restaurants/{id}
```

**Request Body:**
```json
{
  "name": "string",
  "description": "string",
  "address": "string",
  "location": {
    "lat": "number",
    "lng": "number"
  },
  "phone": "string",
  "email": "string",
  "categories": ["string"],
  "operatingHours": {
    "monday": "09:00-22:00",
    "tuesday": "09:00-22:00"
  }
}
```

**Response:**
```json
{
  "success": true,
  "restaurant": "RestaurantModel"
}
```

### Dish Management

#### Create Dish
```http
POST /dishes
```

**Request Body:**
```json
{
  "restaurantId": "string",
  "name": "string",
  "description": "string",
  "price": "number",
  "category": "string",
  "ingredients": ["string"],
  "allergens": ["string"],
  "preparationTime": "number",
  "isVegetarian": "boolean",
  "isVegan": "boolean",
  "isSpicy": "boolean",
  "sizeOptions": {
    "small": "number",
    "medium": "number",
    "large": "number"
  },
  "addOns": [
    {
      "name": "string",
      "price": "number"
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "dish": "DishModel"
}
```

#### Update Dish
```http
PATCH /dishes/{id}
```

**Request Body:**
```json
{
  "name": "string",
  "description": "string",
  "price": "number",
  "category": "string",
  "ingredients": ["string"],
  "allergens": ["string"],
  "preparationTime": "number",
  "isAvailable": "boolean",
  "isVegetarian": "boolean",
  "isVegan": "boolean",
  "isSpicy": "boolean"
}
```

**Response:**
```json
{
  "success": true,
  "dish": "DishModel"
}
```

### Rider Management

#### Get Available Deliveries
```http
GET /riders/deliveries
```

**Query Parameters:**
- `lat` (required): Rider latitude
- `lng` (required): Rider longitude
- `radius` (optional): Search radius in kilometers (default: 5)

**Response:**
```json
{
  "success": true,
  "deliveries": ["OrderModel"],
  "total": "number"
}
```

#### Accept Delivery
```http
POST /riders/deliveries/{id}/accept
```

**Response:**
```json
{
  "success": true,
  "order": "OrderModel"
}
```

#### Update Delivery Status
```http
PATCH /riders/deliveries/{id}/status
```

**Request Body:**
```json
{
  "status": "picked_up|on_the_way|delivered",
  "location": {
    "lat": "number",
    "lng": "number"
  }
}
```

**Response:**
```json
{
  "success": true,
  "order": "OrderModel"
}
```

## 🔔 Real-time Updates

The app uses Firebase Realtime Database for real-time updates:

### Order Updates
```
/orders/{orderId}
```

### Notifications
```
/notifications/{userId}
```

### Rider Location
```
/riders/{riderId}/location
```

## 📱 Push Notifications

### Notification Types

1. **Order Status Updates**
   - Order accepted
   - Order preparing
   - Order ready
   - Order picked up
   - Order delivered

2. **Delivery Updates**
   - Rider assigned
   - Rider location updates
   - Delivery completed

3. **System Notifications**
   - App updates
   - Promotions
   - Maintenance alerts

### Notification Payload

```json
{
  "title": "string",
  "body": "string",
  "data": {
    "type": "order_status|delivery_update|system",
    "orderId": "string",
    "action": "string"
  }
}
```

## 🚨 Error Handling

### Error Response Format

```json
{
  "success": false,
  "error": {
    "code": "string",
    "message": "string",
    "details": "object"
  }
}
```

### Common Error Codes

- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `409` - Conflict
- `422` - Validation Error
- `500` - Internal Server Error

## 🔒 Security

- All API endpoints require authentication
- User data is isolated by user ID
- Restaurant data is isolated by owner ID
- Input validation on all endpoints
- Rate limiting on public endpoints
- HTTPS only in production

## 📊 Rate Limits

- **Authentication**: 10 requests per minute
- **General API**: 100 requests per minute
- **File Upload**: 10 requests per minute
- **Real-time Updates**: 1000 requests per minute

## 🔄 Pagination

Most list endpoints support pagination:

```json
{
  "data": ["Model"],
  "pagination": {
    "page": "number",
    "limit": "number",
    "total": "number",
    "pages": "number"
  }
}
```

---

**Note**: This is a demo API documentation. In production, implement proper authentication, validation, and error handling.
