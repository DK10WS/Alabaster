import queue
import threading
import time

import numpy as np
import sounddevice as sd
import speech_recognition as sr

r = sr.Recognizer()
q = queue.Queue()

# Callback: put audio in queue


def audio_callback(indata, frames, time_info, status):
    if status:
        print(status)
    q.put(indata.copy())


# Thread: process buffered audio every 3 seconds


def recognize_loop():
    buffer = []
    buffer_duration = 3  # seconds
    sample_rate = 44100
    chunk_size = 1024  # matches InputStream default

    while True:
        try:
            data = q.get(timeout=1)
            buffer.append(data)
        except queue.Empty:
            continue

        # calculate duration of buffered audio
        num_samples = sum(len(chunk) for chunk in buffer)
        if num_samples >= buffer_duration * sample_rate:
            # merge all chunks
            audio_np = np.concatenate(buffer)
            buffer = []  # reset buffer

            # convert to bytes
            audio_data = sr.AudioData(audio_np.tobytes(), sample_rate, 2)
            try:
                text = r.recognize_google(audio_data)
                print("You said:", text)
            except sr.UnknownValueError:
                pass
            except sr.RequestError as e:
                print("API Error:", e)


# Start recognition thread
thread = threading.Thread(target=recognize_loop, daemon=True)
thread.start()

# Start microphone stream
with sd.InputStream(
    callback=audio_callback, channels=1, samplerate=44100, dtype="int16"
):
    print("Speak now! Press Ctrl+C to stop")
    try:
        while True:
            time.sleep(0.1)
    except KeyboardInterrupt:
        print("Stopping...")

print("Done")
