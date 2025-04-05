# CompostApp

CompostApp is a mobile application that helps farmers and small composting businesses create effective compost mixes using locally available waste materials. It addresses significant agricultural challenges in regions like Burkina Faso by turning agricultural waste into valuable soil amendments while reducing environmental problems.

## Project Background

Agricultural processing in regions like Burkina Faso generates substantial waste, particularly from mango and cashew production (up to 60,000 tonnes each annually). This waste creates environmental problems while also representing an untapped resource for soil improvement.

With fertilizer prices doubling due to global factors, composting has become an increasingly important alternative for maintaining soil fertility. CompostApp helps users create balanced compost with the right nutrient proportions using available waste materials.

## Handover Guide for NGO Users

This section provides essential guidance for non-technical users who need to maintain and update the app after the initial development phase.

### Modifying Educational Content

CompostApp contains educational content that you may need to update periodically based on new research or regional requirements. Here's how to modify this content:

#### Text Content Updates

1. **Locate the text files**: All text content is stored in the `lib/l10n` directory in `.arb` files:
   - `intl_en.arb` - English text
   - `intl_fr.arb` - French text
   - `intl_ar.arb` - Arabic text

2. **Edit the files**: Open these files with any text editor (like Notepad, TextEdit, or Visual Studio Code). The format looks like this:
   ```json
   "componentCassavaPeels": "Cassava peels",
   "@componentCassavaPeels": {
       "description": "Name of cassava peels component"
   },
   ```

3. **Make your changes**: 
   - Edit the text inside the quotation marks after the key (e.g., "Cassava peels")
   - Do not change the keys (the text before the colon, e.g., "componentCassavaPeels")
   - The description field helps translators understand the context of the text
   - Make sure to maintain the JSON format with proper commas and brackets

4. **Save the files**: Save the changes and proceed to building an update.

#### Modifying Compost Guidelines

The educational content in the guidelines section is defined in:
- `lib/screens/guideline_detail_page.dart`

To update this content:
1. Open the file in a text editor
2. Locate the relevant method (e.g., `_buildAerobicCompostingContent()` or `_buildTroubleshootingContent()`)
3. Update the text strings within these methods
4. Save your changes

#### Adding New Compost Components

To add new compost ingredients to the database:
1. Open `lib/data/compost_components_data.dart`
2. Add a new `CompostComponent` entry to the list, following the existing pattern
3. Include all required nutrient information
4. Add corresponding translation keys to the `.arb` files, following this format:
   ```json
   "componentNewIngredient": "New Ingredient Name",
   "@componentNewIngredient": {
       "description": "Description of the new ingredient"
   },
   ```

### Building and Deploying Updates

Once you've made your content changes, you'll need to build and distribute the updated app. Here's a simplified process:

#### Prerequisites

1. **Install Flutter**: If not already installed, follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install)
2. **Install Visual Studio Code**: Download from [code.visualstudio.com](https://code.visualstudio.com/download)
3. **Install Git**: Download from [git-scm.com](https://git-scm.com/downloads)

#### Building the App

1. **Get the code**:
   ```
   git clone https://github.com/SomtochiUmeh/compostapp.git
   cd compostapp
   ```

2. **Install dependencies**:
   ```
   flutter clean
   flutter pub get
   ```

3. **Build the APK** (for Android):
   ```
   flutter build apk
   ```
   The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`

#### Distributing the Update

For regions with limited connectivity, distribute updates using:

1. **Direct APK sharing**: Send the APK file directly to extension officers via:
   - Email
   - WhatsApp
   - USB drives

2. **Local distribution networks**: Work with field officers to distribute the app during training sessions or farm visits

#### Training Extension Officers

When distributing updates, provide a simple guide explaining:
- What has changed in the new version
- How to install the update
- Any new features or content

## Key Features

- **Recipe Builder**: Create custom compost recipes by selecting local ingredients and specifying quantities
- **Nutrient Analysis**: Automatically calculate nutrient content with visual feedback about key parameters
- **Price Tracking**: Update costs of different ingredients and track seasonal availability
- **Educational Content**: Comprehensive guidelines on composting processes, techniques, and troubleshooting
- **Sample Recipes**: Pre-configured compost formulas for common situations and needs
- **Offline Operation**: Works without internet connection, essential for remote agricultural areas
- **Multiple Languages**: Supports English, French, and Arabic

## Technical Overview

CompostApp is built with Flutter, making it available on both Android and iOS devices. The app uses a clean architecture approach with:

- Models for data structures (compost components, recipes, nutrient content)
- Services for business logic and persistence
- Screens for user interface
- Widgets for reusable UI components

All data is stored locally on the device using SharedPreferences, making the app fully functional without internet connectivity.

## Using the App

### Recipe Builder
1. Select ingredients from locally available materials
2. Specify quantities for each ingredient
3. View real-time analysis of the nutrient content
4. The app will highlight when key parameters like the carbon-to-nitrogen ratio fall within the ideal range

### Price Management
1. Update costs of different ingredients
2. Set seasonal availability periods for materials
3. Track and optimize costs for your compost production

### Educational Resources
1. Learn about the four stages of aerobic composting
2. Follow step-by-step instructions for creating compost
3. Understand the importance of the carbon-to-nitrogen ratio
4. Get solutions for common composting problems

## Project Structure

```
lib/
├── compost_state.dart           # Global state management
├── constants/                   # App-wide constants
├── data/                        # Data sources
├── generated/                   # Internationalization
├── l10n/                        # Localization resources
├── main.dart                    # Application entry point
├── models/                      # Data models
├── screens/                     # UI screens
├── services/                    # Business logic
└── widgets/                     # Reusable UI components
```

## Getting Started

### Prerequisites
- Flutter SDK
- Android Studio or VS Code with Flutter extensions
- An Android or iOS device/emulator

### Installation
1. Clone the repository
   ```
   git clone https://github.com/SomtochiUmeh/compostapp.git
   ```
2. Navigate to the project directory
   ```
   cd compostapp
   ```
3. Get dependencies
   ```
   flutter clean
   flutter pub get
   ```
4. Run the app
   ```
   flutter run
   ```

## Testing

The app includes comprehensive tests for all components. Run the tests with:

```
flutter test
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

- Developed to support agricultural initiatives in Burkina Faso
- Inspired by GIZ Compost Project research on turning agricultural waste into valuable soil amendments
- Created to address rising fertilizer costs and environmental challenges

## Quick Demo

https://github.com/user-attachments/assets/d4da7036-4443-402c-888d-3468c39ae5b4

### With Localization

https://github.com/user-attachments/assets/7acfef3c-14b9-48e7-a42a-bf06e9a40532