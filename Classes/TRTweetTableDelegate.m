//
//  TRTweetTableDelegate.m
//  trm
//
//  Created by will bailey on 3/23/10.
//  Copyright 2010 tweetrad.io. All rights reserved.
//
#import "TRTweetTableItemCell.h"
#import "TRTweetTableDelegate.h"

@implementation TRTweetTableDelegate
@synthesize speaker = _speaker;
@synthesize acapelaLicense = _acapelaLicense;

- (id)initWithController:(TTTableViewController*)controller {
  if (self = [super initWithController:controller]) {
    [self enableAcapela];
  }
  return self;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TRTweetTableItemCell *tableItemCell = (TRTweetTableItemCell *)[tableView cellForRowAtIndexPath:indexPath];
  NSString *text = [[tableItemCell tweet] speakableText];
  NSLog(@"%@", text);
  NSLog(@"speaker is:%@", self.speaker);
  [self.speaker startSpeakingString:text];
  NSLog(@"now I'm here");
  //  [[TRPlayer instance] playTweetAtIndexPath:indexPath andScrollTo:YES];
}

- (void)speechSynthesizer:(AcapelaSpeech *)sender didFinishSpeaking: (BOOL)finishedSpeaking{
  NSLog(@"finished");
}; 
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakWord: (NSRange)characterRange ofString:(NSString *)string{
  NSLog(@"will speak word");
};
- (void)speechSynthesizer:(AcapelaSpeech *)sender willSpeakPhoneme: (short)phonemeOpcode{
  
}; 
- (void)speechSynthesizer:(AcapelaSpeech *)sender didEncounterSyncMessage: (NSString *)errorMessage{
  NSLog(@"error:%@",errorMessage);
};



#pragma mark -
#pragma mark acapela setup
- (void)enableAcapela 
{
  NSLog(@"enabling acapela");
  char babLicense[]="\"849 0 ADCT #EVALUATION#Acapela Default Customer Toulouse\"\n\
  Y2ZQNYxUGpgYJ$pgQiAmzVfF29CjyT$dWdrktN5GCtrXL@RcXsNV%SGMXx9kfEKLhHh%ZvKeaUVZ\n\
  WWufzdC5owCY5K5Y46TsfdT4QfgOcQ%WLZ9mIQ##\n\
  ZSqQQeztYUQ%wzmQrdUZ4R##\n\
  ";
  struct Uid { unsigned int userId;unsigned int passwd;} 
  uid={0x01eae4f3,0x0041ab6b};
  
  NSString* aLicenseString = [[NSString alloc] initWithCString:babLicense 
                                                      encoding:NSASCIIStringEncoding]; 
  self.acapelaLicense = [[AcapelaLicense alloc] initLicense:aLicenseString 
                                                       user:uid.userId 
                                                     passwd:uid.passwd];
  [aLicenseString release];
  NSLog(@"number of voices:%d", [[AcapelaSpeech availableVoices] count]);
  self.speaker = [[AcapelaSpeech alloc] initWithVoice:[[AcapelaSpeech availableVoices] objectAtIndex:0] license:self.acapelaLicense];
}



@end
