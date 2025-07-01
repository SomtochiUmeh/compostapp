#!/bin/bash

# Fix coverage ignore comments in generated intl files

FILES=(
  "lib/generated/intl/messages_ar.dart"
  "lib/generated/intl/messages_fr.dart"
)

for file in "${FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "File not found: $file"
    continue
  fi

  # Check if coverage:ignore-start already exists
  if grep -q "// coverage:ignore-start" "$file"; then
    echo "Coverage ignore already exists in $file"
    continue
  fi

  # Create a temporary file
  temp_file=$(mktemp)
  
  # Add coverage:ignore-start after the header comments and before imports
  awk '
    BEGIN { added_start = 0 }
    /^import / && !added_start {
      print "// coverage:ignore-start"
      print ""
      added_start = 1
    }
    { print }
    END {
      if (added_start) {
        print "// coverage:ignore-end"
      }
    }
  ' "$file" > "$temp_file"
  
  # Replace the original file
  mv "$temp_file" "$file"
  echo "Added coverage:ignore to $file"
done