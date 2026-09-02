# Firebase Emulator Data

This folder holds the sample dataset used to seed the Firebase emulators.

## Usage

### 1. Convert the sample data to emulator format

To convert `data/example_scheme.json` into the Firebase emulator format:

```bash
# Using the project script shortcut
rps emulatorImport

# Or directly with Node.js
node scripts/import_example_data.js
```

This writes the data into `emulator-data/` in the layout the Firebase emulators expect.

### 2. Start the emulators

Once the data has been imported:

```bash
# Using the project script shortcut
rps emulator

# Or directly with the Firebase CLI
firebase emulators:start --import=./emulator-data --export-on-exit=./emulator-data
```

> `emulatorImport` and `emulator` are `pubspec.yaml` `scripts:` entries, run by
> [`rps`](https://pub.dev/packages/rps) — install it with `dart pub global activate rps`.

### 3. Full workflow

```bash
# 1. Import the sample data
rps emulatorImport

# 2. Start the emulators (the data loads automatically)
rps emulator

# 3. Changes are saved automatically when the emulator shuts down
```

## Data structure

`example_scheme.json` contains the following collections:

- `approvedAdvertise` — approved business listings
- `touristicPlaces` — tourist attractions
- `adBoard` — advertisement board
- `regionalCities` — regional cities
- `regionalTowns` — regional districts
- `adminList` — admin accounts
- `approvedCampaigns` — approved campaigns
- `unApprovedCampaigns` — campaigns awaiting approval
- `specialAgency` — special agencies
- `news` — news articles
- `memories` — historical memory archive
- `towns` — districts
- `allowedAdminClaims` — permitted admin claims
- `approvedApplications` — approved submissions
- `unApprovedApplications` — submissions awaiting approval
- `notifications` — notifications
- `developers` — contributor information
- `logs` — log records
- `categories` — categories
- `scholarship` — scholarships
- `chainStores` — chain stores
- `usefulLinks` — useful links

## Data format

The Firebase emulators use the Firestore export format:

```
emulator-data/
  firestore_export/
    all_namespaces/
      all_kinds/
        <collection_name>/
          <document_id>.json
```

Each JSON file must be a valid Firestore document.

## Notes

- `--import=./emulator-data` loads the data when the emulator starts
- `--export-on-exit=./emulator-data` writes changes back when it shuts down
- To add new data, edit `example_scheme.json` and import again
- To reset, delete the `emulator-data/` folder

## Troubleshooting

### The data is not imported

1. Make sure Node.js is installed: `node --version`
2. Make sure the script is executable: `chmod +x scripts/import_example_data.js`
3. Make sure `data/example_scheme.json` is valid JSON

### The emulator does not see the data

1. Make sure the `emulator-data/` folder exists
2. Check that `importOnStart` is set correctly in `firebase.json`
3. Fully stop the emulator and start it again
