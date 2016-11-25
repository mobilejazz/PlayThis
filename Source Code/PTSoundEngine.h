//
// Copyright 2016 Mobile Jazz SL
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <Foundation/Foundation.h>

/**
 * Sound player.
 **/
@interface PTSoundEngine : NSObject

/**
 * Static default initializer.
 * @param path The path of the play to play.
 * @return An instance of PTSoundEngine ready to play the sound or nil if the sound file couldn't be retrieved or was not compatible.
 **/
+ (PTSoundEngine*)soundEngineWithContentsOfFile:(NSString*)path;

/**
 * Default initializer.
 * @param path The path of the play to play.
 * @return The initialized instance of PTSoundEngine ready to play the sound or nil if the sound file couldn't be retrieved or was not compatible.
 **/
- (instancetype)initWithContentsOfFile:(NSString*)path;

/**
 * Starts the playback of the sound.
 * @return YES if could initialize the playback, NO otherwise.
 **/
- (BOOL)play;

/**
 * Starts the playback of the sound and loops the playback.
 * @return YES if could initialize the playback, NO otherwise.
 **/
- (BOOL)loop;

/**
 * Stops the playback of the sound.
 **/
- (void)stop;

/**
 * Mute the playback of the sound.
 **/
@property (nonatomic, assign, getter = isMuted) BOOL muted;

/**
 * YES if the sound is being played, NO otherwise.
 **/
@property (nonatomic, assign, readonly, getter = isPlaying) BOOL playing;

/**
 * YES if the sound is being looped, NO otherwise.
 **/
@property (nonatomic, assign, readonly, getter = isLooping) BOOL looping;

/**
 * The filePath containing the sound to be played.
 **/
@property (nonatomic, strong, readonly) NSString *filePath;

/**
 * This block is called every time the sound will begin playing.
 **/
@property (nonatomic, strong) void (^soundWillBeginPlayingBlock)();

/**
 * This block is called every time the sound did finish playing.
 **/
@property (nonatomic, strong) void (^soundDidFinishPlayingBlock)();

@end
