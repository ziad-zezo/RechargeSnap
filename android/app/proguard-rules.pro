# ML Kit Text Recognition keep rules
-keep class com.google.mlkit.vision.text.** { *; }
-keep class com.google.mlkit.vision.text.chinese.** { *; }
-keep class com.google.mlkit.vision.text.devanagari.** { *; }
-keep class com.google.mlkit.vision.text.japanese.** { *; }
-keep class com.google.mlkit.vision.text.korean.** { *; }
-keep interface com.google.mlkit.** { *; }
-keep class com.google_mlkit_text_recognition.** { *; } # Add latin just in case, though not explicitly mentioned in your log
# Additional ML Kit general rules
-keep class com.google.mlkit.** { *; }
-keep interface com.google.mlkit.** { *; }