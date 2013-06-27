// ActiveModel AMName.m
//
// Copyright © 2011–2013, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "AMName.h"
#import "AMName+Private.h"

#import <ActiveSupport/ActiveSupport.h>

// Use a class continuation to modify the properties, changing readonly to
// “readwrite.” Privately therefore, the class can modify its own properties
// using standard accessors.
@interface AMName()

@property(copy, readwrite, NS_NONATOMIC_IOSONLY) NSString *value;
@property(copy, readwrite, NS_NONATOMIC_IOSONLY) NSString *singular;
@property(copy, readwrite, NS_NONATOMIC_IOSONLY) NSString *plural;
@property(copy, readwrite, NS_NONATOMIC_IOSONLY) NSString *element;

@end

@implementation AMName

@synthesize value    = _value;
@synthesize singular = _singular;
@synthesize plural   = _plural;
@synthesize element  = _element;

// designated initialiser
- (id)initWithString:(NSString *)string
{
	self = [super init];
	if (self)
	{
		// Everything depends on the name. Every other property derives from
		// it. Normally, the name equates to the class name.
		//
		// Regarding singular, underscoring translates dashes to
		// underscores. Here, singularising the name undoes that last step by
		// converting the underscores back to dashes.
		[self setValue:string];
		[self setSingular:[AMName singularize:[self value]]];
		[self setPlural:[[ASInflector defaultInflector] pluralize:[self singular]]];
		[self setElement:ASInflectorUnderscore(ASInflectorDemodulize([self value]))];
	}
	return self;
}

- (id)initWithClass:(Class)aClass
{
	NSString *string = NSStringFromClass(aClass);
	NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:@"^[A-Z]+([A-Z])" options:0 error:NULL];
	return [self initWithString:[re stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@"$1"]];
}

- (NSString *)description
{
	return [self value];
}

@end
