# 🍕 Food Delivery App

A comprehensive food delivery application similar to FoodPanda with multi-role support for customers, restaurant owners, riders, and administrators.

## 🚀 Features

### Multi-Role System
- **👤 Customer**: Browse restaurants, place orders, track delivery
- **🏪 Restaurant Owner**: Manage menu, orders, analytics
- **🚚 Rider**: Accept deliveries, navigate, update status
- **👨‍💼 Admin**: System management, analytics, user management

### Key Features
- Modern FoodPanda-style UI with pink/white branding
- Real-time order tracking and notifications
- Payment integration
- Responsive design for all devices
- Production-ready backend with scalable architecture

## 🛠️ Technology Stack

- **Frontend**: React Native (Mobile) + React (Web Admin)
- **Backend**: Node.js + Express + TypeScript
- **Database**: MongoDB
- **Real-time**: Socket.io
- **State Management**: Redux Toolkit
- **UI**: React Native Elements + Custom Components

## 📁 Project Structure

```
food-delivery-app/
├── mobile/          # React Native mobile app
├── web-admin/       # React web admin panel
├── backend/         # Node.js backend API
├── shared/          # Shared types and utilities
└── docs/           # Documentation
```

## 🚀 Getting Started

1. **Install dependencies:**
   ```bash
   npm run install:all
   ```

2. **Start development servers:**
   ```bash
   npm run dev
   ```

3. **Access applications:**
   - Mobile App: Expo Go app
   - Web Admin: http://localhost:3000
   - API: http://localhost:5000

## 📱 Mobile App Features

### Customer App
- Restaurant browsing with filters
- Menu viewing and customization
- Shopping cart and checkout
- Order tracking with real-time updates
- Order history and favorites

### Restaurant App
- Menu management (add/edit/delete items)
- Order management dashboard
- Analytics and reporting
- Restaurant profile management

### Rider App
- Available delivery requests
- Navigation and route optimization
- Order status updates
- Earnings tracking

## 🌐 Web Admin Features

- User management (customers, restaurants, riders)
- System analytics and reporting
- Restaurant approval and management
- Payment and commission tracking
- Real-time system monitoring

## 🔧 Development

- **Backend API**: RESTful API with Socket.io for real-time features
- **Database**: MongoDB with Mongoose ODM
- **Authentication**: JWT with role-based access control
- **File Upload**: Cloudinary for image management
- **Maps**: Google Maps integration for location services

## 📦 Deployment

- **Mobile**: Expo Application Services (EAS)
- **Web**: Vercel or Netlify
- **Backend**: Railway, Heroku, or AWS
- **Database**: MongoDB Atlas

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
