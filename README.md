[![Version](https://cocoapod-badges.herokuapp.com/v/PlayThis/badge.png)](http://cocoadocs.org/docsets/PlayThis) 
[![Platform](https://cocoapod-badges.herokuapp.com/p/PlayThis/badge.png)](http://cocoadocs.org/docsets/PlayThis) 
[![CocoaDocs](https://img.shields.io/badge/docs-%E2%9C%93-blue.svg)](http://cocoadocs.org/docsets/PlayThis) 

![Mobile Jazz PlayThis](https://raw.githubusercontent.com/mobilejazz/metadata/master/images/banners/mobile-jazz-playthis-banner.jpg)

# PlayThis

**PlayThis** is a library to play or loop sounds.

## How To Get PlayThis

The easiest way to add **PlayThis** to your project is using CocoaPods. Add the following line to your Podfile:
```
pod 'PlayThis', '~> 1.0'
```
## Using PlayThis

Use the `PTSoundManager` class to manage and play sounds. First, register sounds the sounds with a unique key:
 
```Objective-C
PTSoundManager *soundManager = [[PTSoundManager alloc] init];
 
[soundManager registerFilePath:[[NSBundle mainBundle] pathForResource:@"MySound_1" ofType:@"mp3"] forKey:@"sound.1"];
[soundManager registerFilePath:[[NSBundle mainBundle] pathForResource:@"MySound_2" ofType:@"mp3"] forKey:@"sound.2"];
[soundManager registerFilePath:[[NSBundle mainBundle] pathForResource:@"MySound_3" ofType:@"mp3"] forKey:@"sound.3"];
```
 
Optionally, load into memory the sounds in order to play them fast. All sounds can be loaded at once or just some subset of them:
 
```Objective-C
// Load all sounds
[soundManager prepareAllSounds];

// Load only the given sounds
[soundManager prepareSoundsWithKeys:@[@"sound.2", @"sound.3"]];
```
 
Finally, play or loop sounds:

```Objective-C
// Play sound 1
[soundManager playSound:@"sound.1"];

// Loop sound 2
[soundManager loopSound:@"sound.2"];

// Stop playing sound 1
[soundManager stopSound:@"sound.1"];

// Stop sound 2 loop
[soundManager stopSound:@"sound.2"];
```
 
Use the methods `-isPlayingSound:` or `-isLoopingSound:` to check the status of a sound playback.

## Project Maintainer

This open source project is maintained by [Joan Martin](https://github.com/vilanovi).

## License

Copyright 2016 Mobile Jazz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
