package me.android.basewebapp

import android.app.Activity
import android.content.Context
import android.app.AlertDialog
import android.webkit.JavascriptInterface
import android.widget.Toast


@Suppress("unused")
class AndroidBridge (private val context: Context) {
    // These are just some example functions you can call from JavaScript
    @JavascriptInterface
    fun showMessage (message: String) {
        showMessage (message, "Alert")
    }
    

    @JavascriptInterface
    fun showMessage (message: String, title: String = "Alert") {
        (context as Activity).runOnUiThread {
            val dialogBuilder = AlertDialog.Builder (context)
            dialogBuilder.setTitle (title)
            dialogBuilder.setMessage (message)
            dialogBuilder.show ()	
        }
    }


    @JavascriptInterface
    fun showToast (message: String) {
        Toast.makeText (
            context,
            message,
            Toast.LENGTH_SHORT
        ).show()
    }
}
