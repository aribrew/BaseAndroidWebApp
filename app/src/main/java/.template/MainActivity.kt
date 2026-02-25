package me.android.basewebapp

import android.annotation.SuppressLint
import android.app.Activity
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.viewinterop.AndroidView
import me.android.basewebapp.ui.theme.BaseWebAppTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            WebViewScreen ()
        }
    }


    @SuppressLint("SetJavaScriptEnabled")
    @Composable
    fun WebViewScreen () {
        AndroidView (
            factory = {
                context ->
                WebView (context).apply {
                    settings.javaScriptEnabled = true
                    settings.domStorageEnabled = true

                    webViewClient = WebViewClient ()
                    webChromeClient = WebChromeClient ()

                    addJavascriptInterface (
                        AndroidBridge (context),
                        "Android"
                    )

                    loadUrl ("file:///android_asset/webactivities/main.html")
                }
            }
        )
    }
}
