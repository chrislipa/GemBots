//
//  GameStateDescriptor.h
//  engine_javascript_bridge
//
//  Created by Christopher Lipa on 7/29/12.
//  Copyright (c) 2012 Christopher Lipa. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol RobotDescription <NSObject>

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
-(NSURL*) url;
@end


@protocol MissileDescription <NSObject>
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

@protocol ScanDescription <NSObject>

-(int) centerX;
-(int) centerY;
-(int) radius;
-(int) startAngle;
-(int) endAngle;
-(NSObject<RobotDescription>*) owner;
@end

@protocol ExplosionDescription <NSObject>

-(int) x;
-(int) y;
-(int) radius;

@end




@protocol GameStateDescriptor <NSObject>
-(int) currentMatch;
-(int) totalNumberOfMatches;
-(int) gameCycle;
-(int) maxGameCycles;
-(NSArray*) robots;
-(NSArray*) missiles;
-(NSArray*) scans;
-(NSArray*) explosions;
-(NSArray*) soundEffectsInitiatedThisCycle;
-(bool) isMatchCurrentlyActive;
-(NSSet*) winnersOfLastMatch;
-(bool) isSetOfMatchesCompleted;
@end
