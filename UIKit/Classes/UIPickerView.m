//
//  UIPickerView.m
//  UIKit
//
//  Created by Peter Steinberger on 23.03.11.
//
/*
 * Copyright (c) 2011, The Iconfactory. All rights reserved.
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

#import "UIPickerView.h"

@implementation UIPickerView

@synthesize showsSelectionIndicator = _showsSelectionIndicator;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

- (void)dealloc
{
    _dataSource = nil;
    _delegate = nil;
    [super dealloc];
}

- (void) setDataSource:(id<UIPickerViewDataSource>)dataSource
{
    _dataSource = dataSource;
    dataSource_flags.has_numberOfComponentsInPickerView = [_dataSource respondsToSelector: @selector(numberOfComponentsInPickerView:)];
    dataSource_flags.has_numberOfRowsInComponent = [_dataSource respondsToSelector: @selector(pickerView:numberOfRowsInComponent:)];
    [self reloadAllComponents];
}

- (id<UIPickerViewDataSource>) dataSource
{
    return _dataSource;
}

- (void) setDelegate:(id<UIPickerViewDelegate>)delegate
{
    _delegate = delegate;
    delegate_flags.has_didSelectRow_inComponent = [_delegate respondsToSelector: @selector(pickerView:didSelectRow:inComponent:)];
    delegate_flags.has_rowHeightForComponent = [_delegate respondsToSelector: @selector(pickerView:rowHeightForComponent:)];
    delegate_flags.has_titleForRow_inComponent = [_delegate respondsToSelector: @selector(pickerView:titleForRow:forComponent:)];
    delegate_flags.has_viewForRow_inComponent_reusingView = [_delegate respondsToSelector: @selector(pickerView:viewForRow:forComponent:reusingView:)];
    delegate_flags.has_widthForComponent = [_delegate respondsToSelector: @selector(pickerView:widthForComponent:)];
}

- (id<UIPickerViewDelegate>) delegate
{
    return _delegate;
}

- (NSInteger) numberOfComponents
{
    NSInteger numberOfComponents = 0;
    if (dataSource_flags.has_numberOfComponentsInPickerView)
    {
        numberOfComponents = [_dataSource numberOfComponentsInPickerView: self];
    }
    return numberOfComponents;
}

- (NSInteger) numberOfRowsInComponent:(NSInteger)component
{
    // FIXME, handle `component' out of range [0,numberOfComponents)
    NSInteger numberOfRows = 0;
    if (dataSource_flags.has_numberOfRowsInComponent)
    {
        numberOfRows = [_dataSource pickerView: self
                       numberOfRowsInComponent: component];
    }
    return  numberOfRows;
}

- (void) reloadAllComponents
{
    for (UIView *view in self.subviews)
        [view removeFromSuperview];
    NSInteger numberOfComponents = [self numberOfComponents];
    for (int i = 0; i < numberOfComponents; i++)
        [self reloadComponent: i];
}

- (void) reloadComponent:(NSInteger)component
{
}

- (CGSize) rowSizeForComponent:(NSInteger)component
{
    CGSize rowSize = CGSizeZero;
    NSInteger numberOfComponents = [self numberOfComponents];
    if (numberOfComponents > 0)
    {
        rowSize.width = self.bounds.size.width / numberOfComponents;
        rowSize.height = self.bounds.size.height;
    }
    if (delegate_flags.has_widthForComponent)
    {
        rowSize.width = [_delegate pickerView: self widthForComponent: component];
    }
    if (delegate_flags.has_rowHeightForComponent)
    {
        rowSize.height = [_delegate pickerView: self rowHeightForComponent: component];
    }
    return rowSize;
}

- (NSInteger) selectedRowInComponent:(NSInteger)component
{
    return -1;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
}

- (UIView *) viewForRow:(NSInteger)row inComponent:(NSInteger)component
{
    return nil;
}

@end
