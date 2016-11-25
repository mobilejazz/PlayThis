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

#import "PTSoundManager.h"
#import "PTSoundEngine.h"

#import <AVFoundation/AVFoundation.h>

@implementation PTSoundManager
{
    // Dictionary of sound file paths.
    NSMutableDictionary <NSString*, NSString*> *_soundFilePaths;
    
    // Dictionary of sound engines keyed by its sound.
    NSMutableDictionary *_soundEngines;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _soundEngines = [NSMutableDictionary dictionary];
        _soundFilePaths = [NSMutableDictionary dictionary];
        
        NSError *error = nil;
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&error];
        
        if (error)
        {
            NSLog(@"AVAudioSession Error: %@", error.description);
        }
    }
    return self;
}

#pragma mark Public Methods

- (void)registerFilePath:(NSString*)filePath forKey:(NSString*)key;
{
    if (_soundFilePaths[key] != nil)
    {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:[NSString stringWithFormat:@"There is a sound file path already registered for the key <%@>", key]
                               userInfo:nil] raise];
    }
    _soundFilePaths[key] = filePath;
}

- (void)registerFilePathsForKeys:(NSDictionary <NSString*, NSString*> *)dictionary
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull filePath, BOOL * _Nonnull stop) {
        [self registerFilePath:filePath forKey:key];
    }];
}

- (void)prepareAllSounds
{
    [_soundFilePaths enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull filePath, BOOL * _Nonnull stop) {
        PTSoundEngine *soundEngine = _soundEngines[key];
        
        if (!soundEngine)
        {
            soundEngine = [PTSoundEngine soundEngineWithContentsOfFile:filePath];
            if (soundEngine)
                _soundEngines[key] = soundEngine;
        }
    }];
}

- (void)prepareSoundsWithKeys:(NSArray <NSString*> *)keys
{
    [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        PTSoundEngine *soundEngine = _soundEngines[key];
        
        if (!soundEngine)
        {
            soundEngine = [PTSoundEngine soundEngineWithContentsOfFile:_soundFilePaths[key]];
            if (soundEngine)
                _soundEngines[key] = soundEngine;
        }
    }];
}

- (BOOL)playSound:(NSString*)key
{
    if (key == nil || _soundFilePaths[key] == nil)
        return NO;
    
    PTSoundEngine *soundEngine = _soundEngines[key];
    
    if (!soundEngine)
    {
        soundEngine = [PTSoundEngine soundEngineWithContentsOfFile:_soundFilePaths[key]];
        if (!soundEngine)
            return NO;
        
        _soundEngines[key] = soundEngine;
    }
    
    if (!soundEngine.isPlaying)
        return [soundEngine play];
    
    return YES;
}

- (BOOL)loopSound:(NSString*)key
{
    if (key == nil || _soundFilePaths[key] == nil)
        return NO;
    
    PTSoundEngine *soundEngine = _soundEngines[key];
    
    if (!soundEngine)
    {
        soundEngine = [PTSoundEngine soundEngineWithContentsOfFile:_soundFilePaths[key]];
        if (!soundEngine)
            return NO;
        
        _soundEngines[key] = soundEngine;
    }
    
    BOOL succeed = NO;
    
    if (!soundEngine.isPlaying || !soundEngine.isLooping)
        succeed = [soundEngine loop];
    
    return succeed;
}

- (void)stopSound:(NSString*)key
{
    PTSoundEngine *soundEngine = _soundEngines[key];
    [soundEngine stop];
}

- (BOOL)isPlayingSound:(NSString*)key
{
    PTSoundEngine *soundEngine = _soundEngines[key];
    
    if (soundEngine)
        return soundEngine.isPlaying;
    
    return NO;
}

- (BOOL)isLoopingSound:(NSString*)key
{
    PTSoundEngine *soundEngine = _soundEngines[key];
    
    if (soundEngine)
        return soundEngine.isPlaying && soundEngine.isLooping;
    
    return NO;
}

#pragma mark Private Methods

- (BOOL)mjz_isLooping
{
    NSArray *soundEngines = _soundEngines.allValues;
    for (PTSoundEngine *soundEngine in soundEngines)
    {
        if (soundEngine.isLooping && soundEngine.isPlaying)
            return YES;
    }
    
    return NO;
}

@end
