/*
 * Copyright (c) 2011, Casey Marshall. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of The Iconfactory nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE ICONFACTORY BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UIDatePicker.h"


@implementation UIDatePicker

- (id) initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame: frame]) != nil)
    {
        pickerCell = [[NSDatePickerCell alloc] init];
        [pickerCell setDatePickerElements: NSYearMonthDayDatePickerElementFlag | NSHourMinuteDatePickerElementFlag];
        _datePickerMode = UIDatePickerModeDateAndTime;
        CGRect frame2 = frame;
        frame2.origin.x = 0;
        frame2.origin.y = 0;
        cellControl = [[UINSCellControl alloc] initWithFrame: frame2
                                                        cell: pickerCell];
        cellControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview: cellControl];
    }
    return self;
}

#pragma mark -
#pragma mark Property implementations.

- (void) setCalendar:(NSCalendar *)calendar
{
    [pickerCell setCalendar: calendar];
}

- (NSCalendar *) calendar
{
    return [pickerCell calendar];
}

- (void) setCountDownDuration:(NSTimeInterval)countDownDuration
{
    [pickerCell setTimeInterval: countDownDuration * 60];
}

- (NSTimeInterval) countDownDuration
{
    return ([pickerCell timeInterval] / 60);
}

- (void) setDatePickerMode: (UIDatePickerMode) datePickerMode
{
    switch (datePickerMode)
    {
        case UIDatePickerModeCountDownTimer:
            // LAME HACK
            [pickerCell setDatePickerElements: NSHourMinuteDatePickerElementFlag];
            break;

        case UIDatePickerModeTime:
            [pickerCell setDatePickerElements: NSHourMinuteDatePickerElementFlag];
            break;
            
        case UIDatePickerModeDate:
            [pickerCell setDatePickerElements: NSYearMonthDayDatePickerElementFlag];
            break;
            
        case UIDatePickerModeDateAndTime:
            [pickerCell setDatePickerElements: NSYearMonthDayDatePickerElementFlag | NSHourMinuteDatePickerElementFlag];
            break;
            
        default:
            return;
    }
    _datePickerMode = datePickerMode;
}

- (UIDatePickerMode) datePickerMode
{
    return _datePickerMode;
}

- (void) setDate:(NSDate *)date animated:(BOOL)animated
{
    [self setDate: date];
}

- (void) setDate:(NSDate *)date
{
    [pickerCell setDateValue: date];
}

- (NSDate *) date
{
    return [pickerCell dateValue];
}

- (void) setLocale:(NSLocale *)locale
{
    [pickerCell setLocale: locale];
}

- (NSLocale *) locale
{
    return [pickerCell locale];
}

- (void) setMaximumDate:(NSDate *)maximumDate
{
    [pickerCell setMaxDate: maximumDate];
}

- (NSDate *) maximumDate
{
    return [pickerCell maxDate];
}

- (void) setMinimumDate:(NSDate *)minimumDate
{
    [pickerCell setMinDate: minimumDate];
}

- (NSDate *) minimumDate
{
    return [pickerCell minDate];
}

- (void) setMinuteInterval:(NSInteger)minuteInterval
{
}

- (NSInteger) minuteInterval
{
    return 1; // TODO
}

- (void) setTimeZone:(NSTimeZone *)timeZone
{
    [pickerCell setTimeZone: timeZone];
}

- (NSTimeZone *) timeZone
{
    return [pickerCell timeZone];
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [pickerCell release];
    [cellControl release];
    [super dealloc];
}

@end
