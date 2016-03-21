//
//  ViewController.m
//  XMLResolve
//
//  Created by 刘隆昌 on 16/3/22.
//  Copyright © 2016年 刘隆昌. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString * currentElement;
    NSString * currentValue;
    NSMutableDictionary * rootDic;
    NSMutableArray * finalArray;
    
    
}

@property(nonatomic,retain)NSArray* keyElements;
@property(nonatomic,retain)NSArray* rootElements;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray * keyElements = [[NSArray alloc] initWithObjects:@"message",@"user",nil];
    self.keyElements = keyElements;
    NSArray * rootElements = [[NSArray alloc] initWithObjects:@"message",@"name",@"age",@"school",nil];
    self.rootElements = rootElements;
    NSString * xmlPath = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"xml"];
    NSData * data = [[NSData alloc] initWithContentsOfFile:xmlPath];
    //初始化
    NSXMLParser * xmlParser = [[NSXMLParser alloc] initWithData:data];
    
    //代理
    xmlParser.delegate = self;
    //开始解析
    BOOL flag = [xmlParser parse];
    if (flag) {
        NSLog(@"解析成功");
    }else{
        NSLog(@"解析出错");
    }
    
    
}


#pragma mark 开始解析时
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    finalArray = [[NSMutableArray alloc] init];
}
#pragma mark 发现节点时
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    for (NSString *key in self.keyElements) {
        if ([elementName isEqualToString:key]) {
            rootDic = nil;
            rootDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        }else{
            for (NSString * element in self.rootElements) {
             
                if ([element isEqualToString:element]) {
                    currentElement = elementName;
                    currentValue = [NSString string];
                }
            }
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (currentElement) {
        currentValue = string;
        [rootDic setObject:string forKey:currentElement];
    }
}

#pragma - mark 结束节点时
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if (currentElement) {
        [rootDic setObject:currentValue forKey:currentElement];
        currentElement = nil;
        currentValue = nil;
    }
    
    
    for (NSString * key in self.keyElements) {
        if ([elementName isEqualToString:key]) {
            if (rootDic) {
                [finalArray addObject:rootDic];
            }
        }
    }
    
    
    
}

#pragma - mark 结束解析
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@",finalArray);
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
