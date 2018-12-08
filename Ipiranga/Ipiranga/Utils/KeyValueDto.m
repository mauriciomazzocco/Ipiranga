
#import "KeyValueDto.h"

@implementation KeyValueDto

@synthesize key;
@synthesize value;

-(id)initWithCoder:(NSCoder *)decoder
{
    
    if((self = [self init]))
    {
        self.key = [decoder decodeObjectForKey:@"Key"];
        self.value = [decoder decodeObjectForKey:@"Value"];
    }
    
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:key forKey:@"Key"];
    [encoder encodeObject:value forKey:@"Value"];
}

-(NSMutableDictionary *)keyValueDtoToDict {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    [dict setObject:self.key forKey:@"key"];
    [dict setObject:self.value forKey:@"value"];
    
    return dict;
}

- (KeyValueDto *)dictToKeyValueDtoWithDict:(NSDictionary *)dict {
    KeyValueDto *keyValueDtoDto= [[KeyValueDto alloc] init];
    
    if ([dict objectForKey:@"key"] != [NSNull null]) {
        keyValueDtoDto.key = [dict objectForKey:@"key"];
    }
    
    if ([dict objectForKey:@"value"] != [NSNull null]) {
        keyValueDtoDto.value = [dict objectForKey:@"value"];
    }
    
    return keyValueDtoDto;
}

@end
