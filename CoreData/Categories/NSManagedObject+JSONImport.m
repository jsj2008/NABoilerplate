//
//  NSManagedObject+JSONImport.m
//  Recipes
//
//  Found on http://www.cimgf.com/2011/06/02/saving-json-to-core-data/.
//  Copyright (c) Tom Harrington. All rights reserved.
//

#import "NSManagedObject+JSONImport.h"

@implementation NSManagedObject (JSONImport)

- (void)entityWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
  NSDictionary *attributes = [[self entity] attributesByName];
  for (NSString *attribute in attributes) {
    id value = [keyedValues objectForKey:attribute];
    if (value == nil) {
      continue;
    }
    NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
    if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
      value = [value stringValue];
    } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
      value = [NSNumber numberWithInteger:[value integerValue]];
    } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
      value = [NSNumber numberWithDouble:[value doubleValue]];
    } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
      value = [dateFormatter dateFromString:value];
    }
    [self setValue:value forKey:attribute];
  }
}

@end

