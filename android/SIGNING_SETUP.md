# Android build.gradle Signing Configuration

Add this to `android/app/build.gradle` to enable release signing:

## 1. Add this BEFORE the `android {` block:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

## 2. Add this INSIDE the `android {` block (after `defaultConfig {}`):

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
    }
}
```

## 3. Optional: Add to `android/gradle.properties` for better performance:

```properties
org.gradle.jvmargs=-Xmx2048m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.configureondemand=true
```

## Full example of android/app/build.gradle structure:

```gradle
// Load keystore properties
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    compileSdkVersion flutter.compileSdkVersion
    ndkVersion flutter.ndkVersion

    defaultConfig {
        applicationId "com.example.cursed_minesweeper"
        minSdkVersion 21
        targetSdkVersion flutter.targetSdkVersion
        versionCode 1
        versionName "1.0.0"
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```
