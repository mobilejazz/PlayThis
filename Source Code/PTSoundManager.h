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
 * Main interface for sound playback.
 * This class has a simple interface to play, loop and stop sounds and check if a sound is being played or looped.
 * Multiple sounds can be played at once. However one same sound cannot be played multple times at once.
 **/
@interface PTSoundManager : NSObject

/**
 * Registers a sound file path for a key;
 * @param filePath The sound file path.
 * @param key The sound key.
 **/
- (void)registerFilePath:(NSString*)filePath forKey:(NSString*)key;

/**
 * Registers a set of sound files.
 * @param dictionary The dictionary of sound file paths and keys.
 **/
- (void)registerFilePathsForKeys:(NSDictionary <NSString*, NSString*> *)dictionary;

/**
 * Calling this method preloads buffers and acquires the audio hardware needed for playback, 
 * which minimizes the lag between calling the play method and the start of sound output.
 **/
- (void)prepareAllSounds;

/**
 * Calling this method preloads buffers and acquires the audio hardware needed for playback,
 * which minimizes the lag between calling the play method and the start of sound output.
 * @param keys An array of sound keys.
 **/
- (void)prepareSoundsWithKeys:(NSArray <NSString*> *)keys;

/**
 * Plays a sound if not being already played.
 * @param key The sound key to be played.
 * @return YES if the sound could be played, NO otherwise.
 **/
- (BOOL)playSound:(NSString*)key;

/**
 * Plays and loop a sound if not being already looped.
 * @param key The sound key to be looped.
 * @return YES if the sound could be played, NO otherwise.
 **/
- (BOOL)loopSound:(NSString*)key;

/**
 * Stops a sound.
 * @param key The sound key to be stopped.
 **/
- (void)stopSound:(NSString*)key;

/**
 * Checks if a sound is being played.
 * @param key The sound key to check.
 * @return YES if the sound is being played, NO otherwise.
 **/
- (BOOL)isPlayingSound:(NSString*)key;

/**
 * Checks if a sound is being looped.
 * @param key The sound key to check.
 * @return YES if the sound is being looped, NO otherwise.
 **/
- (BOOL)isLoopingSound:(NSString*)key;

@end
