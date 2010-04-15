//
//  TRTweetTableDelegate.h
//  trm
//
//  Created by will bailey on 3/23/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//
#include "AcapelaSpeech.h"

@interface TRTweetTableDelegate : TTTableViewDragRefreshDelegate {
  BOOL playing;
  AcapelaLicense *_acapelaLicense;
  AcapelaSpeech *_speaker;
}
@property (nonatomic, retain) AcapelaLicense *acapelaLicense;
@property (nonatomic, retain) AcapelaSpeech *speaker;
- (void)enableAcapela;
- (void)speechSynthesizer:(AcapelaSpeech *)sender didFinishSpeaking: (BOOL)finishedSpeaking;
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakWord: (NSRange)characterRange ofString:(NSString *)string;
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakPhoneme: (short)phonemeOpcode;
- (void)speechSynthesizer:(AcapelaSpeech *)sender didEncounterSyncMessage: (NSString *)errorMessage;
@end
