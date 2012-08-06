//
//  GameStateDescriptor.h
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrientableObject <NSObject>

-(int) x;
-(int) y;
-(int) heading;

@end

@protocol RobotDescription <NSObject,OrientableObject>

-(NSString*) sessionUniqueRobotIdentifier;

-(NSString*) name;
-(NSString*) descript;
-(int) linesOfCode;
-(NSString*) author;

-(int) x;
-(int) y;
-(int) heading;
-(int) armor;
-(int) heat;
-(int) kills;
-(int) deaths;
-(int) wins;
-(int) loses;
-(int) shieldOn;
-(int) overburnOn;


-(int) numberOfMissilesFired;
-(int) numberOfMissilesConnected;
-(int) numberOfMinesLayed;
-(int) numberOfMinesConnected;
-(int) numberOfTimesHit;

-(bool) isAlive;
-(bool) compiledCorrectly;
-(NSArray*) compileErrors;
-(int) numberOfCompileErrors;
-(int) numberOfCompileWarnings;
-(int) team;
-(void) setTeam:(int) newTeam;
-(NSColor*) color;
-(void) setColor:(NSColor*) color;
-(NSURL*) url;

@end


@protocol MissileDescription <NSObject,OrientableObject>
-(int) x;
-(int) y;
-(int) heading;
-(NSObject<RobotDescription>*) owner;
@end

@protocol MineDescription <NSObject>
-(int) x;
-(int) y;
-(NSObject<RobotDescription>*) owner;
@end

@protocol ScanDescription <NSObject,OrientableObject>

-(int) x;
-(int) y;
-(int) radius;
-(int) startAngle;
-(int) endAngle;
-(NSObject<RobotDescription>*) owner;
@end

@protocol ExplosionDescription <NSObject,OrientableObject>

-(int) x;
-(int) y;
-(int) radius;

@end




@protocol GameStateDescriptor <NSObject>
-(int) currentMatch;
-(int) totalNumberOfMatches;
-(int) gameCycle;
-(int) maxGameCycles;
-(NSArray*) mines;
-(NSArray*) robots;
-(NSArray*) missiles;
-(NSArray*) scans;
-(NSArray*) explosions;
-(NSArray*) soundEffectsInitiatedThisCycle;
-(bool) isMatchCurrentlyActive;
-(NSSet*) winnersOfLastMatch;
-(bool) isSetOfMatchesCompleted;
@end
