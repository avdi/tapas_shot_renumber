## Let’s build a mobile app to accept donations for a zoo

Say a we’ve been asked by a local zoo to create an app to enable zoo-lovers to make small donations to the institution right from their phone. Let’s start by skipping forward in time for a moment, just to get an idea of what the app we’re about to build will look like.

## You pick a penguin to feed, and it bills your credit card

 <!-- shot(1) --> 

In order to make the app more engaging, we’ve settled on a design that’s a little bit more fun than just picking a dollar amount for the donation. Our zoo is particularly famous for their population of various species of penguin. In order to capitalize on the star power of their penguin residents, our donation app is penguin-themed. 

 <!-- shot(2) --> 

Patrons can choose a penguin they’d like to feed. 

 <!-- shot(3) --> 

When they do, the app presents them with a credit card entry screen.

 <!-- shot(4) --> 

Once they fill in their details, 

 <!-- shot(5) --> 

they are charged for the cost of providing their chosen penguin with its favorite fishy snack.

## In this episode, we’ll create the basic app UI

In this episode, we’re just going to create the basic mobile app user interface. Then, in later episodes, we’ll wire up our UI to the Square payment APIs.

In order to create a single app that runs on both iOS and Android devices, we’ll use the Flutter framework. Flutter is a Google-developed, open-source technology for cross-platform native app development. You can find out more about it at https://flutter.dev.

Ready? Let’s create our app!

## We start with a default Flutter application

<!-- shot(6) -->

We begin by firing up Android Studio, and asking it to create an empty Flutter app for us.

 <!-- shot(7) --> 

In order to see the app in action, we’ll create a new Android phone emulator and start it up.

 <!-- shot(8) --> 

Then we’ll tell Android Studio to compile and run the app.

 <!-- shot(9) --> 

The app Android Studio generates out of the box is a simple tap-counter.

## Let’s update the app branding

Now that we’ve confirmed the app runs, let’s begin to customize it.

 <!-- shot(10) -->  

First we’ll update the title of the app from the operating system’s perspective, as well as the title displayed in the header.

 <!-- shot(11) -->  

Let’s customize the color while we’re at it.

 <!-- shot(12) -->  

These changes demonstrate a great feature of Flutter development: the running app live-updates with the changes we make to the code!

## Next we’ll add a list widget

 <!-- shot(13) delete value of body: -->  

Now let’s replace the boilerplate app UI with a list widget to hold our list of hungry penguins.

 <!-- shot(14) -->  

We’ll use a `ListView` widget for this.

## Then give it list items for three species of penguin

 <!-- shot(15) -->  

Then we’ll give the list view some it `ListTile` children. We add one each for three different species of penguing: Emperor, Rockhopper, and Chinstrap.

## We’ll give each penguin an attractive avatar

This looks a little plain. Let’s spruce it up with some graphics.

 <!-- shot(16) -->  

We’ve got some penguin images provided to us by the Zoo.

 <!-- shot(17) -->  

In order to have them bundled into the application, we’ll update the `pubspec.yaml` file to include the `icons` directory in the app’s list of assets.

 <!-- shot(18) -->  

Now we can give each list tile a penguin avatar in the form of a leading image.

 <!-- shot(19) -->  

One more thing: let’s add a touch more style by making the avatars circular. We do this by embedding the images inside `ClipOval` widgets.

## Next up, we’ll add some interactivity

And there we have it, the main screen of our application is already done! In the next episode, we’ll begin adding interactivity to the penguin list items. See you soon!
