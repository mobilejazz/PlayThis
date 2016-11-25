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

#import "PTSoundEngine.h"

#define USE_AVFOUNDATION 1

#import <AVFoundation/AVFoundation.h>

@interface PTSoundEngine () <AVAudioPlayerDelegate>

@end

@implementation PTSoundEngine
{
    AVAudioPlayer *_audioPlayer;
}

+ (PTSoundEngine*)soundEngineWithContentsOfFile:(NSString*)path
{
    if (path)
    {
        return [[PTSoundEngine alloc] initWithContentsOfFile:path];
    }
    return nil;
}

- (id)initWithContentsOfFile:(NSString*)path
{
    self = [super init];
    
    if (self)
    {
        _filePath = path;
        
        NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL fileTypeHint:AVFileTypeWAVE error:&error];
        _audioPlayer.delegate = self;
        
        if (error)
        {
            NSLog(@"Error %@ loading sound at path: %@", error, path);
            return nil;
        }
        else
        {
            [_audioPlayer prepareToPlay];
        }
    }
    return self;
}

- (void)dealloc
{

}

#pragma mark Properties

- (void)setMuted:(BOOL)muted
{
    _audioPlayer.volume = muted?0:1;
}

- (BOOL)isMuted
{
    return _audioPlayer.volume == 0;
}

- (BOOL)isPlaying
{
    return _audioPlayer.isPlaying;
}

- (BOOL)isLooping
{
    return _audioPlayer.numberOfLoops == -1;
}

- (BOOL)play
{
    _audioPlayer.numberOfLoops = 0;
    
    if (_soundWillBeginPlayingBlock)
        _soundWillBeginPlayingBlock();

    return [_audioPlayer play];
}

- (BOOL)loop
{
    _audioPlayer.numberOfLoops = -1;
    
    if (_soundWillBeginPlayingBlock)
        _soundWillBeginPlayingBlock();
    
    return [_audioPlayer play];
}

- (void)stop
{
    [_audioPlayer stop];
    _audioPlayer.currentTime = 0.0f;
    [_audioPlayer prepareToPlay];
}

#pragma mark Private Methods

#pragma mark - Protocols and Callbacks

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (_soundDidFinishPlayingBlock)
        _soundDidFinishPlayingBlock();
    
    [_audioPlayer prepareToPlay];
}

@end
