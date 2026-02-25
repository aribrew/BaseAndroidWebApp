# [WIP] Base Android Web Application

Because you cannot create an Android application using the terminal,
i decided to create this project.

This is a basic Android application, created with Android Studio.
The point with this project is the .template folders and the init.sh script.

Using these, you can initialize the project with your own project name and
package, and all the needed files will be patched, and the package directory
structure created.

This one is only for Kotlin apps, but the idea is creating one for native
apps too.

This template uses a WebView for the UI part.

This allow using HTML+CSS for the UI, something i find more comfortable
than battling with Android.

You can do things in the Android side exporting functions to JavaScript using
the AndroidBridge.kt.

This way you can do things as show a native Dialog or obtain info from your
Android device.

