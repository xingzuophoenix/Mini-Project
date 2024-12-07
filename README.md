# Mini-Project

Flutter App for Login, Document Upload and Dashboard

## APP Link: 

  https://xineohpouzgnix-8274510.on.drv.tw/miniproject/
  https://xineohpouzgnix-8274510.on.drv.tw/miniproject/dashboard.html
  https://xineohpouzgnix-8274510.on.drv.tw/miniproject/upl.html


## **What This App Does**

This Flutter app allows users to log in, upload documents like profile pictures, driving licenses, certificates, and passports, and view a simple dashboard with posts and stories. It uses **BLoC** for managing the app’s data and keeping everything organized.

---

## **What’s in the App?**

- **Login Screen**: Users can enter a username and password (the password is treated as the email). It checks the details using an API, and if they match, it shows a "Sign in Successful" message. Otherwise, it shows a "Sign in Unsuccessful" message.
  
- **Upload Documents Screen**: After logging in, users can upload:
  - Profile Picture
  - Driving License
  - Certificate
  - Passport

  Users can choose to use the camera or pick files from the gallery. The app shows thumbnails of uploaded documents, and when clicked, they appear full-size. 

  The “Done” button only becomes active after all four documents are uploaded.

- **Dashboard Screen**: This screen shows a list of stories (like Instagram) and posts. Users can scroll through the stories and posts.

---

## **How the Code is Organized**

lib/
├── blocs/                   # Contains logic for different screens
│   ├── login/               # Handles login screen logic
│   ├── upload/              # Handles upload screen logic
├── models/                  # Defines user data structure
├── repository/              # Handles API requests and data
├── screens/                 # Contains screen designs like Login, Upload, Dashboard
├── widgets/                 # Reusable UI parts like buttons, stories, posts
├── main.dart                # Entry point to run the app
└── utils/                   # Contains useful functions like validation


---

## **How the App Works**

### **1. Login Screen:**
- The user enters a **username** and **password** (treated as email).
- The app sends the username and email to an API (a website) to check if they exist.
- If they match, it shows a success message. If not, it shows an error message.
  
**Login Flow**: 
- The app sends a request to the API, waits for a response, and shows either success or failure based on the data.

### **2. Upload Documents Screen:**
- The user can upload **images** (like profile pictures, driving licenses) using the **camera** or **gallery**.
- After uploading, the document appears as a thumbnail, and the user can click it to see it full size.
- The “Done” button becomes active only after uploading all 4 documents.

### **3. Dashboard Screen:**
- This screen shows **stories** and **posts**, just like Instagram. The stories are scrollable horizontally, and posts are scrollable vertically.

---

## **How to Run the App**

### **What You Need:**
- **Flutter SDK**: This is the tool to run Flutter apps. Install it from [Flutter website](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: This comes with Flutter, so you don’t need to install it separately.
- **IDE**: Use Visual Studio Code or Android Studio to work on Flutter projects.

### **Steps to Run:**

1. **Clone the Repository**:
   - Download the project to your computer:
     ```bash
     git clone https://github.com/your-username/flutter-user-authentication-and-upload.git
     cd flutter-user-authentication-and-upload
     ```

2. **Install Dependencies**:
   - Run the following command to get all the required libraries:
     ```bash
     flutter pub get
     ```

3. **Run the App**:
   - If you want to run it on your phone or emulator, use this:
     ```bash
     flutter run
     ```

4. **App Navigation**:
   - **Login Screen**: Enter a username and password (email). If successful, go to the upload screen.
   - **Upload Documents**: Upload the required documents.
   - **Dashboard**: View stories and posts.

---

## **Libraries Used**

- **flutter_bloc**: For managing the app's logic (BLoC pattern).
- **http**: For making requests to the API.
- **image_picker**: For selecting images from the camera or gallery.
