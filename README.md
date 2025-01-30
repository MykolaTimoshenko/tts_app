# tts_app

This Flutter app lets users type any text and hear it spoken out loud using either the device’s built-in text-to-speech engine or an advanced AI TTS service (ElevenLabs).
The user-friendly interface allows easy entry of text, a quick “Speak” action, and the flexibility to switch between local and cloud-based voices as needed.


# Research: Text-to-Speech Integration in Flutter

## 1. Overview

This project enables users to type text and have it spoken back, either using a **local TTS** (via `flutter_tts`) or **cloud-based** AI TTS (via **ElevenLabs**). Our objectives:

- Provide **speech functionality** in a Flutter app.
- Allow **multiple data sources** for TTS (local vs. cloud).
- Manage **user events** (speak, stop) and **UI updates** consistently.

---

## 2. Methods Researched & Selected

### 1) Local TTS (`flutter_tts`)

- **Pros:**
    - Straightforward to integrate with [`flutter_tts`](https://pub.dev/packages/flutter_tts).
    - Potential **offline** usage if the device’s OS TTS supports it.

- **Cons:**
    - Voices can be **less natural** than advanced AI solutions.
    - Dependent on the built-in OS TTS engine (may have limited language/voice support).

### 2) Cloud TTS (ElevenLabs)

- **Pros:**
    - **High-quality**, natural-sounding voices.
    - Simple **REST API** (send text, get audio bytes).

- **Cons:**
    - Requires a **network** connection.
    - The current key has **5,000 free characters** left; a new key would provide **10,000**. Beyond that, a paid plan is needed.

---

## 3. Tools and Services Used

- **Flutter**
- **`flutter_tts`**: local TTS plugin
- **ElevenLabs**: advanced AI TTS (cloud)
- **`http`**: makes REST calls to ElevenLabs
- **`audioplayers`**: plays returned audio bytes
- **BLoC (`flutter_bloc`)**: handles state and events (e.g., `SpeakRequested`, `StopRequested`)
- **`get_it`**: organizes dependencies (data sources, repository)

---

## 4. Limitations & Implementation Details

1. **Network Dependency**
    - ElevenLabs requires an **internet** connection. If offline, local TTS is used.

2. **API Keys & Costs**
    - The existing ElevenLabs key has **5,000 free characters** remaining; a new key typically comes with **10,000**.
    - Beyond the free tier, usage requires a paid plan.

3. **Local TTS Limitations**
    - The device OS TTS may yield **less natural** voices; language/voice variety can be limited.

4. **Architecture**
    - **BLoC**: Handles text changes, speak/stop events, updates `isSpeaking`.
    - **GetIt**: Registers TTS data sources (local vs. ElevenLabs) and a repository to decide which to call.
    - **`audioplayers`**: Plays raw audio bytes for cloud TTS; `flutter_tts` handles local speech output.

5. **Playback Completion**
    - **Local**: Uses `flutter_tts`’s `setCompletionHandler`.
    - **ElevenLabs**: The `audioplayers` plugin triggers `onPlayerComplete`, letting the BLoC reset `isSpeaking`.

---

## 5. Why ElevenLabs Over Google Cloud TTS or Resemble AI

1. **Superior Voice Quality**
    - ElevenLabs is renowned for **incredibly lifelike** speech output, often surpassing the expressiveness of Google Cloud TTS and Resemble AI.
    - Many developers report that ElevenLabs’ voices sound more **human and natural** compared to WaveNet voices (Google) or Resemble AI’s default options.

2. **Simple Integration & Setup**
    - ElevenLabs requires only a **single API key** and straightforward REST calls: send text, receive audio bytes.
    - Google Cloud TTS involves creating a **GCP project**, setting up billing, and dealing with service accounts.
    - Resemble AI may return a **URL** for audio instead of raw bytes, adding steps to fetch the file in a second request.

3. **Voice Cloning & Fine-Tuning**
    - ElevenLabs has robust **voice cloning** features and parameters (e.g., “stability” and “similarity_boost”) to fine-tune the reading style.
    - Google Cloud TTS doesn’t officially support direct **voice cloning**.
    - Resemble AI supports custom voices, but it is less commonly used and can be harder to get started with or compare results in the community.

4. **Clear Free Tier & Pricing**
    - ElevenLabs offers **10,000 free characters** depending on your API key, then a paid plan with predictable costs.
    - Google Cloud TTS has free usage credits, but the pricing structure can be **more complex**, and you must enable billing on Google Cloud.
    - Resemble AI also has paid tiers but does not provide as large a free allowance for experimentation.

5. **Community & Developer Support**
    - ElevenLabs has a growing developer community with tutorials and examples, making it quick to prototype and solve issues.
    - Google Cloud TTS is widely documented but geared more toward enterprise or advanced usage.
    - Resemble AI is less ubiquitous, so community support and documentation can be harder to find.

---

## 6. Conclusion

By integrating **local TTS** with **ElevenLabs**, the project supports:

- **Offline** or basic usage via local TTS,
- **High-quality** AI voices from ElevenLabs for a more engaging user experience.

**Pros**
- Flexible solution covering multiple usage scenarios (offline vs. advanced AI).
- Straightforward structure with BLoC + GetIt for clarity.

**Cons**
- Must monitor **API usage** (10,000 free characters before a paid plan).
- Slightly more complex to handle two TTS pathways.

Overall, this setup provides a robust and extensible text-to-speech solution for the app, balancing simplicity (local) with superior quality (cloud).

