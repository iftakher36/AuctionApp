# auction_app

A flutter application like ebay auction app.

## Documentations

## Provider Package

Here,Provider Package used for state management. All the business logic would found in view-model

## Firebase Core Package

In summary, the Firebase Core library is a crucial part of the Firebase platform that is responsible
for initializing and managing Firebase services in app, providing a foundation for other Firebase
libraries, and enable to configure Firebase options.

## Firebase Auth Package & Google Sign In Package

This package used to authenticate google user by their Gmail ---> 1. first step is get all the possible
gmail accounts stored in device using google sign in ----> 2. then selected user mail will be
authenticate via OAuth Provider ----> 3. after that Oauth verified user will register to firebase via
Firebase Auth Package

## Firebase Storage

This package used to upload the image file to the firebase cloud storage and user wise added the
uploaded file link to The firebase cloud fire-store database

## Cloud Firestore Package

This package used to store the Product Name, Product Description, Product Photo link that stored in
firebase storage , Minimum Bid Price, and Auction End DateTime by User Wise

## ImagePicker Package
Image Picker Package added to pick images from gallery and upload the image to cloud storage
