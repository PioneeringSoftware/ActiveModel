// ActiveModel AMJSONSerializers.h
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

#import <ActiveModel/AMAttributeMethods.h>

extern NSString *const AMRootOptionKey;

/**
 * Answers a JSON construct representing an object's model.
 *
 * Note the subtle but important distinction between asking for an
 * object “as” JSON rather than “to” JSON. Something _as_ JSON produces a
 * dictionary (or hash in Ruby on Rails terms) which lends itself to subsequent
 * JSON rendering. JSON accepts hashes, arrays and primitives only. Hash of
 * primitives therefore forms the bridge between the object proper and its JSON
 * string representation.
 *
 * @param objectWithAttributes An object implementing the
 * `AMAttributeMethods` protocol and hence answers a dictionary of attribute
 * name-value pairs in response to the `-attributes` message.
 * @param options A dictionary of options, including:
 * - `kAMRootOptionKey` Provides a string to use as a root name in place of
 *   the class name-derived element name. If you do not supply a root string,
 *   the function supplies an automatically-generated name using a model name
 *   derived from the class of `objectWithAttributes`; unless your class
 *   answers `[NSNumber numberWithBool:NO]` when sent
 *   `+includesRootInJSON`.
 */
NSDictionary *AMAsJSON(id<AMAttributeMethods> objectWithAttributes, NSDictionary *options);

void AMFromJSON(id<AMAttributeMethods> objectWithAttributes, NSString *JSONString);
