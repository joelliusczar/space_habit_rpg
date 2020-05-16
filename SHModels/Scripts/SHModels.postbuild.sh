#!/bin/sh

# SHModels.sh
#
#
# Created by Joel Gillette on 4/26
#

cd "$SRCROOT"/../Build_Scripts
. SHMaster.sh

cp "$DERIVED_FILE_DIR"/CoreDataGenerated/Model/*.h "$BUILT_PRODUCTS_DIR"/SHModels.framework/Headers

echo "Derived file dir: $DERIVED_FILE_DIR"
echo "" > "$SRCROOT"/../modelsReference.txt

for file in "$DERIVED_FILE_DIR"/CoreDataGenerated/Model/*; do
	echo "$file" >> "$SRCROOT"/../modelsReference.txt
	cat "$file" >> "$SRCROOT"/../modelsReference.txt
done;

echo "SHModels"
