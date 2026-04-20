Here is the **English translation** of your file:

---

# ESP32 Configuration in Arduino IDE 

## Board Selection

In Arduino IDE, choose the appropriate board:

* **For ESP32-2432S028 (with TFT display):**
  **Tools → Board → ESP32 Arduino → ESP32 Dev Module**
* **For ESP32-C3:**
  **Tools → Board → ESP32 Arduino → ESP32C3 Dev Module**

---

## Required Settings

### For ESP32-2432S028 (with TFT display):

1. **Board:** `ESP32 Dev Module`
2. **Upload Speed:** `921600` (or `115200` if you have issues)
3. **CPU Frequency:** `240MHz (WiFi/BT)` ⚠️ (not 160MHz — that’s for ESP32-C3!)
4. **Flash Size:** `4MB (32Mb)` (or according to your module)
5. **Partition Scheme:** `Default 4MB with spiffs (1.2MB APP/1.5MB SPIFFS)` or `Default`
6. **Core Debug Level:** `None` (or `Info` for debugging)
7. **Port:** Select the COM port where ESP32 is connected

### For ESP32-C3:

1. **Board:** `ESP32C3 Dev Module`
2. **Upload Speed:** `921600` (or `115200` if you have issues)
3. **CPU Frequency:** `160MHz (WiFi/BT)`
4. **Flash Size:** `4MB (32Mb)` (or according to your module)
5. **Partition Scheme:** `Default 4MB with spiffs (1.2MB APP/1.5MB SPIFFS)` or `Default`
6. **Core Debug Level:** `None` (or `Info` for debugging)
7. **Port:** Select the COM port where ESP32-C3 is connected

---

## Installing ESP32 Board Support

If you don’t see the ESP32-C3 option:

1. Arduino IDE → **File** → **Preferences**
2. In **Additional Boards Manager URLs**, add:

   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
3. Go to **Tools → Board → Boards Manager**
4. Search for **"esp32"** (author: esp32)
5. Install the latest version (minimum 2.0.0, recommended 3.0.0+)

---

## Checking Configuration

After selecting the board, make sure:

* COM port is detected (Tools → Port)
* Serial Monitor speed: **115200 baud**
* ESP32-C3 is connected via USB

---

## Alternative Board Options

Depending on your module, you can also choose:

* **ESP32-C3-DevKitM-1** – official DevKit
* **ESP32-C3 Super Mini** – mini variants
* **ESP32C3 Dev Module** – standard choice (RECOMMENDED)

---

## Troubleshooting

### ESP32-C3 not detected

* Check if USB cable supports data (not just power)
* Install USB-to-Serial drivers (CP2102, CH340, etc.)
* Try a different USB port

### Upload errors

* Reduce **Upload Speed** to `115200`
* Hold the BOOT button during upload
* Check if the correct COM port is selected

### Watchdog resets

* Ensure correct board is selected

  * ESP32 Dev Module (ESP32-2432S028)
  * ESP32C3 Dev Module (ESP32-C3)
* Update ESP32 Board Support to latest version

---

## TFT Display Configuration (ESP32-2432S028)

### 1. Installing TFT_eSPI Library

1. Arduino IDE → **Tools → Manage Libraries...**
2. Search for **"TFT_eSPI"** (author: Bodmer)
3. Install version **2.5.0** or newer

---

### 2. Configuring User_Setup.h

The TFT_eSPI library requires a config file `User_Setup.h`. You must copy it from this project into the library folder:

1. Locate the TFT_eSPI library folder:

   * Windows: `C:\Users\[YourName]\Documents\Arduino\libraries\TFT_eSPI\`
   * Mac: `~/Documents/Arduino/libraries/TFT_eSPI/`
   * Linux: `~/Arduino/libraries/TFT_eSPI/`

2. Copy `User_Setup.h` from this project into the `TFT_eSPI` folder

3. **IMPORTANT:** If a `User_Setup.h` file already exists there, **replace it**

---

### 3. Enabling the Display in Code

In `ESP32-HAM-CLOCK.ino`, near the top (around line 15):

```cpp
#define ENABLE_TFT_DISPLAY
```

Make sure this line is **NOT commented out** (no `//` before it).

To disable the display, comment it out:

```cpp
// #define ENABLE_TFT_DISPLAY
```

---

### 4. Verifying Configuration

After uploading the code, in Serial Monitor (115200 baud), you should see:

```
ENABLE_TFT_DISPLAY is defined - initializing TFT
=== TFT Initialization ===
TFT begin()...
TFT begin() OK
=== TFT initialized successfully ===
```

If you see:

```
WARNING: ENABLE_TFT_DISPLAY is NOT defined - TFT will not work!
```

That means the line `#define ENABLE_TFT_DISPLAY` is commented out or missing.

---

If you want, I can also clean this up into a polished README or simplify it for quick setup—you’ve got a lot of moving parts here, and a tighter version can save you time when you revisit this later.
