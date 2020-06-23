//
//  SHCollection.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHCollection_h
#define SHCollection_h

#include <stdio.h>
#include <inttypes.h>

struct SHCollection;

struct SHCollectionIterator {
	void *backend;
	struct SHCollection *collection;
};



struct SHCollection {
	void *backend;
	uint64_t (*count)(struct SHCollection *);
	void *(*getItemAtIdx)(struct SHCollection *, uint64_t);
	void (*addItem)(struct SHCollection *, void *);
	void (*deleteItemAtIdx)(struct SHCollection *, uint64_t);
	struct SHCollectionIterator *(*iteratorInit)(struct SHCollection *);
	void *(*iteratorNext)(struct SHCollectionIterator **);
	void (*backendCleanup)(void**);
};


struct SHCollection *SH_collection_initAsTree(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*));
uint64_t SH_collection_count(struct SHCollection *collection);
void SH_collection_addItem(struct SHCollection *collection, void *item);
void *SH_collection_getItemAtIdx(struct SHCollection *collection, uint64_t idx);
void SH_collection_deleteItemAtIdx(struct SHCollection *collection, uint64_t idx);
struct SHCollectionIterator *SH_collectionIterator_init(struct SHCollection *collection);
void *SH_collectionIterator_next(struct SHCollectionIterator **iter);

void SH_collection_cleanup(struct SHCollection **collection);
void SH_collection_cleanup2(void **args);

#endif /* SHCollection_h */
