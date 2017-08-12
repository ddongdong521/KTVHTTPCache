//
//  KTVHCPathTools.m
//  KTVHTTPCache
//
//  Created by Single on 2017/8/12.
//  Copyright © 2017年 Single. All rights reserved.
//

#import "KTVHCPathTools.h"
#import "KTVHCURLTools.h"

@implementation KTVHCPathTools

+ (NSString *)pathWithURLString:(NSString *)string offset:(NSInteger)offset
{
    NSString * folderName = [KTVHCURLTools md5:string];
    NSString * fileName = [NSString stringWithFormat:@"%@_%ld", folderName, offset];
    NSString * filePath = [[self KTVHTTPCacheUnitItemDirectory:folderName] stringByAppendingPathComponent:fileName];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    
    return filePath;
}

+ (NSString *)KTVHTTPCacheUnitItemDirectory:(NSString *)folderName
{
    NSString * path = [[self KTVHTTPCacheRootDirectory] stringByAppendingPathComponent:folderName];
    BOOL isDirectory;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExists || !isDirectory) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)KTVHTTPCacheRootDirectory
{
    NSString * path = [[self documentDirectory] stringByAppendingPathComponent:@"KTVHTTPCache"];
    BOOL isDirectory;
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!isExists || !isDirectory) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)documentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
