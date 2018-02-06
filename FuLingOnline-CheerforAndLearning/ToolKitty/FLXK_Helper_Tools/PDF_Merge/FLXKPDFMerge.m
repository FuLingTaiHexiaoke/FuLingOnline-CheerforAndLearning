//
//  FLXKPDFMerge.m
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 2017/9/27.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#import "FLXKPDFMerge.h"

@implementation FLXKPDFMerge
#pragma mark - Merge PDF IOS - PDF合并



- (void)mergePDF

{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
//    NSString *filePath1 = [Most getSandBoxPathWithName1:[NSString stringWithFormat:@"pdf/%@",@"大班-春夏秋冬-个别化学习活动-科学-活动准备.pdf"]];
//    NSString *filePath2 = [Most getSandBoxPathWithName1:[NSString stringWithFormat:@"pdf/%@",@"大班-春夏秋冬-个别化学习活动-艺术-活动过程.pdf"]];
//    NSString *filePath3 = [Most getSandBoxPathWithName1:[NSString stringWithFormat:@"pdf/%@",@"大班-春夏秋冬-个别化学习活动-艺术-活动设计.pdf"]];
//    
//    NSArray *PDFURLS = [NSArray arrayWithObjects:filePath1,filePath2,filePath3, nil];
//    
//    
//    
//    self.mergedPdfName=[self joinPDF:PDFURLS];
}



- (NSString *)joinPDF:(NSArray *)listOfPaths {
    
    // File paths
    
    NSString *fileName = [NSString stringWithFormat:@"公文%d.pdf",arc4random_uniform(100)];
    
    NSString *pdfPathOutput = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    
    
    CFURLRef pdfURLOutput = (  CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:pdfPathOutput]);
    
    
    
    NSInteger numberOfPages = 0;
    
    // Create the output context
    
    CGContextRef writeContext = CGPDFContextCreateWithURL(pdfURLOutput, NULL, NULL);
    
    
    
    for (NSString *source in listOfPaths) {
        
        CFURLRef pdfURL = (  CFURLRef)CFBridgingRetain([[NSURL alloc] initFileURLWithPath:source]);
        
        
        
        //file ref
        
        CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL((CFURLRef) pdfURL);
        
        numberOfPages = CGPDFDocumentGetNumberOfPages(pdfRef);
        
        
        
        // Loop variables
        
        CGPDFPageRef page;
        
        CGRect mediaBox;
        
        
        
        // Read the first PDF and generate the output pages
        
        //        NSLog(@"GENERATING PAGES FROM PDF 1 (%@)...", source);
        
        for (int i=1; i<=numberOfPages; i++) {
            
            page = CGPDFDocumentGetPage(pdfRef, i);
            
            mediaBox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
            
            CGContextBeginPage(writeContext, &mediaBox);
            
            CGContextDrawPDFPage(writeContext, page);
            
            CGContextEndPage(writeContext);
            
        }
        CGPDFDocumentRelease(pdfRef);
        
        CFRelease(pdfURL);
        
    }
    CFRelease(pdfURLOutput);
    
    // Finalize the output file
    CGPDFContextClose(writeContext);
    CGContextRelease(writeContext);
    return pdfPathOutput;
}
@end
