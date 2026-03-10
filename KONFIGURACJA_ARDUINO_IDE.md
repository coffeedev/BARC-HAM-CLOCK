# Konfiguracja ESP32 w Arduino IDE

## Wybór płytki

W Arduino IDE wybierz odpowiednią płytkę:

- **Dla ESP32-2432S028 (z wyświetlaczem TFT)**: **Tools → Board → ESP32 Arduino → ESP32 Dev Module**
- **Dla ESP32-C3**: **Tools → Board → ESP32 Arduino → ESP32C3 Dev Module**

## Wymagane ustawienia

### Dla ESP32-2432S028 (z wyświetlaczem TFT):
1. **Board**: `ESP32 Dev Module`
2. **Upload Speed**: `921600` (lub `115200` jeśli masz problemy)
3. **CPU Frequency**: `240MHz (WiFi/BT)` ⚠️ (nie 160MHz - to ESP32, nie ESP32-C3!)
4. **Flash Size**: `4MB (32Mb)` (lub zgodnie z Twoim modułem)
5. **Partition Scheme**: `Default 4MB with spiffs (1.2MB APP/1.5MB SPIFFS)` lub `Default`
6. **Core Debug Level**: `None` (lub `Info` dla debugowania)
7. **Port**: Wybierz port COM, na którym jest podłączony ESP32

### Dla ESP32-C3:
1. **Board**: `ESP32C3 Dev Module`
2. **Upload Speed**: `921600` (lub `115200` jeśli masz problemy)
3. **CPU Frequency**: `160MHz (WiFi/BT)`
4. **Flash Size**: `4MB (32Mb)` (lub zgodnie z Twoim modułem)
5. **Partition Scheme**: `Default 4MB with spiffs (1.2MB APP/1.5MB SPIFFS)` lub `Default`
6. **Core Debug Level**: `None` (lub `Info` dla debugowania)
7. **Port**: Wybierz port COM, na którym jest podłączony ESP32-C3

## Instalacja ESP32 Board Support

Jeśli nie widzisz opcji ESP32-C3:

1. Arduino IDE → **File** → **Preferences**
2. W polu **Additional Boards Manager URLs** dodaj:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
3. **Tools** → **Board** → **Boards Manager**
4. Wyszukaj **"esp32"** (autor: esp32)
5. Zainstaluj najnowszą wersję (minimum 2.0.0, zalecane 3.0.0+)

## Sprawdzenie konfiguracji

Po wyborze płytki, upewnij się że:
- Port COM jest wykryty (Tools → Port)
- Prędkość Serial Monitor: **115200 baud**
- ESP32-C3 jest podłączony przez USB

## Alternatywne opcje płytki

W zależności od Twojego modułu, możesz też wybrać:
- **ESP32-C3-DevKitM-1** - dla oficjalnego DevKit
- **ESP32-C3 Super Mini** - dla mini wariantów
- **ESP32C3 Dev Module** - standardowy wybór (ZALECANE)

## Rozwiązywanie problemów

### ESP32-C3 nie jest wykrywany
- Sprawdź czy kabel USB obsługuje transmisję danych (nie tylko zasilanie)
- Zainstaluj sterowniki USB-to-Serial (CP2102, CH340, itp.)
- Spróbuj innego portu USB

### Błędy podczas wgrywania
- Zmniejsz **Upload Speed** do `115200`
- Przytrzymaj przycisk BOOT podczas wgrywania
- Sprawdź czy wybrałeś właściwy port COM

### Watchdog resets
- Upewnij się że wybrałeś właściwą płytkę (ESP32 Dev Module dla ESP32-2432S028, ESP32C3 Dev Module dla ESP32-C3)
- Sprawdź czy masz najnowszą wersję ESP32 Board Support

## Konfiguracja wyświetlacza TFT (ESP32-2432S028)

### 1. Instalacja biblioteki TFT_eSPI

1. Arduino IDE → **Tools** → **Manage Libraries...**
2. Wyszukaj **"TFT_eSPI"** (autor: Bodmer)
3. Zainstaluj wersję **2.5.0** lub nowszą

### 2. Konfiguracja User_Setup.h

Biblioteka TFT_eSPI wymaga pliku konfiguracyjnego `User_Setup.h`. Musisz skopiować plik `User_Setup.h` z tego projektu do folderu biblioteki:

1. Znajdź folder biblioteki TFT_eSPI:
   - Windows: `C:\Users\[TwojaNazwa]\Documents\Arduino\libraries\TFT_eSPI\`
   - Mac: `~/Documents/Arduino/libraries/TFT_eSPI/`
   - Linux: `~/Arduino/libraries/TFT_eSPI/`

2. Skopiuj plik `User_Setup.h` z tego projektu do folderu `TFT_eSPI`

3. **WAŻNE**: Jeśli w folderze `TFT_eSPI` jest już plik `User_Setup.h`, **zastąp go** plikiem z tego projektu

### 3. Włączenie wyświetlacza w kodzie

W pliku `ESP32-HAM-CLOCK.ino` na początku (około linii 15) jest linia:
```cpp
#define ENABLE_TFT_DISPLAY
```

Upewnij się, że ta linia **NIE jest zakomentowana** (nie ma `//` przed nią).

Jeśli chcesz wyłączyć wyświetlacz, zakomentuj tę linię:
```cpp
// #define ENABLE_TFT_DISPLAY
```

### 4. Sprawdzenie konfiguracji

Po wgraniu kodu, w Serial Monitor (115200 baud) powinieneś zobaczyć:
```
ENABLE_TFT_DISPLAY jest zdefiniowane - inicjalizuję TFT
=== Inicjalizacja TFT ===
TFT begin()...
TFT begin() OK
=== TFT zainicjalizowany OK ===
```

Jeśli widzisz:
```
UWAGA: ENABLE_TFT_DISPLAY NIE jest zdefiniowane - TFT nie będzie działał!
```

To znaczy, że linia `#define ENABLE_TFT_DISPLAY` jest zakomentowana lub nie istnieje.
