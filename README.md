# Focus Detective

Focus Detective is a simple app designed to help you track which app has focus.
This can be helpful if the app you're using sometimes loses focus unexpectedly.
For example, you may find that you can no longer type or use keyboard shortcuts
until you click on the app again. You may also notice that the app window no
longer appears active—for example the title and toolbar buttons are be shown in
a lighter color.

This app was inspired by
[this MacRumors post](https://forums.macrumors.com/threads/2321723/),
[this other MacRumors post](https://forums.macrumors.com/threads/2406058/) and
[this Ask Different post](https://apple.stackexchange.com/q/123730/7610). While
they each offer helpful suggestions for tracking down the problem, I wasn't
quite happy with any of them.

## Features

 - Ready to download and run. It's sandboxed, signed, and notarized.
 - Full source code available if you'd prefer to build it yourself.
 - Doesn't rely on Python or other tools.
 - Compatible with macOS 14 or later.

## How to Use

1. Launch Focus Detective. You can close the window or hide the application
   while it's running.
2. Optional: Open Console, select your device in the sidebar, and click the
   "Start streaming" button.
3. Use your computer normally until the problem occurs.
4. When the problem occurs, return to Focus Detective and check the entries at
   the top of the list. Look for anything you didn't open yourself. One common
   cause of this problem is "CoreServicesUIAgent."
5. Optional: Return to Console and search for the app that activated. For
   example, I was able to look at the logs for CoreServicesUIAgent and see some
   information about what might have cause it to activate. In my case, it was
   an app I had installed via TestFlight. This seems to be a common cause
   without a clear solution (other than removing TestFlight) but at least you
   now have more information and can file a bug report!

