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
-(NSString*) executionLogString;
-(int) x;
-(int) y;
-(int) heading;
-(int) turretHeading;
-(int) desiredHeading;
-(int) armor;
-(int) heat;
-(int) kills;
-(int) deaths;
-(int) wins;
-(int) losses;
-(int) shieldOn;
-(int) overburnOn;
-(int) number_of_collisions;
-(int) odometer;
-(bool) diedLastTurn;
-(int) numberOfMissilesFired;
-(int) numberOfMissilesConnected;
-(int) numberOfMinesLayed;
-(int) numberOfMinesRemaining;
-(int) numberOfMinesConnected;
-(int) numberOfTimesHit;
-(int) timeSinceDetection;
-(bool) hasEverBeenDetected;
-(bool) isAlive;
-(bool) compiledCorrectly;
-(NSArray*) compileErrors;
-(int) numberOfCompileErrors;
-(int) numberOfCompileWarnings;
-(int) team;
-(void) setTeam:(int) newTeam;
-(id) color;
-(void) setColor:(id) color;
-(NSURL*) url;
-(int*) memory;
-(int) scan_arc_width;
-(int) speed_in_terms_of_throttle;
-(int) throttle;
-(int) speedInCM;
-(NSArray*) disassembledSourceAtAddress:(int)pc ;
-(int) config_scanner;
-(int) config_weapon;
-(int) config_armor;
-(int) config_engine;
-(int) config_heatsinks;
-(int) config_mines;
-(int) config_shield;
-(int) numberOfMinesRemaining;
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
-(bool) isWholeCircle;
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
