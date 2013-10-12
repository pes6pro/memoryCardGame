//
//  GameViewController.m
//  GameViewImage
//
//  Created by iOS17 on 10/9/13.
//  Copyright (c) 2013 VT. All rights reserved.
//

#import "GameViewController.h"



@interface GameViewController ()
{
    //NSDictionary *dictionary;
    NSMutableArray *_cards;
    NSMutableArray *_assignments;
    //NSMutableArray *_scores;
    NSMutableArray *_imageviews;

    NSInteger _lastCardIndex,_flippedCards,_currentCardIndex,_pairsFound,_turnsTaken,_scoreInt;
    NSInteger _numberOfRow,_numberOfColumn,_numberOfImage;
    NSTimer *_timer;
    float _timerToOfPic;
}

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initGame];

	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self createGame];
    
}
-(void) initGame
{
    _numberOfRow= 4;
    _numberOfColumn =4;
    
    _numberOfImage = _numberOfColumn*_numberOfRow/2;
    _cards = [NSMutableArray array];
    _imageviews = [NSMutableArray array];
    for (int i =1; i<=_numberOfImage; i++) {
        [_cards addObject:[UIImage imageNamed:[NSString stringWithFormat:@"img%d.png",i]]];
        
    }
    [_cards addObject:[UIImage imageNamed:@"memory.jpg"]];
    [self createCardMemoryWithRow:_numberOfRow andColumn:_numberOfColumn];
}

- (void) createGame
{
    _assignments = [[NSMutableArray alloc]initWithCapacity:_numberOfColumn*_numberOfRow];
    for(int i = 0; i < _numberOfColumn*_numberOfRow; i++){
        
        [_assignments addObject:[[NSNumber alloc] initWithInt:-1 ]];
    }
    
    int ramdom =[[NSString stringWithFormat:@"%d",_numberOfColumn*_numberOfRow] intValue];
    for(int i = 0; i < _numberOfImage; i++){
        
        for(int j = 0; j <2; j++){
            
            //int randomSlot = arc4random() % _numberOfColumn*_numberOfRow;
            int randomSlot = arc4random() % ramdom;
            while([[_assignments objectAtIndex:randomSlot] intValue] != -1){
                randomSlot = arc4random() % ramdom;
            }
            printf("Assigning %d to slot %d\n", i, randomSlot);
            [_assignments replaceObjectAtIndex:randomSlot withObject:[[NSNumber alloc] initWithInteger: i]];
            printf("Slot %d now contains %d\n", randomSlot, [[_assignments objectAtIndex:randomSlot] intValue]);
            
            [[_imageviews objectAtIndex:randomSlot] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateNormal];
            [[_imageviews objectAtIndex:randomSlot] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateDisabled];
            [[_imageviews objectAtIndex:randomSlot] setHidden:NO];
        }
        
    }
    
    _flippedCards = 0;
    
    //Initialize the turns taken and the pairs found labels to 0 every time the user opens the game
    _pairsFound = 0;
    //pairsFoundCounter.text = [NSString stringWithFormat:@"%i",_pairsFound];
    _turnsTaken=0;
    //turnsTakenCounter.text = [NSString stringWithFormat:@"%i",_turnsTaken];
}


- (void) createCardMemoryWithRow : (NSInteger) row andColumn : (NSInteger) column
{
    if (row>4) {
        row =4;
    }
    if (column>4) {
        column =4;
    }
    for (int y = 0; y<row; y++) {
        for (int x = 0; x<column; x++) {
            UIButton *button = [[UIButton alloc] init];
            button.frame =[self CGrectMakeWithx:x*70+25 y:y*90+30 width:60 heigth:60];
            button.tag = x+column*y;
            NSLog(@"tag - = %d",x+column*y);
            [button setImage:[UIImage imageNamed:@"memory.jpg"] forState:UIControlStateNormal];
            [self.view addSubview:button];
            [_imageviews addObject:button];
            [button addTarget:self action:@selector(cardClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    NSLog(@"_imageviews =%@",_imageviews);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cardClicked:(id)sender{

    NSInteger index = [sender tag];
    NSLog(@"btn tag = %d",index);
    [sender setImage:[_cards objectAtIndex:[[_assignments objectAtIndex:index] intValue]] forState:UIControlStateNormal];
    [sender setImage:[_cards objectAtIndex:[[_assignments objectAtIndex:index] intValue]] forState:UIControlStateDisabled];
    
    [sender setEnabled:NO];
    _flippedCards ++;
    
    if(_flippedCards == 2){
        _currentCardIndex = index;
        
        //disable all the cards for the next second
        for(int i = 0; i < _numberOfColumn*_numberOfRow; i++){
            if(i != _lastCardIndex && i != _currentCardIndex){
                [[_imageviews objectAtIndex:i] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateDisabled];
            }
            
            [[_imageviews objectAtIndex:i] setEnabled:NO];
            
        }
        
        //set up a timer to turn the cards back over after 1 second
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(flipCardsBack)
                                       userInfo:nil
                                        repeats:NO];
        
        
        _flippedCards = 0;
    }else{
        _lastCardIndex = index;
    }
    
    
}
- (IBAction)actionBack:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quit game"
                                                    message:@"Are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"Yes"
                                          otherButtonTitles:@"No",nil];
    alert.tag = 0;
    [alert show];
}

- (void) flipCardsBack{
    _turnsTaken++;
    if([[_assignments objectAtIndex:_currentCardIndex] integerValue] ==
       [[_assignments objectAtIndex:_lastCardIndex]integerValue]){
        [[_imageviews objectAtIndex:_currentCardIndex] setHidden: true];
        [[_imageviews objectAtIndex:_lastCardIndex] setHidden: true];
        
        _pairsFound++;
        //pairsFoundCounter.text = [NSString stringWithFormat:@"%i",_pairsFound];
    }else{
        
        [[_imageviews objectAtIndex:_currentCardIndex] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateNormal];
        NSLog(@"curent = %d",_currentCardIndex);
        [[_imageviews objectAtIndex:_currentCardIndex] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateDisabled];
        [[_imageviews objectAtIndex:_lastCardIndex] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateNormal];
        NSLog(@"last = %d",_lastCardIndex);
        [[_imageviews objectAtIndex:_lastCardIndex] setImage:[_cards objectAtIndex:_numberOfImage] forState:UIControlStateDisabled];
    
    }
    //turnsTakenCounter.text = [NSString stringWithFormat:@"%i",_turnsTaken];
    
    //re-enable all the cards
    for(int i = 0; i < _numberOfRow*_numberOfColumn; i++){
        [[_imageviews objectAtIndex:i]setEnabled:YES];
    }
    if(_pairsFound==_numberOfImage){
        [self winGame];
    }
}

-(void)winGame{

    UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:@"Congratulation" message:@"You are winner!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Play again", nil];
    winAlert.tag = 1;
    [winAlert show];

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 && alertView.tag==0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if(buttonIndex == 1 && alertView.tag==1){
        [self initGame];
        [self createGame];
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





//- (void) addImageWithRow : (NSInteger ) row andColumn : (NSInteger) column
//{
//    
//}


@end
