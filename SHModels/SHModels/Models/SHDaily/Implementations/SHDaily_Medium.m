//
//	SHDaily_Medium.m
//	SHModels
//
//	Created by Joel Pridgen on 3/26/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDaily_Medium.h"

@interface SHDaily_Medium()
@property (strong,nonatomic) NSObject<SHDataProviderProtocol> *dataController;
@end

@implementation SHDaily_Medium

+(instancetype)newWithContext:(NSManagedObjectContext *)context{
	SHDaily_Medium *instance = [SHDaily_Medium new];
	instance.context = context;
	return instance;
}


-(NSArray<NSSortDescriptor *> *)buildFetchDescriptors{

	NSSortDescriptor *sortByLastActivation = [[NSSortDescriptor alloc]
		initWithKey:@"lastActivationDateTime" ascending:YES];
		
	NSSortDescriptor *sortByUserOrder = [[NSSortDescriptor alloc]
		initWithKey:@"customUserOrder" ascending:NO];
		
	NSSortDescriptor *sortByUrgency = [[NSSortDescriptor alloc]
		initWithKey:@"urgency" ascending:NO];

	NSSortDescriptor *sortByDifficulty = [[NSSortDescriptor alloc]
		initWithKey:@"difficulty" ascending:YES];
	return @[sortByLastActivation, sortByUserOrder, sortByUrgency, sortByDifficulty
	];
}


-(NSFetchedResultsController *)dailiesDataFetcher{
	NSPredicate *filter = [NSPredicate predicateWithFormat:@"isEnabled == 1"];
	NSFetchRequest<SHDaily*> *request = SHDaily.fetchRequest;
	request.predicate = filter;
	request.sortDescriptors = [self buildFetchDescriptors];
	NSFetchedResultsController *resultsController = [self.context getItemFetcher:request
		withSectionKeyPath:@"isCompleted"];
	return resultsController;
}


@end
