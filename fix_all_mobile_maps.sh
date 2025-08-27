#!/bin/bash

# Script to fix mobile map visibility in all HTML files

echo "Fixing mobile map visibility in all HTML files..."

# List of all HTML files to fix
files=(
    "index.html"
    "day1_thursday_aug28.html"
    "day2_friday_aug29.html"
    "day3_saturday_aug30.html"
    "day4_sunday_aug31.html"
    "day5_monday_sep01.html"
    "day6_tuesday_sep02.html"
    "day7_wednesday_sep03.html"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Fix 1: Update viewport meta tag
        sed -i.bak 's/<meta name="viewport" content="width=device-width, initial-scale=1.0">/<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">/' "$file"
        
        # Fix 2: Add integrity and crossorigin to Leaflet CSS
        sed -i.bak 's|<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />|<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="anonymous" />|' "$file"
        
        # Fix 3: Add integrity and crossorigin to Leaflet JS
        sed -i.bak 's|<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>|<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin="anonymous"></script>|' "$file"
        
        echo "✓ Fixed $file"
    else
        echo "⚠ File not found: $file"
    fi
done

# Clean up backup files
rm -f *.bak

echo "✅ All files have been updated for mobile compatibility!"
echo ""
echo "Key fixes applied:"
echo "1. Updated viewport meta tag for better mobile scaling"
echo "2. Added integrity checks to Leaflet resources"
echo "3. Added crossorigin attributes for security"
echo ""
echo "Additional manual fix needed:"
echo "Add map.invalidateSize() after map initialization in each file's JavaScript"