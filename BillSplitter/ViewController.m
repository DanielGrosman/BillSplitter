//
//  ViewController.m
//  BillSplitter
//
//  Created by Daniel Grosman on 2017-11-08.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)billDidChange:(id)sender {
    [self calculateSplitAmount];
}

- (void)calculateSplitAmount {
    NSString *tipString = @"0.15";
    NSDecimalNumber *billAmount = [NSDecimalNumber decimalNumberWithString:self.textField.text];
    NSDecimalNumber *numberOfPeople = [NSDecimalNumber decimalNumberWithString:self.sliderLabel.text];
    NSDecimalNumber *tipPercentage = [NSDecimalNumber decimalNumberWithString:tipString];
    NSDecimalNumber *tipAmount = [billAmount decimalNumberByMultiplyingBy:tipPercentage];
    NSDecimalNumber *newBillAmount = [billAmount decimalNumberByAdding:tipAmount];
    
    NSDecimalNumber *splitBillAmountWithoutTip = [billAmount decimalNumberByDividingBy:numberOfPeople];
    NSDecimalNumber *splitBillAmountWithTip = [newBillAmount decimalNumberByDividingBy:numberOfPeople];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    self.displayLabel.text = [NSString stringWithFormat:@"Without Tip: %@", [numberFormatter stringFromNumber:splitBillAmountWithoutTip]];
    self.tipLabel.text = [NSString stringWithFormat:@"With 15%% Tip: %@", [numberFormatter stringFromNumber:splitBillAmountWithTip]];
}

- (IBAction)sliderChanged:(id)sender{
    int sliderValue;
    sliderValue = roundf(self.slider.value);
    [self.slider setValue:sliderValue animated:YES];
    self.sliderLabel.text = [NSString stringWithFormat:@"%g",self.slider.value];
    [self calculateSplitAmount];
    
}


@end
