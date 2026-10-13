package `in`.agentfolio.app

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

// A FragmentActivity, which the biometric prompt (local_auth) needs.
class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Keep portfolios out of the recent-apps thumbnail (Android 13+).
        // Unlike FLAG_SECURE, screenshots still work for the user.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            setRecentsScreenshotEnabled(false)
        }
    }
}
